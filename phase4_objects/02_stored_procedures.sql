-- ============================================================
-- PART 2 : STORED PROCEDURES
-- ============================================================


-- ------------------------------------------------------------
-- PROCEDURE 1 : sp_open_account
-- Purpose : Pudhu account create panni opening balance
--           transaction insert panum
-- Parameters:
--   p_customer_id  IN  — existing customer_id
--   p_branch_id    IN  — branch_id
--   p_account_type IN  — SAVINGS/CURRENT/FIXED_DEPOSIT/SALARY
--   p_opening_bal  IN  — opening deposit (min 500)
--   p_account_id   OUT — generated account_id
--   p_message      OUT — SUCCESS / ERROR message
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_open_account (
    p_customer_id  IN  accounts.customer_id%TYPE,
    p_branch_id    IN  accounts.branch_id%TYPE,
    p_account_type IN  accounts.account_type%TYPE,
    p_opening_bal  IN  accounts.balance%TYPE,
    p_account_id   OUT accounts.account_id%TYPE,
    p_message      OUT VARCHAR2
) AS
    v_cust_count   NUMBER;
    v_branch_count NUMBER;
BEGIN
    -- 1. Customer validate
    SELECT COUNT(*) INTO v_cust_count
    FROM   customers
    WHERE  customer_id = p_customer_id;

    IF v_cust_count = 0 THEN
        p_message := 'ERROR: Customer ID ' || p_customer_id || ' not found.';
        RETURN;
    END IF;

    -- 2. Branch validate
    SELECT COUNT(*) INTO v_branch_count
    FROM   branches
    WHERE  branch_id = p_branch_id;

    IF v_branch_count = 0 THEN
        p_message := 'ERROR: Branch ID ' || p_branch_id || ' not found.';
        RETURN;
    END IF;

    -- 3. Minimum balance check
    IF p_opening_bal < 500 THEN
        p_message := 'ERROR: Minimum opening balance is 500.';
        RETURN;
    END IF;

    -- 4. Account create
    INSERT INTO accounts (customer_id, branch_id, account_type,
                          balance, status, opened_date)
    VALUES (p_customer_id, p_branch_id, p_account_type,
            p_opening_bal, 'ACTIVE', SYSDATE)
    RETURNING account_id INTO p_account_id;

    -- 5. Opening deposit transaction
    INSERT INTO transactions (account_id, transaction_type, amount,
                               transaction_date, description, status)
    VALUES (p_account_id, 'DEPOSIT', p_opening_bal,
            SYSDATE, 'Account Opening Deposit', 'SUCCESS');

    COMMIT;
    p_message := 'SUCCESS: Account ID ' || p_account_id ||
                 ' (' || p_account_type || ') opened. Balance: ' || p_opening_bal;
    DBMS_OUTPUT.PUT_LINE(p_message);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_message := 'SYSTEM ERROR: ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(p_message);
END sp_open_account;
/

-- Test
DECLARE
    v_aid NUMBER;
    v_msg VARCHAR2(500);
BEGIN
    sp_open_account(1, 1, 'SAVINGS', 10000, v_aid, v_msg);
    DBMS_OUTPUT.PUT_LINE('New Account ID: ' || v_aid);
END;
/


-- ------------------------------------------------------------
-- PROCEDURE 2 : sp_process_loan_payment
-- Purpose : Loan payment validate and record set
--           fully repaid  auto CLOSED 
-- Parameters:
--   p_loan_id    IN  — loan_id
--   p_amount     IN  — payment amount
--   p_mode       IN  — BANK_TRANSFER/CASH/CHEQUE/ONLINE
--   p_payment_id OUT — generated payment_id
--   p_message    OUT — SUCCESS / ERROR message
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_process_loan_payment (
    p_loan_id    IN  loan_payments.loan_id%TYPE,
    p_amount     IN  loan_payments.amount_paid%TYPE,
    p_mode       IN  loan_payments.payment_mode%TYPE,
    p_payment_id OUT loan_payments.payment_id%TYPE,
    p_message    OUT VARCHAR2
) AS
    v_loan_status  loans.status%TYPE;
    v_principal    loans.principal_amount%TYPE;
    v_total_paid   NUMBER;
    v_outstanding  NUMBER;
BEGIN
    -- 1. Loan exist & status check
    BEGIN
        SELECT status, principal_amount
        INTO   v_loan_status, v_principal
        FROM   loans
        WHERE  loan_id = p_loan_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_message := 'ERROR: Loan ID ' || p_loan_id || ' not found.';
            RETURN;
    END;

    IF v_loan_status NOT IN ('ACTIVE', 'APPROVED') THEN
        p_message := 'ERROR: Loan is ' || v_loan_status ||
                     '. Payment not allowed.';
        RETURN;
    END IF;

    -- 2. Amount validate
    IF p_amount <= 0 THEN
        p_message := 'ERROR: Payment amount must be > 0.';
        RETURN;
    END IF;

    -- 3. Outstanding balance check
    SELECT NVL(SUM(amount_paid), 0)
    INTO   v_total_paid
    FROM   loan_payments
    WHERE  loan_id = p_loan_id;

    v_outstanding := v_principal - v_total_paid;

    IF p_amount > v_outstanding THEN
        p_message := 'ERROR: Payment ' || p_amount ||
                     ' > outstanding balance ' || v_outstanding || '.';
        RETURN;
    END IF;

    -- 4. Insert payment
    INSERT INTO loan_payments (loan_id, amount_paid, payment_date, payment_mode)
    VALUES (p_loan_id, p_amount, SYSDATE, p_mode)
    RETURNING payment_id INTO p_payment_id;

    -- 5. Auto-close if fully repaid
    IF (v_total_paid + p_amount) >= v_principal THEN
        UPDATE loans
        SET    status = 'CLOSED'
        WHERE  loan_id = p_loan_id;
        p_message := 'SUCCESS: Payment ID ' || p_payment_id ||
                     ' recorded. Loan CLOSED — fully repaid.';
    ELSE
        p_message := 'SUCCESS: Payment ID ' || p_payment_id ||
                     ' recorded. Remaining: ' || (v_outstanding - p_amount);
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE(p_message);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_message := 'SYSTEM ERROR: ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(p_message);
END sp_process_loan_payment;
/

-- Test
DECLARE
    v_pid loan_payments.payment_id%TYPE;
    v_msg VARCHAR2(500);
BEGIN
    sp_process_loan_payment(1, 20833, 'ONLINE', v_pid, v_msg);
    DBMS_OUTPUT.PUT_LINE('Payment ID: ' || v_pid);
END;
/


-- ------------------------------------------------------------
-- PROCEDURE 3 : sp_monthly_interest
-- Purpose : ACTIVE SAVINGS accounts- monthly interest credit
-- Parameters:
--   p_interest_rate IN  — annual rate % (default 4.0)
--   p_credited      OUT — credited account count
--   p_message       OUT — summary message
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_monthly_interest (
    p_interest_rate IN  NUMBER DEFAULT 4.0,
    p_credited      OUT NUMBER,
    p_message       OUT VARCHAR2
) AS
    v_interest NUMBER;
    v_count    NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT account_id, balance
        FROM   accounts
        WHERE  account_type = 'SAVINGS'
        AND    status       = 'ACTIVE'
        AND    balance      > 0
    ) LOOP
        -- Monthly interest = annual_rate / 12
        v_interest := ROUND(rec.balance * p_interest_rate / 100 / 12, 2);

        UPDATE accounts
        SET    balance = balance + v_interest
        WHERE  account_id = rec.account_id;

        INSERT INTO transactions (account_id, transaction_type, amount,
                                   transaction_date, description, status)
        VALUES (rec.account_id, 'INTEREST', v_interest,
                SYSDATE, 'Monthly Interest @ ' || p_interest_rate || '% p.a.', 'SUCCESS');

        v_count := v_count + 1;
    END LOOP;

    p_credited := v_count;
    COMMIT;
    p_message := 'SUCCESS: Interest credited to ' || v_count ||
                 ' SAVINGS accounts at ' || p_interest_rate || '% p.a.';
    DBMS_OUTPUT.PUT_LINE(p_message);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_credited := 0;
        p_message  := 'SYSTEM ERROR: ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(p_message);
END sp_monthly_interest;
/

-- Test
DECLARE
    v_cnt NUMBER;
    v_msg VARCHAR2(500);
BEGIN
    sp_monthly_interest(4.0, v_cnt, v_msg);
END;
/
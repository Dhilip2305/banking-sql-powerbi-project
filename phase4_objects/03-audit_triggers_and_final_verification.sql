-- ============================================================
-- PART 4 : AUDIT TABLE + TRIGGERS
-- ============================================================


-- ------------------------------------------------------------
-- Audit log table — Trigger 1 
--
-- ------------------------------------------------------------
CREATE TABLE audit_transactions (
    audit_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    transaction_id   NUMBER,
    account_id       NUMBER,
    transaction_type VARCHAR2(20),
    amount           NUMBER(15, 2),
    action_date      DATE          DEFAULT SYSDATE,
    action_by        VARCHAR2(50)  DEFAULT USER,
    action_type      VARCHAR2(10),
    session_id       NUMBER
);


-- ------------------------------------------------------------
-- TRIGGER 1 : trg_audit_transactions
-- ------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_audit_transactions
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions (
        transaction_id, account_id, transaction_type,
        amount, action_date, action_by,
        action_type, session_id
    ) VALUES (
        :NEW.transaction_id, :NEW.account_id, :NEW.transaction_type,
        :NEW.amount, SYSDATE, USER,
        'INSERT', USERENV('SESSIONID')
    );
END trg_audit_transactions;
/

-- Test
INSERT INTO transactions (account_id, transaction_type, amount,
                           description, status)
VALUES (1, 'DEPOSIT', 5000, 'Trigger Test', 'SUCCESS');
COMMIT;

SELECT * FROM audit_transactions
ORDER BY audit_id DESC
FETCH FIRST 3 ROWS ONLY;


-- ------------------------------------------------------------
-- TRIGGER 2 : trg_update_loan_status
-- Purpose   : loan_payments when record INSERT if total paid
--             >= principal the loan account  auto CLOSED 
-- Timing    : AFTER INSERT — FOR EACH ROW
-- ------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_update_loan_status
AFTER INSERT ON loan_payments
FOR EACH ROW
DECLARE
    v_principal  NUMBER;
    v_total_paid NUMBER;
BEGIN
    SELECT principal_amount
    INTO   v_principal
    FROM   loans
    WHERE  loan_id = :NEW.loan_id;

    SELECT NVL(SUM(amount_paid), 0)
    INTO   v_total_paid
    FROM   loan_payments
    WHERE  loan_id = :NEW.loan_id;

    IF v_total_paid >= v_principal THEN
        UPDATE loans
        SET    status = 'CLOSED'
        WHERE  loan_id = :NEW.loan_id
        AND    status  = 'ACTIVE';
    END IF;
END trg_update_loan_status;
/


-- ------------------------------------------------------------
-- TRIGGER 3 : trg_account_balance_update
-- Purpose   : transactions table-when records  INSERT 
--             account balance automatically update
--   DEPOSIT / INTEREST  → balance + amount
--   WITHDRAWAL / TRANSFER / FEE → balance - amount
-- Timing    : AFTER INSERT — FOR EACH ROW
-- ------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_account_balance_update
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    IF :NEW.transaction_type IN ('DEPOSIT', 'INTEREST') THEN
        UPDATE accounts
        SET    balance = balance + :NEW.amount
        WHERE  account_id = :NEW.account_id;

    ELSIF :NEW.transaction_type IN ('WITHDRAWAL', 'TRANSFER', 'FEE') THEN
        UPDATE accounts
        SET    balance = balance - :NEW.amount
        WHERE  account_id = :NEW.account_id;
    END IF;
END trg_account_balance_update;
/


-- ============================================================
-- PART 5 : FINAL VERIFICATION
-- ============================================================

-- All Views (5 expected, all VALID)
SELECT object_name, object_type, status
FROM   user_objects
WHERE  object_type = 'VIEW'
ORDER BY object_name;

-- All Procedures & Functions (6 expected, all VALID)
SELECT object_name, object_type, status
FROM   user_objects
WHERE  object_type IN ('PROCEDURE', 'FUNCTION')
ORDER BY object_type, object_name;

-- All Triggers (3 expected, all ENABLED)
SELECT trigger_name, trigger_type, triggering_event, status
FROM   user_triggers
ORDER BY trigger_name;

-- All Phase 4 objects in one query
SELECT object_name, object_type, status
FROM   user_objects
WHERE  object_type IN ('VIEW', 'PROCEDURE', 'FUNCTION', 'TRIGGER')
ORDER BY object_type, object_name;

-- Quick row count — all 5 views
SELECT 'vw_branch_summary'       AS view_name, COUNT(*) AS row_count FROM vw_branch_summary       UNION ALL
SELECT 'vw_customer_360'         AS view_name, COUNT(*) AS row_count FROM vw_customer_360         UNION ALL
SELECT 'vw_monthly_transactions' AS view_name, COUNT(*) AS row_count FROM vw_monthly_transactions UNION ALL
SELECT 'vw_loan_portfolio'       AS view_name, COUNT(*) AS row_count FROM vw_loan_portfolio       UNION ALL
SELECT 'vw_account_balances'     AS view_name, COUNT(*) AS row_count FROM vw_account_balances;

-- Phase 4 Complete Check
SELECT 'VIEWS'      AS type, COUNT(*) AS count FROM user_views
WHERE  view_name IN ('VW_BRANCH_SUMMARY','VW_CUSTOMER_360',
                     'VW_MONTHLY_TRANSACTIONS','VW_LOAN_PORTFOLIO',
                     'VW_ACCOUNT_BALANCES')
UNION ALL
SELECT 'PROCEDURES', COUNT(*) FROM user_procedures
WHERE  object_name IN ('SP_OPEN_ACCOUNT',
                       'SP_PROCESS_LOAN_PAYMENT',
                       'SP_MONTHLY_INTEREST')
UNION ALL
SELECT 'FUNCTIONS', COUNT(*) FROM user_procedures
WHERE  object_name IN ('FN_GET_ACCOUNT_BALANCE',
                       'FN_CALCULATE_EMI',
                       'FN_CUSTOMER_RISK_RATING')
UNION ALL
SELECT 'TRIGGERS', COUNT(*) FROM user_triggers
WHERE  trigger_name IN ('TRG_AUDIT_TRANSACTIONS',
                        'TRG_UPDATE_LOAN_STATUS',
                        'TRG_ACCOUNT_BALANCE_UPDATE');

-- ============================================================
-- PHASE 4 COMPLETE
-- 5 Views | 3 Procedures | 3 Functions | 3 Triggers
-- Ready for Phase 5 : Oracle → Power BI Connection
-- ============================================================


SELECT object_name, object_type, status
FROM   user_objects
WHERE  object_type IN ('VIEW','PROCEDURE','TRIGGER')
ORDER  BY object_type, object_name;
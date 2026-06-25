-- ============================================================
-- PART 3 : PL/SQL FUNCTIONS
-- ============================================================


-- ------------------------------------------------------------
-- FUNCTION 1 : fn_get_account_balance
-- Purpose    : It returns account balance
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_get_account_balance (
    p_account_id IN accounts.account_id%TYPE
) RETURN NUMBER AS
    v_balance accounts.balance%TYPE;
BEGIN
    SELECT balance
    INTO   v_balance
    FROM   accounts
    WHERE  account_id = p_account_id;
    RETURN v_balance;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_get_account_balance;
/

-- Test
SELECT account_id,
       fn_get_account_balance(account_id) AS current_balance
FROM   accounts
WHERE  account_type = 'SAVINGS'
FETCH FIRST 5 ROWS ONLY;


-- ------------------------------------------------------------
-- FUNCTION 2 : fn_calculate_emi
-- Purpose    : Standard reducing-balance EMI formula
--              EMI = P × r × (1+r)^n / ((1+r)^n − 1)
-- Parameters : p_principal     — loan amount
--              p_annual_rate   — annual interest % (e.g. 8.5)
--              p_tenure_months — tenure in months (e.g. 240)
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_calculate_emi (
    p_principal     IN NUMBER,
    p_annual_rate   IN NUMBER,
    p_tenure_months IN NUMBER
) RETURN NUMBER AS
    v_monthly_rate NUMBER;
    v_emi          NUMBER;
BEGIN
    v_monthly_rate := p_annual_rate / 12 / 100;

    -- Zero-interest case
    IF v_monthly_rate = 0 THEN
        RETURN ROUND(p_principal / p_tenure_months, 2);
    END IF;

    v_emi := p_principal
             * v_monthly_rate
             * POWER(1 + v_monthly_rate, p_tenure_months)
             / (POWER(1 + v_monthly_rate, p_tenure_months) - 1);

    RETURN ROUND(v_emi, 2);
END fn_calculate_emi;
/

-- Test: 25-Lakh home loan @ 8.5% for 20 years → ~21,736
SELECT fn_calculate_emi(2500000, 8.5, 240) AS monthly_emi FROM DUAL;

-- Combine with loans table
SELECT loan_id, loan_type, principal_amount, interest_rate, tenure_months,
       fn_calculate_emi(principal_amount, interest_rate, tenure_months) AS emi
FROM   loans
WHERE  status = 'ACTIVE'
FETCH FIRST 10 ROWS ONLY;


-- ------------------------------------------------------------
-- FUNCTION 3 : fn_customer_risk_rating
-- Purpose    : It return customers Risk level by finding their loan history

-- Return values:
--   NO_HISTORY    — no loans
--   LOW_RISK      — 0% defaulted
--   MEDIUM_RISK   — 1-25% defaulted
--   HIGH_RISK     — 26-50% defaulted
--   CRITICAL_RISK — 50%+ defaulted
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_customer_risk_rating (
    p_customer_id IN customers.customer_id%TYPE
) RETURN VARCHAR2 AS
    v_total_loans  NUMBER;
    v_defaulted    NUMBER;
    v_default_rate NUMBER;
BEGIN
    SELECT COUNT(*),
           SUM(CASE WHEN status = 'DEFAULTED' THEN 1 ELSE 0 END)
    INTO   v_total_loans, v_defaulted
    FROM   loans
    WHERE  customer_id = p_customer_id;

    IF v_total_loans = 0 THEN
        RETURN 'NO_HISTORY';
    END IF;

    v_default_rate := (v_defaulted / v_total_loans) * 100;

    RETURN CASE
        WHEN v_default_rate = 0   THEN 'LOW_RISK'
        WHEN v_default_rate <= 25 THEN 'MEDIUM_RISK'
        WHEN v_default_rate <= 50 THEN 'HIGH_RISK'
        ELSE                           'CRITICAL_RISK'
    END;
END fn_customer_risk_rating;
/

-- Test
SELECT customer_id,
       fn_customer_risk_rating(customer_id) AS risk_rating
FROM   customers
FETCH FIRST 10 ROWS ONLY;

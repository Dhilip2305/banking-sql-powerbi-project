-- ============================================================
-- Banking SQL Project | Phase 4 — Complete Database Objects
-- Views · Stored Procedures · PL/SQL Functions · Triggers
-- Schema  : bank / banking_user
-- PDB     : XEPDB1
-- Tool    : Oracle SQL Developer / SQL*Plus
-- ============================================================
-- RUN ORDER:
--   Part 1 → Views (5)
--   Part 2 → Stored Procedures (3)
--   Part 3 → PL/SQL Functions (3)
--   Part 4 → Audit Table + Triggers (3)
--   Part 5 → Final Verification
-- ============================================================


-- ============================================================
-- PART 1 : VIEWS
-- ============================================================


-- ------------------------------------------------------------
-- VIEW 1 : vw_branch_summary
-- Purpose : Branch-wise customers, accounts, loans,
--           balance, deposit/withdrawal, default rate — KPI roll-up
-- Power BI : Page 1 — Executive Summary
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_branch_summary AS
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    COUNT(DISTINCT c.customer_id)                                       AS total_customers,
    COUNT(DISTINCT a.account_id)                                        AS total_accounts,
    ROUND(SUM(a.balance), 2)                                            AS total_balance,
    ROUND(AVG(a.balance), 2)                                            AS avg_balance,
    -- Transaction aggregates (for Power BI net position card)
    NVL(SUM(CASE WHEN t.transaction_type = 'DEPOSIT'
                 THEN t.amount END), 0)                                 AS total_deposits,
    NVL(SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL'
                 THEN t.amount END), 0)                                 AS total_withdrawals,
    NVL(SUM(CASE WHEN t.transaction_type = 'DEPOSIT'
                 THEN t.amount END), 0)
    - NVL(SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL'
                   THEN t.amount END), 0)                               AS net_position,
    COUNT(DISTINCT l.loan_id)                                           AS total_loans,
    ROUND(NVL(SUM(l.principal_amount), 0), 2)                          AS total_loan_amount,
    -- Default rate KPI
    SUM(CASE WHEN l.status = 'DEFAULTED' THEN 1 ELSE 0 END)            AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN l.status = 'DEFAULTED' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(DISTINCT l.loan_id), 0) * 100
    , 2)                                                                AS default_rate_pct,
    COUNT(DISTINCT e.employee_id)                                       AS total_employees
FROM branches b
LEFT JOIN customers    c ON b.branch_id   = c.branch_id
LEFT JOIN accounts     a ON c.customer_id = a.customer_id
LEFT JOIN transactions t ON a.account_id  = t.account_id
LEFT JOIN loans        l ON b.branch_id   = l.branch_id
LEFT JOIN employees    e ON b.branch_id   = e.branch_id
GROUP BY b.branch_id, b.branch_name, b.city, b.state;

-- Verify
SELECT branch_name, total_customers, total_balance,
       total_deposits, net_position, default_rate_pct
FROM vw_branch_summary
ORDER BY branch_id;


-- ------------------------------------------------------------
-- VIEW 2 : vw_customer_360
-- Purpose : Customer full profile — branch + accounts + loans
--           age_group, customer_segment (Platinum/Gold/Silver/Bronze)
-- Power BI : Page 1 — Customer detail table / slicer
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_customer_360 AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name                                 AS customer_name,
    c.email,
    c.phone,
    c.city                                                             AS customer_city,
    c.date_of_birth,
    TRUNC(MONTHS_BETWEEN(SYSDATE, c.date_of_birth) / 12)              AS age,
    -- Age group bucket — Power BI slicer
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, c.date_of_birth) / 12)
             BETWEEN 18 AND 30 THEN '18-30 Young'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, c.date_of_birth) / 12)
             BETWEEN 31 AND 45 THEN '31-45 Middle'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, c.date_of_birth) / 12)
             BETWEEN 46 AND 60 THEN '46-60 Senior'
        ELSE '60+ Elder'
    END                                                                AS age_group,
    c.joined_date,
    b.branch_name,
    b.city                                                             AS branch_city,
    b.state,
    COUNT(DISTINCT a.account_id)                                       AS total_accounts,
    ROUND(NVL(SUM(a.balance), 0), 2)                                  AS total_balance,
    -- Customer tier — Power BI conditional formatting
    CASE
        WHEN ROUND(NVL(SUM(a.balance), 0), 2) >= 500000 THEN 'Platinum'
        WHEN ROUND(NVL(SUM(a.balance), 0), 2) >= 200000 THEN 'Gold'
        WHEN ROUND(NVL(SUM(a.balance), 0), 2) >= 80000  THEN 'Silver'
        ELSE 'Bronze'
    END                                                                AS customer_segment,
    COUNT(DISTINCT l.loan_id)                                          AS total_loans,
    ROUND(NVL(SUM(l.principal_amount), 0), 2)                         AS total_loan_amount,
    COUNT(DISTINCT t.transaction_id)                                   AS total_transactions
FROM customers c
JOIN  branches     b ON c.branch_id   = b.branch_id
LEFT JOIN accounts     a ON c.customer_id = a.customer_id
LEFT JOIN loans        l ON c.customer_id = l.customer_id
LEFT JOIN transactions t ON a.account_id  = t.account_id
GROUP BY
    c.customer_id, c.first_name, c.last_name,
    c.email, c.phone, c.city,
    c.date_of_birth, c.joined_date,
    b.branch_name, b.city, b.state;

-- Verify
SELECT customer_name, age_group, customer_segment,
       total_balance, total_loans
FROM vw_customer_360
ORDER BY total_balance DESC
FETCH FIRST 10 ROWS ONLY;


-- ------------------------------------------------------------
-- VIEW 3 : vw_monthly_transactions
-- Purpose : Month-wise transaction summary
--           txn_year / txn_month_num — Power BI time intelligence
-- Power BI : Page 3 — Transaction Analysis (line chart)
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_monthly_transactions AS
SELECT
    TO_CHAR(t.transaction_date, 'YYYY-MM')                            AS txn_month,
    TO_CHAR(t.transaction_date, 'MON-YYYY')                           AS txn_month_label,
    TO_CHAR(t.transaction_date, 'YYYY')                               AS txn_year,
    TO_CHAR(t.transaction_date, 'MM')                                 AS txn_month_num,
    TRUNC(t.transaction_date, 'MM')                                   AS month_start_date,
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    t.transaction_type,
    COUNT(t.transaction_id)                                            AS txn_count,
    ROUND(SUM(t.amount), 2)                                           AS total_amount,
    ROUND(AVG(t.amount), 2)                                           AS avg_amount,
    MIN(t.amount)                                                      AS min_amount,
    MAX(t.amount)                                                      AS max_amount
FROM transactions t
JOIN accounts  a ON t.account_id = a.account_id
JOIN branches  b ON a.branch_id  = b.branch_id
GROUP BY
    TO_CHAR(t.transaction_date, 'YYYY-MM'),
    TO_CHAR(t.transaction_date, 'MON-YYYY'),
    TO_CHAR(t.transaction_date, 'YYYY'),
    TO_CHAR(t.transaction_date, 'MM'),
    TRUNC(t.transaction_date, 'MM'),
    b.branch_id, b.branch_name, b.city, b.state,
    t.transaction_type;

-- Verify
SELECT txn_month, transaction_type, txn_count, total_amount
FROM vw_monthly_transactions
ORDER BY txn_month, transaction_type;


-- ------------------------------------------------------------
-- VIEW 4 : vw_loan_portfolio
-- Purpose : Loan details with repayment progress, remaining balance,
--           annual interest calculation
-- Power BI : Page 2 — Loan Portfolio Analysis
-- Note    : LEFT JOIN on loan_payments (loans without payments
--           also shown, with 0 paid)
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_loan_portfolio AS
SELECT
    l.loan_id,
    c.customer_id,
    c.first_name || ' ' || c.last_name                                AS customer_name,
    b.branch_name,
    b.city,
    l.loan_type,
    l.principal_amount,
    l.interest_rate,
    l.tenure_months,
    l.start_date,
    l.end_date,
    l.status                                                           AS loan_status,
    ROUND(NVL(p.total_paid, 0), 2)                                    AS total_paid,
    ROUND(l.principal_amount - NVL(p.total_paid, 0), 2)               AS remaining_balance,
    ROUND(NVL(p.total_paid, 0)
          / NULLIF(l.principal_amount, 0) * 100, 2)                   AS repayment_pct,
    NVL(p.payment_count, 0)                                           AS payment_count,
    p.last_payment_date,
    MONTHS_BETWEEN(l.end_date, l.start_date)                          AS loan_tenure_months,
    -- Annual interest amount for EMI reference
    ROUND(l.principal_amount * l.interest_rate / 100, 2)              AS annual_interest
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id
JOIN branches  b ON l.branch_id   = b.branch_id
LEFT JOIN (
    SELECT
        loan_id,
        SUM(amount_paid)    AS total_paid,
        COUNT(payment_id)   AS payment_count,
        MAX(payment_date)   AS last_payment_date
    FROM loan_payments
    GROUP BY loan_id
) p ON l.loan_id = p.loan_id;

-- Verify
SELECT loan_type, loan_status, total_paid,
       remaining_balance, repayment_pct
FROM vw_loan_portfolio
ORDER BY remaining_balance DESC;


-- ------------------------------------------------------------
-- VIEW 5 : vw_account_balances
-- Purpose : Account details with customer info, age,
--           last transaction date, customer_segment
-- Power BI : Page 1 — Account type slicer, balance charts
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_account_balances AS
SELECT
    a.account_id,
    a.account_type,
    a.balance,
    a.status                                                           AS account_status,
    a.opened_date,
    TRUNC(MONTHS_BETWEEN(SYSDATE, a.opened_date))                     AS account_age_months,
    ROUND(MONTHS_BETWEEN(SYSDATE, a.opened_date), 0)                  AS account_age_months_rounded,
    c.customer_id,
    c.first_name || ' ' || c.last_name                                AS customer_name,
    c.email,
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    NVL(t.last_txn_date, a.opened_date)                               AS last_transaction_date,
    NVL(t.total_txn_count, 0)                                         AS total_transactions,
    -- Segment consistent with vw_customer_360
    CASE
        WHEN a.balance >= 500000 THEN 'PREMIUM'
        WHEN a.balance >= 100000 THEN 'STANDARD'
        ELSE                          'BASIC'
    END                                                                AS account_segment
FROM accounts  a
JOIN customers c ON a.customer_id = c.customer_id
JOIN branches  b ON a.branch_id   = b.branch_id
LEFT JOIN (
    SELECT
        account_id,
        MAX(transaction_date) AS last_txn_date,
        COUNT(transaction_id) AS total_txn_count
    FROM transactions
    GROUP BY account_id
) t ON a.account_id = t.account_id;

-- Verify
SELECT account_type, account_status, customer_name,
       balance, account_segment
FROM vw_account_balances
ORDER BY balance DESC
FETCH FIRST 10 ROWS ONLY;


-- Check all 5 views created
SELECT view_name FROM user_views ORDER BY view_name;

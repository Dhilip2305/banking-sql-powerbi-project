-- ============================================================
-- PHASE 3 : ADDITIONAL KPI QUERIES — BANKING SQL PROJECT
-- ============================================================


-- Q16: Loan Default Rate % per Branch
-- Oru branch-la ethanai loans defaulted aanachu percentage-la

SELECT b.branch_name,
       COUNT(l.loan_id)                                         AS total_loans,
       SUM(CASE WHEN l.status = 'DEFAULTED' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(
           SUM(CASE WHEN l.status = 'DEFAULTED' THEN 1 ELSE 0 END)
           / COUNT(l.loan_id) * 100, 2
       )                                                        AS default_rate_pct
FROM branches b
JOIN loans l ON b.branch_id = l.branch_id
GROUP BY b.branch_name
ORDER BY default_rate_pct DESC;


-- Q17: Average Account Balance per Branch
-- Oru branch-la average, min, max balance summary

SELECT b.branch_name,
       COUNT(a.account_id)        AS total_accounts,
       ROUND(AVG(a.balance), 2)   AS avg_balance,
       ROUND(SUM(a.balance), 2)   AS total_balance,
       ROUND(MIN(a.balance), 2)   AS min_balance,
       ROUND(MAX(a.balance), 2)   AS max_balance
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY avg_balance DESC;


-- Q18: Employee Salary Summary per Branch
-- Oru branch-la total salary cost, avg salary

SELECT b.branch_name,
       COUNT(e.employee_id)       AS total_employees,
       ROUND(SUM(e.salary), 2)    AS total_salary_cost,
       ROUND(AVG(e.salary), 2)    AS avg_salary,
       ROUND(MIN(e.salary), 2)    AS min_salary,
       ROUND(MAX(e.salary), 2)    AS max_salary
FROM branches b
JOIN employees e ON b.branch_id = e.branch_id
GROUP BY b.branch_name
ORDER BY total_salary_cost DESC;


-- Q19: Total Interest Income per Loan Type
-- Loan type-variya estimated annual interest income

SELECT loan_type,
       COUNT(*)                                    AS loan_count,
       ROUND(SUM(principal_amount), 2)             AS total_principal,
       ROUND(AVG(interest_rate), 2)                AS avg_interest_rate,
       ROUND(SUM(
           principal_amount * interest_rate / 100
       ), 2)                                       AS estimated_annual_interest
FROM loans
WHERE status IN ('ACTIVE', 'CLOSED')
GROUP BY loan_type
ORDER BY estimated_annual_interest DESC;


-- Q20: Customer Age Group Analysis
-- Customer-galai age group-la segment panni percentage kaatu

SELECT age_group,
       COUNT(*)                          AS customer_count,
       ROUND(COUNT(*) * 100.0
           / SUM(COUNT(*)) OVER(), 2)   AS percentage
FROM (
    SELECT CASE
               WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12)
                    BETWEEN 18 AND 30 THEN '18-30 Young'
               WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12)
                    BETWEEN 31 AND 45 THEN '31-45 Middle'
               WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12)
                    BETWEEN 46 AND 60 THEN '46-60 Senior'
               ELSE '60+ Elder'
           END AS age_group
    FROM customers
)
GROUP BY age_group
ORDER BY age_group;


-- Q21: Monthly Loan Disbursement Trend
-- Maadham maadham ethanai loans issue aanachu, total amount

SELECT TO_CHAR(start_date, 'YYYY-MM')   AS loan_month,
       COUNT(*)                         AS loans_issued,
       ROUND(SUM(principal_amount), 2)  AS total_disbursed,
       ROUND(AVG(principal_amount), 2)  AS avg_loan_amount
FROM loans
GROUP BY TO_CHAR(start_date, 'YYYY-MM')
ORDER BY loan_month;


-- Q22: Payment Mode Analysis
-- Ethanai payments online/cash/cheque/bank transfer moolam vandhuchu

SELECT payment_mode,
       COUNT(*)                        AS payment_count,
       ROUND(SUM(amount_paid), 2)      AS total_amount,
       ROUND(AVG(amount_paid), 2)      AS avg_amount,
       ROUND(COUNT(*) * 100.0
           / SUM(COUNT(*)) OVER(), 2) AS usage_pct
FROM loan_payments
GROUP BY payment_mode
ORDER BY payment_count DESC;


-- Q23: Inactive / High Risk Accounts
-- 180 naatkalukku mela transaction nadakaatha accounts

SELECT a.account_id,
       c.first_name || ' ' || c.last_name  AS customer_name,
       b.branch_name,
       a.account_type,
       a.balance,
       MAX(t.transaction_date)             AS last_transaction_date,
       ROUND(SYSDATE - MAX(t.transaction_date)) AS days_inactive
FROM accounts a
JOIN customers    c ON a.customer_id = c.customer_id
JOIN branches     b ON a.branch_id   = b.branch_id
JOIN transactions t ON a.account_id  = t.account_id
GROUP BY a.account_id, c.first_name, c.last_name,
         b.branch_name, a.account_type, a.balance
HAVING MAX(t.transaction_date) < SYSDATE - 180
ORDER BY days_inactive DESC;


-- Q24: Branch Revenue Summary (Fees + Interest)
-- Branch-variya fee income, interest income, deposits, withdrawals

SELECT b.branch_name,
       ROUND(SUM(CASE WHEN t.transaction_type = 'FEE'
                      THEN t.amount ELSE 0 END), 2)   AS fee_income,
       ROUND(SUM(CASE WHEN t.transaction_type = 'INTEREST'
                      THEN t.amount ELSE 0 END), 2)   AS interest_income,
       ROUND(SUM(CASE WHEN t.transaction_type = 'DEPOSIT'
                      THEN t.amount ELSE 0 END), 2)   AS total_deposits,
       ROUND(SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL'
                      THEN t.amount ELSE 0 END), 2)   AS total_withdrawals,
       ROUND(SUM(CASE WHEN t.transaction_type IN ('FEE','INTEREST')
                      THEN t.amount ELSE 0 END), 2)   AS total_revenue
FROM branches b
JOIN accounts     a ON b.branch_id  = a.branch_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY b.branch_name
ORDER BY total_revenue DESC;


-- Q25: DENSE_RANK — Top 3 Employees by Salary within each Branch
-- Branch-la salary-variya top 3 employees

SELECT branch_name, employee_name, job_title, salary, salary_rank
FROM (
    SELECT b.branch_name,
           e.first_name || ' ' || e.last_name  AS employee_name,
           e.job_title,
           e.salary,
           DENSE_RANK() OVER (
               PARTITION BY b.branch_name
               ORDER BY e.salary DESC
           )                                   AS salary_rank
    FROM employees e
    JOIN branches b ON e.branch_id = b.branch_id
)
WHERE salary_rank <= 3
ORDER BY branch_name, salary_rank;


-- Q26: LEAD — Current vs Next Payment per Loan
-- Oru loan-la next payment date matrum amount

SELECT loan_id,
       payment_date                          AS current_payment_date,
       amount_paid,
       LEAD(payment_date) OVER (
           PARTITION BY loan_id
           ORDER BY payment_date
       )                                    AS next_payment_date,
       LEAD(amount_paid) OVER (
           PARTITION BY loan_id
           ORDER BY payment_date
       )                                    AS next_payment_amount
FROM loan_payments
ORDER BY loan_id, payment_date;


-- Q27: Cumulative Loan Repayment % Over Time
-- Loan-la running total payment matrum repayment percentage

SELECT lp.loan_id,
       lp.payment_date,
       lp.amount_paid,
       ROUND(SUM(lp.amount_paid) OVER (
           PARTITION BY lp.loan_id
           ORDER BY lp.payment_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2)                               AS cumulative_paid,
       ROUND(SUM(lp.amount_paid) OVER (
           PARTITION BY lp.loan_id
           ORDER BY lp.payment_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) / MAX(l.principal_amount) OVER (
           PARTITION BY lp.loan_id
       ) * 100, 2)                        AS repayment_pct
FROM loan_payments lp
JOIN loans l ON lp.loan_id = l.loan_id
ORDER BY lp.loan_id, lp.payment_date;


-- ============================================================
-- END OF ADDITIONAL KPI QUERIES  |  Q16 to Q27
-- Total Queries in Phase 3 : 27
-- ============================================================
set lines 100 pages 100

--q6: Customer 360 View — customer + account + loan details
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name   AS customer_name,
       b.branch_name,
       a.account_type,
       a.balance,
       l.loan_type,
       l.principal_amount,
       l.status                              AS loan_status
FROM customers c
JOIN branches  b ON c.branch_id   = b.branch_id
JOIN accounts  a ON c.customer_id = a.customer_id
JOIN loans     l ON c.customer_id = l.customer_id
ORDER BY c.customer_id;

--Q7: Branch-wise total deposits vs withdrawals
SELECT b.branch_name,
       ROUND(SUM(CASE WHEN t.transaction_type = 'DEPOSIT'
                      THEN t.amount ELSE 0 END), 2)     AS total_deposits,
       ROUND(SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL'
                      THEN t.amount ELSE 0 END), 2)     AS total_withdrawals,
       ROUND(SUM(CASE WHEN t.transaction_type = 'DEPOSIT'
                      THEN t.amount ELSE 0 END) -
             SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL'
                      THEN t.amount ELSE 0 END), 2)     AS net_position
FROM branches b
JOIN accounts     a ON b.branch_id  = a.branch_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY b.branch_name
ORDER BY net_position DESC;

--Q8: Top 10 customers by total balance
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name  AS customer_name,
       b.branch_name,
       COUNT(a.account_id)                 AS account_count,
       ROUND(SUM(a.balance), 2)            AS total_balance
FROM customers c
JOIN branches b  ON c.branch_id   = b.branch_id
JOIN accounts a  ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, b.branch_name
ORDER BY total_balance DESC
FETCH FIRST 10 ROWS ONLY;


--Q9: Loan repayment progress per loan
SELECT l.loan_id,
       c.first_name || ' ' || c.last_name   AS customer_name,
       l.loan_type,
       l.principal_amount,
       ROUND(SUM(lp.amount_paid), 2)        AS total_paid,
       ROUND(l.principal_amount
             - SUM(lp.amount_paid), 2)      AS remaining_balance,
       ROUND(SUM(lp.amount_paid)
             / l.principal_amount * 100, 2) AS repayment_pct
FROM loans l
JOIN customers    c  ON l.customer_id = c.customer_id
JOIN loan_payments lp ON l.loan_id   = lp.loan_id
GROUP BY l.loan_id, c.first_name, c.last_name,
         l.loan_type, l.principal_amount
ORDER BY repayment_pct DESC;



--Q10: Defaulted loans — customer & branch details
SELECT c.first_name || ' ' || c.last_name  AS customer_name,
       b.branch_name,
       l.loan_type,
       l.principal_amount,
       l.interest_rate,
       l.start_date,
       ROUND(SUM(lp.amount_paid), 2)        AS amount_paid_so_far
FROM loans l
JOIN customers     c  ON l.customer_id = c.customer_id
JOIN branches      b  ON l.branch_id   = b.branch_id
JOIN loan_payments lp ON l.loan_id     = lp.loan_id
WHERE l.status = 'DEFAULTED'
GROUP BY c.first_name, c.last_name, b.branch_name,
         l.loan_type, l.principal_amount,
         l.interest_rate, l.start_date
ORDER BY l.principal_amount DESC;

SELECT branch_id, branch_name, city, state
FROM branches
ORDER BY state, city;

SELECT b.branch_name, COUNT(c.customer_id) AS total_customers
FROM branches b
JOIN customers c ON b.branch_id = c.branch_id
GROUP BY b.branch_name
ORDER BY total_customers DESC;

SELECT account_type,
       COUNT(*)                    AS total_accounts,
       ROUND(SUM(balance), 2)      AS total_balance,
       ROUND(AVG(balance), 2)      AS avg_balance,
       ROUND(MIN(balance), 2)      AS min_balance,
       ROUND(MAX(balance), 2)      AS max_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;


SELECT transaction_type,
       COUNT(*)               AS txn_count,
       ROUND(SUM(amount), 2)  AS total_amount,
       ROUND(AVG(amount), 2)  AS avg_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

SELECT loan_type, status, COUNT(*) AS count,
       ROUND(SUM(principal_amount)/100000, 2) AS total_lakhs
FROM loans
GROUP BY loan_type, status
ORDER BY loan_type, status;
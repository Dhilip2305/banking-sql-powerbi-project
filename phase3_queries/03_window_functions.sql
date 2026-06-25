set lines 100 pages 100

--Q11: RANK — Top customers by balance per branch
SELECT branch_name, customer_name, total_balance, branch_rank
FROM (
    SELECT b.branch_name,
           c.first_name || ' ' || c.last_name      AS customer_name,
           ROUND(SUM(a.balance), 2)                AS total_balance,
           RANK() OVER (
               PARTITION BY b.branch_name
               ORDER BY SUM(a.balance) DESC
           )                                       AS branch_rank
    FROM customers c
    JOIN branches b ON c.branch_id   = b.branch_id
    JOIN accounts a ON c.customer_id = a.customer_id
    GROUP BY b.branch_name, c.first_name, c.last_name
)
WHERE branch_rank <= 3
ORDER BY branch_name, branch_rank;


--Q12: LAG — Month-over-Month transaction growth
SELECT txn_month,
       total_amount,
       prev_month_amount,
       ROUND(
           (total_amount - prev_month_amount)
           / NULLIF(prev_month_amount, 0) * 100, 2
       ) AS growth_pct
FROM (
    SELECT TO_CHAR(transaction_date, 'YYYY-MM')       AS txn_month,
           ROUND(SUM(amount), 2)                      AS total_amount,
           LAG(ROUND(SUM(amount), 2)) OVER (
               ORDER BY TO_CHAR(transaction_date, 'YYYY-MM')
           )                                          AS prev_month_amount
    FROM transactions
    WHERE transaction_type = 'DEPOSIT'
    GROUP BY TO_CHAR(transaction_date, 'YYYY-MM')
)
ORDER BY txn_month;


--Q13: Running total balance per account
SELECT t.account_id,
       t.transaction_date,
       t.transaction_type,
       t.amount,
       ROUND(SUM(
           CASE WHEN t.transaction_type IN ('DEPOSIT','INTEREST')
                THEN t.amount
                ELSE -t.amount
           END
       ) OVER (
           PARTITION BY t.account_id
           ORDER BY t.transaction_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2)                        AS running_balance
FROM transactions t
ORDER BY t.account_id, t.transaction_date;

--Q14: NTILE — Customer segmentation by balance
SELECT customer_name, total_balance, segment
FROM (
    SELECT c.first_name || ' ' || c.last_name   AS customer_name,
           ROUND(SUM(a.balance), 2)             AS total_balance,
           CASE NTILE(4) OVER (ORDER BY SUM(a.balance))
               WHEN 1 THEN 'Bronze'
               WHEN 2 THEN 'Silver'
               WHEN 3 THEN 'Gold'
               WHEN 4 THEN 'Platinum'
           END                                  AS segment
    FROM customers c
    JOIN accounts a ON c.customer_id = a.customer_id
    GROUP BY c.first_name, c.last_name
)
ORDER BY total_balance DESC;

--Q15: ROW_NUMBER — Latest transaction per account
SELECT account_id, transaction_date,
       transaction_type, amount, description
FROM (
    SELECT account_id, transaction_date,
           transaction_type, amount, description,
           ROW_NUMBER() OVER (
               PARTITION BY account_id
               ORDER BY transaction_date DESC
           ) AS rn
    FROM transactions
)
WHERE rn = 1
ORDER BY account_id;
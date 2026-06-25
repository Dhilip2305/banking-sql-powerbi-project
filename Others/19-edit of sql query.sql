SELECT table_name
FROM user_tables
ORDER BY table_name;

select * from accounts
where branch_id in 6;

SELECT * from transactions ;

-- Pattern repeats for each account (2 rows per account)

-- 51
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (51, 'DEPOSIT',    62000.00, DATE '2024-01-08', 'Salary Credit',         'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (51, 'WITHDRAWAL', 18000.00, DATE '2025-05-14', 'ATM Withdrawal',        'SUCCESS');

-- 52
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (52, 'INTEREST',    7625.00, DATE '2024-03-31', 'Quarterly Interest',    'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (52, 'DEPOSIT',   152500.00, DATE '2023-09-15', 'FD Maturity Credit',   'SUCCESS');

-- 53
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (53, 'DEPOSIT',    78000.00, DATE '2025-01-01', 'Salary Credit',         'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (53, 'FEE',          750.00, DATE '2027-06-30', 'Annual Maintenance Fee','SUCCESS');

-- 54
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (54, 'DEPOSIT',    36000.00, DATE '2023-03-05', 'Cash Deposit',          'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (54, 'TRANSFER',   17000.00, DATE '2023-07-12', 'NEFT Transfer',         'SUCCESS');

-- 55
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (55, 'DEPOSIT',    92000.00, DATE '2023-03-15', 'Business Income',       'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (55, 'WITHDRAWAL', 27000.00, DATE '2023-08-08', 'Cheque Withdrawal',     'SUCCESS');

-- 56
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (56, 'DEPOSIT',    59000.00, DATE '2023-01-15', 'Salary Credit',         'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (56, 'WITHDRAWAL', 14000.00, DATE '2023-05-20', 'ATM Withdrawal',        'SUCCESS');

-- 57
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (57, 'INTEREST',    7250.00, DATE '2023-03-31', 'Quarterly Interest',    'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (57, 'DEPOSIT',   145000.00, DATE '2023-10-01', 'FD Maturity Credit',   'SUCCESS');

-- 58
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (58, 'DEPOSIT',    78000.00, DATE '2023-01-01', 'Salary Credit',         'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (58, 'FEE',          500.00, DATE '2023-06-30', 'Annual Maintenance Fee','SUCCESS');

-- 59
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (59, 'DEPOSIT',    48000.00, DATE '2023-03-12', 'Business Income',       'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (59, 'TRANSFER',   21000.00, DATE '2023-07-28', 'RTGS Transfer',         'SUCCESS');

-- 60
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (60, 'DEPOSIT',    38000.00, DATE '2023-04-22', 'Cash Deposit',          'SUCCESS');
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, status) VALUES (60, 'WITHDRAWAL', 26000.00, DATE '2023-08-15', 'ATM Withdrawal',        'SUCCESS');

-- Continue same pattern...
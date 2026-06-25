-- BRANCH 1 - Cuddalore (customer_id 1-5)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (1,  1, 'HOME',      2500000.00, 8.50, 240, DATE '2020-04-01', DATE '2040-04-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (2,  1, 'PERSONAL',   350000.00, 12.00, 36, DATE '2021-06-01', DATE '2024-06-01', 'CLOSED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (3,  1, 'AUTO',       800000.00, 9.75,  60, DATE '2019-09-01', DATE '2024-09-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (4,  1, 'EDUCATION',  450000.00, 10.50, 84, DATE '2022-01-01', DATE '2029-01-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (5,  1, 'BUSINESS',  1200000.00, 11.25, 60, DATE '2020-07-01', DATE '2025-07-01', 'DEFAULTED');

-- BRANCH 2 - Ramapuram (customer_id 6-10)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (6,  2, 'HOME',      3200000.00, 8.25, 300, DATE '2019-03-01', DATE '2044-03-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (7,  2, 'AUTO',       650000.00, 9.50,  48, DATE '2022-05-01', DATE '2026-05-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (8,  2, 'PERSONAL',   280000.00, 13.00, 24, DATE '2020-08-01', DATE '2022-08-01', 'CLOSED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (9,  2, 'EDUCATION',  550000.00, 10.00, 96, DATE '2021-11-01', DATE '2029-11-01', 'DEFAULTED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (10, 2, 'BUSINESS',  1800000.00, 11.00, 84, DATE '2020-02-01', DATE '2027-02-01', 'ACTIVE');

-- BRANCH 3 - Velachery (customer_id 11-15)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (11, 3, 'HOME',      4500000.00, 8.00, 360, DATE '2018-11-01', DATE '2048-11-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (12, 3, 'PERSONAL',   420000.00, 12.50, 48, DATE '2021-03-01', DATE '2025-03-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (13, 3, 'AUTO',       950000.00, 9.25,  60, DATE '2020-06-01', DATE '2025-06-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (14, 3, 'BUSINESS',   750000.00, 11.50, 36, DATE '2022-09-01', DATE '2025-09-01', 'DEFAULTED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (15, 3, 'EDUCATION',  380000.00, 10.25, 72, DATE '2019-04-01', DATE '2025-04-01', 'CLOSED');

-- BRANCH 4 - Chidambaram (customer_id 16-20)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (16, 4, 'HOME',      2800000.00, 8.75, 240, DATE '2021-08-01', DATE '2041-08-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (17, 4, 'AUTO',       720000.00, 9.00,  60, DATE '2022-02-01', DATE '2027-02-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (18, 4, 'PERSONAL',   500000.00, 11.75, 60, DATE '2019-12-01', DATE '2024-12-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (19, 4, 'EDUCATION',  620000.00, 10.75, 96, DATE '2022-04-01', DATE '2030-04-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (20, 4, 'BUSINESS',  2200000.00, 10.50, 120,DATE '2018-06-01', DATE '2028-06-01', 'DEFAULTED');

-- BRANCH 5 - Guindy (customer_id 21-25)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (21, 5, 'HOME',      5500000.00, 7.75, 360, DATE '2017-09-01', DATE '2047-09-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (22, 5, 'PERSONAL',   480000.00, 12.75, 36, DATE '2022-07-01', DATE '2025-07-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (23, 5, 'AUTO',      1100000.00, 9.50,  72, DATE '2020-11-01', DATE '2026-11-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (24, 5, 'EDUCATION',  280000.00, 10.00, 60, DATE '2022-08-01', DATE '2027-08-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (25, 5, 'BUSINESS',  3000000.00, 10.75, 120,DATE '2019-01-01', DATE '2029-01-01', 'DEFAULTED');

-- BRANCH 6 - Saligramam (customer_id 26-30)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (26, 6, 'HOME',      3800000.00, 8.25, 300, DATE '2020-10-01', DATE '2045-10-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (27, 6, 'AUTO',       580000.00, 9.75,  48, DATE '2021-04-01', DATE '2025-04-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (28, 6, 'PERSONAL',   650000.00, 11.50, 60, DATE '2018-08-01', DATE '2023-08-01', 'CLOSED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (29, 6, 'EDUCATION',  420000.00, 10.50, 84, DATE '2021-12-01', DATE '2028-12-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (30, 6, 'BUSINESS',  1500000.00, 11.25, 60, DATE '2020-05-01', DATE '2025-05-01', 'DEFAULTED');

-- BRANCH 7 - Koramangala (customer_id 31-35)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (31, 7, 'HOME',      4200000.00, 8.50, 360, DATE '2019-02-01', DATE '2049-02-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (32, 7, 'PERSONAL',   390000.00, 12.25, 48, DATE '2022-03-01', DATE '2026-03-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (33, 7, 'AUTO',       880000.00, 9.25,  60, DATE '2021-07-01', DATE '2026-07-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (34, 7, 'EDUCATION',  510000.00, 10.25, 96, DATE '2022-06-01', DATE '2030-06-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (35, 7, 'BUSINESS',  2500000.00, 10.50, 84, DATE '2018-10-01', DATE '2025-10-01', 'DEFAULTED');

-- BRANCH 8 - Indiranagar (customer_id 36-40)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (36, 8, 'HOME',      3600000.00, 8.00, 300, DATE '2020-01-01', DATE '2045-01-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (37, 8, 'AUTO',       760000.00, 9.50,  60, DATE '2021-09-01', DATE '2026-09-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (38, 8, 'PERSONAL',   320000.00, 13.00, 24, DATE '2019-05-01', DATE '2021-05-01', 'CLOSED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (39, 8, 'EDUCATION',  680000.00, 10.75, 96, DATE '2022-10-01', DATE '2030-10-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (40, 8, 'BUSINESS',  1900000.00, 11.00, 72, DATE '2020-04-01', DATE '2026-04-01', 'DEFAULTED');

-- BRANCH 9 - Bellandur (customer_id 41-45)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (41, 9, 'HOME',      4800000.00, 7.90, 360, DATE '2018-12-01', DATE '2048-12-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (42, 9, 'PERSONAL',   460000.00, 12.00, 48, DATE '2021-05-01', DATE '2025-05-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (43, 9, 'AUTO',       990000.00, 9.00,  72, DATE '2019-08-01', DATE '2025-08-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (44, 9, 'BUSINESS',  1600000.00, 11.75, 60, DATE '2022-01-01', DATE '2027-01-01', 'DEFAULTED');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (45, 9, 'EDUCATION',  340000.00, 10.00, 72, DATE '2020-03-01', DATE '2026-03-01', 'CLOSED');

-- BRANCH 10 - Jubilee Hills (customer_id 46-50)
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (46, 10, 'HOME',     5200000.00, 7.85, 360, DATE '2019-06-01', DATE '2049-06-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (47, 10, 'AUTO',      840000.00, 9.25,  60, DATE '2022-08-01', DATE '2027-08-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (48, 10, 'PERSONAL',  580000.00, 11.25, 60, DATE '2020-09-01', DATE '2025-09-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (49, 10, 'EDUCATION', 720000.00, 10.50, 96, DATE '2022-11-01', DATE '2030-11-01', 'ACTIVE');
INSERT INTO loans (customer_id, branch_id, loan_type, principal_amount, interest_rate, tenure_months, start_date, end_date, status) VALUES (50, 10, 'BUSINESS', 2800000.00, 10.25, 120,DATE '2017-05-01', DATE '2027-05-01', 'DEFAULTED');

COMMIT;

-- Verify
SELECT loan_type, status, COUNT(*) AS count,
       ROUND(SUM(principal_amount)/100000, 2) AS total_lakhs
FROM loans
GROUP BY loan_type, status
ORDER BY loan_type, status;
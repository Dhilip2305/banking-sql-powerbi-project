-- 2 employees per branch (branch_id 1 to 10)
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (1,  'Arjun',   'Sharma',    'Branch Manager',      75000, DATE '2015-04-10');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (1,  'Priya',   'Ramesh',    'Relationship Manager',52000, DATE '2017-08-22');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (2,  'Karthik', 'Venkat',    'Branch Manager',      78000, DATE '2014-06-15');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (2,  'Divya',   'Nair',      'Loan Officer',        48000, DATE '2018-03-11');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (3,  'Rohan',   'Mehta',     'Branch Manager',      80000, DATE '2013-09-05');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (3,  'Sneha',   'Patil',     'Relationship Manager',55000, DATE '2016-11-30');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (4,  'Vikram',  'Desai',     'Branch Manager',      76000, DATE '2015-01-20');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (4,  'Anjali',  'Shah',      'Teller',              38000, DATE '2019-07-14');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (5,  'Rahul',   'Gupta',     'Branch Manager',      82000, DATE '2012-05-18');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (5,  'Pooja',   'Singh',     'Loan Officer',        50000, DATE '2017-02-28');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (6,  'Amit',    'Kumar',     'Branch Manager',      77000, DATE '2014-10-12');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (6,  'Meena',   'Joshi',     'Relationship Manager',53000, DATE '2018-06-05');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (7,  'Suresh',  'Rao',       'Branch Manager',      79000, DATE '2013-03-25');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (7,  'Kavya',   'Reddy',     'Teller',              36000, DATE '2020-01-08');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (8,  'Naveen',  'Krishnan',  'Branch Manager',      81000, DATE '2012-08-30');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (8,  'Lakshmi', 'Iyer',      'Loan Officer',        49000, DATE '2016-04-17');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (9,  'Ravi',    'Teja',      'Branch Manager',      74000, DATE '2016-07-22');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (9,  'Swathi',  'Chandra',   'Relationship Manager',51000, DATE '2019-09-13');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (10, 'Deepak',  'Verma',     'Branch Manager',      76000, DATE '2017-12-01');
INSERT INTO employees (branch_id, first_name, last_name, job_title, salary, hire_date) VALUES (10, 'Nithya',  'Pillai',    'Teller',              37000, DATE '2021-03-15');

COMMIT;

-- Verify
SELECT employee_id, first_name, last_name, job_title, branch_id 
FROM employees 
ORDER BY branch_id;
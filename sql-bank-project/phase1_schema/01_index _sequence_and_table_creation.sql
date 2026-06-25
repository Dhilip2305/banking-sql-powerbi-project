set LINESIZE 100 PAGESIZE 100 
show user;
-- Grants  check
SELECT privilege
FROM session_privs
ORDER BY privilege;

-- Primary key sequences for all 7 tables
CREATE SEQUENCE seq_branch_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
CREATE SEQUENCE seq_employee_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
CREATE SEQUENCE seq_customer_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
CREATE SEQUENCE seq_account_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
CREATE SEQUENCE seq_transaction_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
CREATE SEQUENCE seq_loan_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
CREATE SEQUENCE seq_payment_id
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
    
--verify sequences
    
SELECT sequence_name, min_value, max_value, increment_by, cycle_flag
FROM user_sequences
ORDER BY sequence_name;

--TABLE CREATION
--TABLE1-BRACHES
CREATE TABLE branches (
    branch_id        NUMBER DEFAULT seq_branch_id.NEXTVAL PRIMARY KEY,
    branch_name      VARCHAR2(100) NOT NULL,
    city             VARCHAR2(50)  NOT NULL,
    state            VARCHAR2(50)  NOT NULL,
    phone            VARCHAR2(15),
    established_date DATE DEFAULT SYSDATE
);

--TABLE2-EMPLOYEES
CREATE TABLE employees (
    employee_id  NUMBER DEFAULT seq_employee_id.NEXTVAL PRIMARY KEY,
    branch_id    NUMBER NOT NULL,
    first_name   VARCHAR2(50)   NOT NULL,
    last_name    VARCHAR2(50)   NOT NULL,
    job_title    VARCHAR2(100),
    salary       NUMBER(12, 2)  NOT NULL,
    hire_date    DATE DEFAULT SYSDATE,
    CONSTRAINT fk_emp_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

--TABLE3-CUSTOMERS
CREATE TABLE customers (
    customer_id   NUMBER DEFAULT seq_customer_id.NEXTVAL PRIMARY KEY,
    branch_id     NUMBER NOT NULL,
    first_name    VARCHAR2(50)  NOT NULL,
    last_name     VARCHAR2(50)  NOT NULL,
    email         VARCHAR2(100) UNIQUE NOT NULL,
    phone         VARCHAR2(15),
    city          VARCHAR2(50),
    date_of_birth DATE,
    joined_date   DATE DEFAULT SYSDATE,
    CONSTRAINT fk_cust_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

--TABLE4-ACCOUNTS
CREATE TABLE accounts (
    account_id   NUMBER DEFAULT seq_account_id.NEXTVAL PRIMARY KEY,
    customer_id  NUMBER NOT NULL,
    branch_id    NUMBER NOT NULL,
    account_type VARCHAR2(20) NOT NULL
        CONSTRAINT chk_acc_type
        CHECK (account_type IN ('SAVINGS','CURRENT','FIXED_DEPOSIT','SALARY')),
    balance      NUMBER(15, 2) DEFAULT 0 NOT NULL,
    status       VARCHAR2(10) DEFAULT 'ACTIVE'
        CONSTRAINT chk_acc_status
        CHECK (status IN ('ACTIVE','INACTIVE','CLOSED','FROZEN')),
    opened_date  DATE DEFAULT SYSDATE,
    CONSTRAINT fk_acc_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_acc_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

--TABLE5 TRANSACTION
CREATE TABLE transactions (
    transaction_id   NUMBER DEFAULT seq_transaction_id.NEXTVAL PRIMARY KEY,
    account_id       NUMBER NOT NULL,
    transaction_type VARCHAR2(20) NOT NULL
        CONSTRAINT chk_txn_type
        CHECK (transaction_type IN
               ('DEPOSIT','WITHDRAWAL','TRANSFER','INTEREST','FEE')),
    amount           NUMBER(15, 2) NOT NULL,
    transaction_date DATE DEFAULT SYSDATE,
    description      VARCHAR2(200),
    status           VARCHAR2(10) DEFAULT 'SUCCESS'
        CONSTRAINT chk_txn_status
        CHECK (status IN ('SUCCESS','FAILED','PENDING')),
    CONSTRAINT fk_txn_account
        FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

--TABLE6-LOANS
CREATE TABLE loans (
    loan_id          NUMBER DEFAULT seq_loan_id.NEXTVAL PRIMARY KEY,
    customer_id      NUMBER NOT NULL,
    branch_id        NUMBER NOT NULL,
    loan_type        VARCHAR2(30) NOT NULL
        CONSTRAINT chk_loan_type
        CHECK (loan_type IN
               ('HOME','PERSONAL','AUTO','EDUCATION','BUSINESS')),
    principal_amount NUMBER(15, 2) NOT NULL,
    interest_rate    NUMBER(5, 2)  NOT NULL,
    tenure_months    NUMBER(3)     NOT NULL,
    start_date       DATE DEFAULT SYSDATE,
    end_date         DATE,
    status           VARCHAR2(15) DEFAULT 'ACTIVE'
        CONSTRAINT chk_loan_status
        CHECK (status IN
               ('ACTIVE','CLOSED','DEFAULTED','APPROVED','REJECTED')),
    CONSTRAINT fk_loan_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_loan_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

--TABLE7-LOAN PAYMENT
CREATE TABLE loan_payments (
    payment_id   NUMBER DEFAULT seq_payment_id.NEXTVAL PRIMARY KEY,
    loan_id      NUMBER NOT NULL,
    amount_paid  NUMBER(15, 2) NOT NULL,
    payment_date DATE DEFAULT SYSDATE,
    payment_mode VARCHAR2(20) DEFAULT 'BANK_TRANSFER'
        CONSTRAINT chk_pay_mode
        CHECK (payment_mode IN
               ('BANK_TRANSFER','CASH','CHEQUE','ONLINE')),
    CONSTRAINT fk_pay_loan
        FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

SELECT * FROM TAB;


--create indexes for performance query
-- Customer lookups by branch
CREATE INDEX idx_customers_branch    ON customers(branch_id);
 
-- Account lookups by customer
CREATE INDEX idx_accounts_customer   ON accounts(customer_id);
 
-- Transaction filtering by date (most used in Power BI)
CREATE INDEX idx_transactions_date   ON transactions(transaction_date);
 
-- Transaction filtering by account
CREATE INDEX idx_transactions_accid  ON transactions(account_id);
 
-- Loan lookups by customer
CREATE INDEX idx_loans_customer      ON loans(customer_id);
 
-- Loan filtering by status (ACTIVE / DEFAULTED / CLOSED)
CREATE INDEX idx_loans_status        ON loans(status);
 
-- Payment lookups by loan
CREATE INDEX idx_loan_payments_loan  ON loan_payments(loan_id);

--Check All Tables Exist
SELECT table_name
FROM user_tables
ORDER BY table_name;

--Check All Sequences Exist
SELECT sequence_name
FROM user_sequences
ORDER BY sequence_name;

-- Check All Constraints
SELECT constraint_name, constraint_type, table_name, status
FROM user_constraints
WHERE table_name IN ('BRANCHES','EMPLOYEES','CUSTOMERS',
                     'ACCOUNTS','TRANSACTIONS','LOANS','LOAN_PAYMENTS')
ORDER BY table_name;

-- Quick Row Count After Data Load (Phase 2)
SELECT 'BRANCHES'      AS tbl, COUNT(*) AS rows FROM branches      UNION ALL
SELECT 'EMPLOYEES'     AS tbl, COUNT(*) AS rows FROM employees      UNION ALL
SELECT 'CUSTOMERS'     AS tbl, COUNT(*) AS rows FROM customers      UNION ALL
SELECT 'ACCOUNTS'      AS tbl, COUNT(*) AS rows FROM accounts       UNION ALL
SELECT 'TRANSACTIONS'  AS tbl, COUNT(*) AS rows FROM transactions   UNION ALL
SELECT 'LOANS'         AS tbl, COUNT(*) AS rows FROM loans          UNION ALL
SELECT 'LOAN_PAYMENTS' AS tbl, COUNT(*) AS rows FROM loan_payments;


-- Test Sequence is Working
-- Insert one test branch to confirm sequence fires
INSERT INTO branches (branch_name, city, state, phone)
VALUES ('Main Branch', 'Chennai', 'Tamil Nadu', '044-12345678');
 
SELECT branch_id, branch_name, city FROM branches;
 
-- Rollback the test row (we will insert real data in Phase 2)



show CON_NAME;
show user;

-- switch the CDB$ROOT INTO PDB
ALTER SESSION SET CONTAINER=XEPDB1;
--VERIFY NOW U ARE IN XEPDB1
show CON_NAME;
-- STEP1.create a new user and grant acces
CREATE USER bank IDENTIFIED BY Banking123;
--Step 2: Set default tablespace and unlimited storage quota
ALTER USER bank DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;
-- Step 3: Set temporary tablespace
ALTER USER bank
    TEMPORARY TABLESPACE temp;
    
-- Allow the user to connect (login)
GRANT CREATE SESSION TO bank;
 
-- Allow creating tables, views, sequences, procedures, triggers
GRANT RESOURCE TO bank;
 
-- Shortcut: CONNECT role includes CREATE SESSION
GRANT CONNECT TO bank;

-- Create and manage views
GRANT CREATE VIEW TO bank;
 
-- Create sequences (for auto-increment PKs)
GRANT CREATE SEQUENCE TO bank;
 
-- Create stored procedures and functions
GRANT CREATE PROCEDURE TO bank;
 
-- Create triggers
GRANT CREATE TRIGGER TO bank;
 
-- Execute DBMS packages (needed for some PL/SQL)
GRANT EXECUTE ON DBMS_OUTPUT TO bank;

SELECT username, account_status FROM dba_users
WHERE username = 'BANK';

SELECT username FROM dba_users;

drop user
bank CASCADE;
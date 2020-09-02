--                                          Connect to HR
/*
C:\Users\name_user> sqlplus / as sysdba;                              - connect to SQL Plus
SQL>                alter session set “_oracle_script”=true;          - alter session
SQL>                create user hr identified by hr account unlock;   - create user
SQL>                grant dba to hr;                                  - user rights
SQL>                conn hr/hr;                                       - connected user
SQL>                @hr.sql                                       
*/

--                                          Data types:
--                    INTEGER
--                                          NUMBER(p, s)

-- NUMBER(7, 2) - 12345,67

--                                          ALPHANUMERIC

-- CHAR(8) - Hello - Hello___
-- VARCHAR2(8) - Hello - Hello

--                                          DATE and TIME
-- DATE - 23-JUL-07 16:08:15 - (year, month, day, hour, minute, second)
-- TIMESTAMP(f) - TIMESTAMP(3) - 23-JUL-07 16:08:15:123 - (year, month, day, hour, minute, second, fraction of a second)

--                                          NULL concept
-- Lack of any data

--                                          SQL commands:
-- DMS - data manipulation language
-- SELECT
-- INSERT
-- UPDATE
-- DELETE
-- MERGE

-- DDL - data definition landuage
-- CREATE
-- ALTER
-- DROP
-- RENAME
-- TRUNCATE

-- TCL - transaction control language
-- COMMIT
-- ROLLBACK
-- SAVEPOINT

-- DCL - data control language
-- GRANT
-- REVOKE

--                                          DESCRIBE command
-- Data dictionary - information about a table in a schema
-- DESCRIBE SCHEMA.TABLE_NAME;

DESCRIBE HR.EMPLOYEES;
-- or
desc employees;
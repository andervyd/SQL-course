--                                          DML COMMANDS
--                                  (data manipulation language)
-- Constrain - rules for INSERT

-- INSERT     (values)       (33 st)
-- INSERT     (subquery)     (104 st)
-- INSERT ALL (multy tables) (135 st)

-- Errors when using DML     (183 st)

-- UPDATE                    (198 st)
-- UPDATE WITH SUBQUERY      (218 st)

-- DELETE                    (245 st)
-- DELETE WITH SUBQUERY      (270 st)

-- MERGE                     (290 st)

--                                          TCL COMMANDS

-- ACID                      (341 st)
-- TRANSACTIONS              (347 st)

-- COMMIT                    (350 st)
-- ROLLBACK                  (371 st)
-- SAVEPOINT                 (452 st)

-- AUTOCOMMIT                (482 st)

-- SELECT FOR UPDATE         (499 st)


--                                          INSERT (values)

-- INSERT INTO table_name
--             column(s)
-- VALUES (value(s));

SELECT * 
FROM countries;

INSERT INTO countries
VALUES ('SW', 'Sweden', 1);

SELECT * 
FROM countries
WHERE country_id = 'SW';

----
INSERT INTO countries
VALUES ('NR', 'Norway', 1);               -- NOT CORRECT

INSERT INTO countries
    (country_id, country_name, region_id)
VALUES ('NR', 'Norway', 5);               -- NOT WORK (not 5 region)

INSERT INTO countries
    (country_id, country_name, region_id)
VALUES ('NR', 'Norway', 1);               -- CORRECT

SELECT * 
FROM countries
WHERE country_id = 'NR';

----
INSERT INTO countries
    (region_id, country_name, country_id)
VALUES (1, 'Ukraine', 'UA');

SELECT * 
FROM countries
WHERE country_id = 'UA';

----
INSERT INTO countries
    (country_id, country_name)
VALUES ('PR', 'Portugal');

SELECT * 
FROM countries
WHERE country_id = 'PR';

----
INSERT INTO countries
VALUES ('FL', 'Finland', NULL);

SELECT * 
FROM countries
WHERE country_id = 'FL';

----
SELECT *
FROM employees;

INSERT INTO employees
    (employee_id, last_name, email, hire_date, job_id)
VALUES (207, 'Tregulov', 'TREGULOV', '18-JUN-19', 'IT_PROG');  -- NOT CORRECT

INSERT INTO employees
    (employee_id, last_name, email, hire_date, job_id)
VALUES (208, INITCAP('Konovalov'), UPPER('KONOVALOV'), 
        TO_DATE('18-JUN-19', 'DD-MON-YY'), UPPER('IT_PROG'));  -- CORRECT

--                                          INSERT (subquery)

-- INSERT INTO table_name
--             column(s)
-- SUBQUERY;

CREATE TABLE new_employees (
    employees_id INTEGER,
    name VARCHAR2(20),
    start_date DATE,
    job VARCHAR2(5));

INSERT INTO new_employees
    (employees_id, name, start_date) (
    SELECT employee_id, 
           first_name,
           hire_date
    FROM employees
    WHERE first_name LIKE 'A%');

INSERT INTO new_employees (
    SELECT employee_id, 
           first_name,
           hire_date,
           job_id
    FROM employees
    WHERE LENGTH(job_id) <= 5);

SELECT *
FROM new_employees;

--                                          INSERT ALL (multy tables)

-- INSERT ALL
-- WHEN condition(s) THEN  
-- INTO table_name_1 (column(s)) VALUES (column(s))
-- WHEN condition(s) THEN  
-- INTO table_name_2 (column(s)) VALUES (column(s))
-- WHEN condition(s) THEN  
-- INTO table_name_N (column(s)) VALUES (column(s))
--   SELECT column(s)
--   FROM table_name
--   WHERE condition(s);

CREATE TABLE employees_high_salary(
    first_name VARCHAR2(20),
    last_name VARCHAR2(30),
    salary INTEGER);

SELECT *
FROM employees_high_salary;

CREATE TABLE employees_department_100(
    first_name VARCHAR2(20),
    last_name VARCHAR2(30),
    salary INTEGER);

SELECT *
FROM employees_department_100;

CREATE TABLE employees_name_A(
    first_name VARCHAR2(20),
    last_name VARCHAR2(30),
    salary INTEGER);

SELECT *
FROM employees_name_A;

INSERT ALL
WHEN department_id = 100 THEN
INTO employees_department_100 VALUES (first_name, last_name, salary)
WHEN salary > 15000 THEN
INTO employees_high_salary (last_name, salary) VALUES (last_name, salary)
WHEN first_name LIKE 'A%' THEN
INTO employees_name_A VALUES (first_name, last_name, salary)
    SELECT first_name, last_name, salary, department_id
    FROM employees
    WHERE LENGTH(first_name) > 5;

--                                          Errors when using DML

SELECT * FROM employees WHEER employee_id = 100;  -- syntax error (WHEER)
SELECT * FROM employees WHERE employee_id = 100;

----
SELECT * FROM employees WHERE hire_date = '17-06-87';   -- syntax error (-06-)
SELECT * FROM employees WHERE hire_date = '17-JUN-87';  -- NOT CORRECT 
SELECT * FROM employees WHERE hire_date = TO_DATE('17-JUN-87', 'DD-MON-RR');

----
INSERT INTO countries
    (country_id, country_name, region_id)
VALUES ('NR', 'Norway', 5);               -- NOT WORK (not 5 region)

--                                          UPDATE

-- UPDATE table_name
-- SET
-- column(s) = value(s)
-- WHERE condition(s);

SELECT *
FROM employees;

UPDATE employees
SET salary = 25000
WHERE employee_id = 100;

----
UPDATE employees
SET first_name = 'Alexey',
    salary = 14000
WHERE employee_id = 208;

--                                          UPDATE WITH SUBQUERY

-- UPDATE table_name
-- SET
-- column(s) = subquery(s)
-- WHERE column = subquery;

SELECT *
FROM employees;

UPDATE employees
SET salary = 10000
WHERE department_id IN (
      SELECT department_id
      FROM departments
      WHERE INITCAP(department_name) = 'Marketing');

----
UPDATE employees
SET salary = (
    SELECT MAX(salary) - 5000
    FROM employees),
        hire_date = (
        SELECT MIN(start_date)
        FROM job_history)
WHERE employee_id = 202;        

--                                          DELETE

-- DELETE
-- FROM table_name
-- WHERE condition(s); 

SELECT *
FROM employees;

INSERT INTO employees
    (employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES (209, INITCAP('Ivan'), INITCAP('Tara'), UPPER('TARA'), TO_DATE('17-JUN-98', 'DD-MON-RR'), UPPER('AD_VP'), 12000);

DELETE
FROM employees
WHERE employee_id = 209;

----
SELECT *
FROM new_employees;

DELETE
FROM new_employees
WHERE TO_CHAR(TO_DATE(start_date, 'DD-MON-RR'), 'YY') = '97';

--                                          DELETE WITH SUBQUERY

-- DELETE
-- FROM table_name
-- WHERE column = subquery; 

----
SELECT *
FROM new_employees;

DELETE
FROM new_employees
WHERE job IN (
    SELECT DISTINCT job_id
    FROM employees
    WHERE department_id IN (
        SELECT department_id
        FROM departments
        WHERE manager_id = 100));

--                                          MERGE

-- MERGE INTO table_name1 AS t1
-- USING {table_name2 | subquery} AS t2
-- ON (t1.column = t2.column)
-- WHEN MATCHED THEN
-- UPDATE SET column = value
-- DELETE WHERE condition
-- WHEN NOT MATCHED THEN
-- INSERT (value1, value2)
-- VALUES (column1, column2);

CREATE TABLE employees_merge (
    employee_id INTEGER,
    first_name VARCHAR2(30),
    start_date DATE,
    job_id VARCHAR2(10));

SELECT *
FROM employees_merge;

DELETE 
FROM employees_merge;

INSERT INTO employees_merge (
    SELECT employee_id,
           first_name,
           hire_date,
           job_id
    FROM employees
    WHERE employee_id < 110);

MERGE INTO employees_merge em
USING employees e
ON (em.employee_id = e.employee_id)
WHEN MATCHED THEN
UPDATE SET em.start_date = SYSDATE
DELETE WHERE em.job_id LIKE '%IT%'
WHEN NOT MATCHED THEN 
INSERT (em.employee_id, em.first_name, start_date, em.job_id)
VALUES (e.employee_id, e.first_name, hire_date, e.job_id);

SELECT employee_id,
       first_name,
       start_date,
       job_id
FROM employees_merge
WHERE TO_CHAR(TO_DATE(start_date, 'DD-MON-RR'), 'YY') = '20';

--                                          TCL COMMANDS

--                                          ACID
-- ATOMICITY
-- CONSISTENCY
-- ISOLATION
-- DURABLE

--                                          TRANSACTIONS
-- End transactions (commit or rollback)

--                                          COMMIT

-- SELECT ...
-- UPDATE ...
-- SELECT ...
-- DELETE ...
-- COMMIT; (end transaction)

SELECT *
FROM employees_merge;

DELETE 
FROM employees_merge
WHERE UPPER(job_id) LIKE '%ACCOUNT%';

UPDATE employees_merge
SET job_id = 'AC_MGR'
WHERE employee_id = 101;

COMMIT;

--                                          ROLLBACK

-- SELECT ...
-- UPDATE ...
-- SELECT ...
-- DELETE ...
-- ROLLBACK; (delete transaction)

SELECT *
FROM employees_merge;

DELETE 
FROM employees_merge;

ROLLBACK;

----
SELECT *
FROM employees_merge;

DELETE 
FROM employees_merge;

INSERT INTO employees_merge
    (employee_id, first_name, start_date, job_id)
    (SELECT employee_id,
            first_name,
            hire_date,
            job_id
     FROM employees
     WHERE employee_id <= 110);

COMMIT; -- or ROLLBACK;

-- CMD> sqlplus hr/hr@orclpdb2
-- SQL> SELECT * FROM employees_merge; 

/* EMPLOYEE_ID FIRST_NAME                     START_DAT JOB_ID
----------- ------------------------------ --------- ----------
        100 Steven                         17-JUN-87 AD_PRES
        101 Neena                          21-SEP-89 AD_VP
        102 Lex                            13-JAN-93 AD_VP
        103 Alexander                      03-JAN-90 IT_PROG
        104 Bruce                          21-MAY-91 IT_PROG
        105 David                          25-JUN-97 IT_PROG
        106 Valli                          05-FEB-98 IT_PROG
        107 Diana                          07-FEB-99 IT_PROG
        108 Nancy                          17-AUG-94 FI_MGR
        109 Daniel                         16-AUG-94 FI_ACCOUNT
        110 John                           28-SEP-97 FI_ACCOUNT

11 rows selected.  */

INSERT INTO employees_merge
    (employee_id, first_name, start_date, job_id)
VALUES (111, INITCAP('Alexey'), SYSDATE, UPPER('IT_PROG'));

-- CMD: the line () is not visible

COMMIT;

/* EMPLOYEE_ID FIRST_NAME                     START_DAT JOB_ID
----------- ------------------------------ --------- ----------
        100 Steven                         17-JUN-87 AD_PRES
        101 Neena                          21-SEP-89 AD_VP
        102 Lex                            13-JAN-93 AD_VP
        103 Alexander                      03-JAN-90 IT_PROG
        104 Bruce                          21-MAY-91 IT_PROG
        105 David                          25-JUN-97 IT_PROG
        106 Valli                          05-FEB-98 IT_PROG
        107 Diana                          07-FEB-99 IT_PROG
        108 Nancy                          17-AUG-94 FI_MGR
        109 Daniel                         16-AUG-94 FI_ACCOUNT
        110 John                           28-SEP-97 FI_ACCOUNT

EMPLOYEE_ID FIRST_NAME                     START_DAT JOB_ID
----------- ------------------------------ --------- ----------
        111 Alexey                         21-AUG-20 IT_PROG

12 rows selected. */

--                                          SAVEPOINT (with ROLLBACK)
-- SAVEPOINT savepoint_name;
-- ROLLBACK TO SAVEPOINT savepoint_name;

-- SELECT ...
-- UPDATE ...
-- SAVEPOINT savepoint_name_1;
-- SELECT ...
-- DELETE ...
-- SAVEPOINT savepoint_name_2;
-- SELECT ...
-- ROLLBACK TO SAVEPOINT savepoint_name_2;

SELECT *
FROM employees_merge;

INSERT INTO employees_merge
    (employee_id, first_name)
VALUES (112, INITCAP('Trigulov'));

SAVEPOINT add_employee_112;

DELETE 
FROM employees_merge
WHERE employee_id = 112;

SAVEPOINT delete_employee_112;

ROLLBACK TO SAVEPOINT add_employee_112;

--                                          AUTOCOMMIT
-- CMD> sqlplus hr/hr@orclpdb2
-- SQL> SET AUTOCOMMIT ON;      (SET AUTOCOMMIT OFF;)

SELECT *
FROM employees_merge;

INSERT INTO employees_merge
    (employee_id, first_name)
VALUES (99, INITCAP('Ivan'));

DELETE 
FROM employees_merge
WHERE employee_id = 99;

-- Tools => Preferences => Database => Advanced = Autocommit x

--                                          SELECT FOR UPDATE

SELECT *
FROM employees_merge;

-- lock:
SELECT *
FROM employees_merge
FOR UPDATE;

COMMIT;
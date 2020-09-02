--                                          Contents:
-- 122. Database Objects                            (14 st)
-- 123. USER and SCHEMA                             (59 st)
-- 124. Rules for naming objects and                
--      the concept of NAMESPACE (PUBLIC NAMESPACE) (70 st)
-- 125. Data types (optional)                       (110 st)
-- 126. Creating simple tables                      (130 st)
-- 127. Creating tables with SUBQUERY               (170 st)
-- 128. ALTER TABLE                                 (225 st)
-- 129. TRUNCATE TABLE                              (367 st)
-- 130. DROP TABLE                                  (377 st)


--                                          122. Database Objects
SELECT *
FROM dba_objects;

SELECT * 
FROM user_objects;

SELECT object_type,
       COUNT(object_type)
FROM user_objects
GROUP BY object_type
ORDER BY object_type;

/*
SELECT object_type,
       COUNT(object_type)
FROM all_objects
GROUP BY object_type
ORDER BY object_type;
*/

SELECT *
FROM user_tables;

SELECT table_name
FROM user_tables;

SELECT column_name,
       data_type,
       nullable
FROM user_tab_columns;

SELECT column_name,
       data_type,
       nullable
FROM user_tab_columns
WHERE UPPER(table_name) = 'DEPARTMENTS';

--                                          DB OBJECTS
-- TABLE
-- VIEW
-- SYNONYM
-- INDEX
-- SEQUENCE

--                                          123. USER and SCHEMA

-- USER: username, password
-- USER => SCHEMA (create empty: default)

-- USER_NAME.TABLE_NAME (SCHEMA_NAME.OBJECT_NAME)

--                                          AUTOUSERS:
-- SYS    - data dictionary
-- SYSTEM - administrative purposes and monitoring

--                                          124. Rules for naming objects and the concept of NAMESPACE

-- RULES             (76 st)
-- NAMESPACE         (98 st)
-- PUBLIC NAMESPACE  (105 st)

--                                          RULES

-- 1. NAME_TABLE (1 - 30 letter)
-- 2. Objects cannot be named with reserved words
-- 3. All names with a letter
-- 4.Can be used: << _ >>, << $ >>, << # >>
-- 5. Lowercase => Uppercase

-- but: << "" >> ("3abc def" it's work)

CREATE TABLE 3abc def (
    id NUMBER);           

SELECT *
FROM 3abc def;            -- NOT WORK

CREATE TABLE "3abc def" (
    id NUMBER);           

SELECT *
FROM "3abc def";            -- WORK (not correct)

--                                          NAMESPACE
-- names must be unique:

-- NAMESPACE ( TABLE : VIEW : SEQUENCE : PRIVATE SYNONYM ) \
-- NAMESPACE ( INDEX ) 
-- NAMESPACE ( CONSTRAINT ) 

--                                          PUBLIC NAMESPACE
-- names must be unique:

-- NAMESPACE ( PUBLIC SYNONYM )

--                                          125. Data types (optional)

-- TIMESTAMP WITH TIMEZONE
-- TIMESTAMP WITH LOCAL TIMEZONE
-- INTERVAL YEAR TO MONTH
-- INTERVAL DAY TO SECOND

-- Large objects:

-- CLOB
-- BLOB
-- LONG

-- ROWID (Oracle)

SELECT ROWID,
       last_name,
       salary
FROM employees;

--                                          126. Creating simple tables

-- CREATE TABLE schema.table ORGANIZATION HEAP
--     (column_name datatype DEFAULT expression,
--      column_name datatype DEFAULT expression,
--                     ...                     );

CREATE TABLE students 
    (student_id INTEGER,
     first_name VARCHAR2 (15),
     last_name VARCHAR2 (30),
     start_date DATE DEFAULT ROUND(SYSDATE),
     scholarship NUMBER (6, 2),
     avg_score NUMBER (4, 2) DEFAULT 5 );

SELECT *
FROM students;

INSERT INTO students
    (student_id, first_name, last_name, start_date, scholarship, avg_score)
VALUES (001, INITCAP('John'), INITCAP('Snow'), TO_DATE('01-SEP-2020'), 1500.5, 8.3);

INSERT INTO students
    (student_id, first_name, last_name, start_date, scholarship, avg_score)
VALUES (002, INITCAP('Alex'), INITCAP('Swong'), TO_DATE('01-SEP-2019'), 1800, 7.8);

INSERT INTO students
    (student_id, first_name, last_name, start_date, scholarship, avg_score)
VALUES (003, INITCAP('Ivan'), INITCAP('Tara'), TO_DATE('01-SEP-2019'), 840.2, 6.2);

INSERT INTO students
    (student_id, first_name, last_name, start_date, scholarship, avg_score)
VALUES (004, INITCAP('Cry'), INITCAP('Le Blan'), TO_DATE('03-SEP-2018'), 1600, 7.3);

INSERT INTO students
    (student_id, first_name, last_name, scholarship)
VALUES (005, INITCAP('Lee'), INITCAP('Chen'), 1600);                         -- default

COMMIT;

--                                          127. Creating tables with SUBQUERY
-- CREATE TABLE schema.table
-- AS subquery;

CREATE TABLE employees_salary
AS (SELECT employee_id,
           first_name,
           last_name,
           job_id,
           commission_pct,
           salary
    FROM employees
    WHERE commission_pct IS NOT NULL);

SELECT *
FROM employees_salary
ORDER BY salary DESC;

COMMIT;

----
CREATE TABLE departments_salary
AS (SELECT department_name,
           MAX(salary) AS max_salary,
           MIN(salary) AS min_salary
    FROM employees e
    JOIN departments d
    ON (e.department_id = d.department_id)
    GROUP BY department_name);
    
SELECT *
FROM departments_salary;

COMMIT;

----
CREATE TABLE clone_regions
AS (SELECT *
    FROM regions);

SELECT *
FROM clone_regions;

-- or structure

CREATE TABLE clone_regions_str
AS (SELECT *
    FROM regions
    WHERE 2 = 1);

SELECT *
FROM clone_regions_str;

COMMIT;

--                                          128. ALTER TABLE
-- ADD                  (235 st)
-- MODIFY               (250 st)
-- DROP COLUMN          (281 st)
-- SET UNUSED COLUMN    (293 st)
-- DROP UNUSED COLUMNS  (314 st)
-- RENAME COLUMN        (323 st)
-- READ ONLY            (340 st) 
-- READ WRITE           (356 st)


--                                          ADD

-- ALTER TABLE table_name
-- ADD (column_name data_type DEFAULT expression);

----
ALTER TABLE students
ADD (course NUMBER DEFAULT 1);

SELECT *
FROM students;

ALTER TABLE students
ADD (new_course NUMBER DEFAULT NULL);

--                                          MODIFY

-- ALTER TABLE table_name
-- MODIFY (column_name data_type DEFAULT expression);

----
ALTER TABLE students
MODIFY (avg_score NUMBER (5, 2));

ALTER TABLE students
MODIFY (start_date DATE DEFAULT NULL);

INSERT INTO students
    (student_id, first_name, last_name, scholarship)
VALUES (006, INITCAP('Bruse'), INITCAP('Lee'), 930.45);

UPDATE students
SET course = 3
WHERE start_date = TO_DATE('03-SEP-18');

UPDATE students
SET course = 2
WHERE start_date = TO_DATE('01-SEP-19');

UPDATE students
SET course = 1
WHERE TO_CHAR(TO_DATE(start_date, 'DD-MON-RR'), 'YY') = '20';

SELECT *
FROM students;

--                                          DROP COLUMN

-- ALTER TABLE table_name
-- DROP COLUMN column_name;

----
ALTER TABLE students
DROP COLUMN new_course;

SELECT *
FROM students;

--                                          SET UNUSED COLUMN 

-- ALTER TABLE table_name
-- SET UNUSED COLUMN column_name;

----
ALTER TABLE students
ADD (new_course NUMBER DEFAULT NULL);

ALTER TABLE students
SET UNUSED COLUMN new_course;

ALTER TABLE students
SET UNUSED COLUMN exams;

SELECT new_course
FROM students;

SELECT *
FROM students;

--                                          DROP UNUSED COLUMNS

-- ALTER TABLE table_name
-- DROP UNUSED COLUMNS;

ALTER TABLE students
DROP UNUSED COLUMNS;

--                                          RENAME COLUMN

-- ALTER TABLE table_name
-- RENAME COLUMN column_name_1 
--            TO column_name_2;

----
ALTER TABLE students
ADD (exams VARCHAR (3) DEFAULT 'NO');

SELECT *
FROM students;

ALTER TABLE students
RENAME COLUMN exams 
           TO exams_semester;

--                                          READ ONLY

-- ALTER TABLE table_name
-- READ ONLY;

----
ALTER TABLE students
READ ONLY;

SELECT *
FROM students;

UPDATE students
SET exams_semester = 'YES'
WHERE course = 3;            -- NOT WORK

--                                          READ WRITE

-- ALTER TABLE table_name
-- READ WRITE;

----
ALTER TABLE students
READ WRITE;

UPDATE students
SET exams_semester = 'YES'
WHERE course = 2;

SELECT *
FROM students;

COMMIT;

--                                          129. TRUNCATE TABLE

-- TRUNCATE TABLE
-- schema.table_name;

SELECT *
FROM students;

TRUNCATE TABLE students;  -- NOT ROLLBACK

--                                          130. DROP TABLE

-- DROP TABLE 
-- schema.table_name;

CREATE TABLE drop_table 
    (id NUMBER,
     name VARCHAR (15));

SELECT *
FROM drop_table;

INSERT INTO drop_table
    (id, name)
VALUES (1, 'MacOS');

INSERT INTO drop_table
    (id, name)
VALUES (2, 'Windows');

INSERT INTO drop_table
    (id, name)
VALUES (3, 'Linux');

COMMIT;

DROP TABLE drop_table;
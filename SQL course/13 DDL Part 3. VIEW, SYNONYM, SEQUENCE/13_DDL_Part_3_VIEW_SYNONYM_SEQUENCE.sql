--                                          Contents:

-- 144. Introduction to VIEW                       (32 st)
-- 145. Simple and Complex VIEW                    (133 st)
--      a. SIMPLE                          (138 st)
--      b. COMLEX                          (225 st)
-- 146. CREATE VIEW                                (316 st)
--      a. OR REPLACE:                     (362 st)
--      b. FORCE / NOFORCE (default)       (397 st)
--      c. WITH CHECK OPTION               (412 st)
--      d. WITH READ ONLY                  (444 st)
--      f. CONSTRAINT                      (555 st)
--      g. ALIAS                           (466 st)
-- 147. Change ALTER VIEW and DELETE VIEW          (486 st)
--      a. ALTER VIEW                      (488 st)
--      b. DELETE VIEW                     (513 st)
--      c. EXAMPLES                        (522 st)
-- 148. SYNONYM                                    (558 st)
--      a. PUBLIC SYNONYM                  (585 st)
--      b. PRIVATE SYNONYM                 (604 st)
--      c. DELETE SYNONYM                  (616 st)
--      d. ALTER SYNONYM                   (628 st)
-- 149. Introduction to SEQUENCE                   (634 st)
-- 150. Work with the SEQUENCE. Part 1             (645 st)
--      a. NEXTVAL                         (649 st)
--      b. CURRVAL                         (654 st)
-- 151. Work with the SEQUENCE. Part 2             (872 st)
--      a. WITHOUT PASSES IN PRIMARY KEY   (874 st)
--      b. ALTER SEQUENCE                  (946 st)
--      c. DELETE SEQUENCE                 (1014 st)

--                                          144. Introduction to VIEW             
/*
  Reasons for using VIEW:
  - Safety
  - Simplification for USERS
  - Error prevention
  - Table / column names are not clear
*/

SELECT *
FROM employees;

CREATE VIEW fin_emp
AS SELECT employee_id,
          job_id,
          salary
   FROM employees;

SELECT *
FROM fin_emp;   

----

CREATE VIEW fin_emp2
AS SELECT department_name,
          SUM(salary) AS sum_salary
   FROM employees e
   JOIN departments d
   ON (e.department_id = d.department_id)
   GROUP BY department_name;

SELECT *
FROM fin_emp2;


SELECT *
FROM fin_emp2
WHERE sum_salary > 10000;

----

SELECT *
FROM employees;

CREATE VIEW emp_high_salary
AS SELECT first_name,
          last_name
   FROM employees
   WHERE salary >= 12000;

SELECT *
FROM emp_high_salary;

UPDATE employees
SET salary = 13000
WHERE employee_id = 103;

COMMIT;

SELECT *
FROM emp_high_salary;

----

DROP TABLE e_0124_hs;
 
CREATE TABLE e_0124_hs
    (iE NUMBER CONSTRAINT eh_iE_pk PRIMARY KEY,
     nE VARCHAR2 (15) CONSTRAINT eh_nE_nn NOT NULL,
     sE NUMBER (8, 2) DEFAULT TO_NUMBER('0', '999999.99'));

INSERT INTO e_0124_hs
    (iE, nE, sE)
VALUES (1, INITCAP('Alex'), TO_NUMBER('2000'));

INSERT INTO e_0124_hs
    (iE, nE, sE)
VALUES (2, INITCAP('Zaur'), TO_NUMBER('3400'));

INSERT INTO e_0124_hs
    (iE, nE, sE)
VALUES (3, INITCAP('Petr'), TO_NUMBER('1800'));

INSERT INTO e_0124_hs
    (iE, nE, sE)
VALUES (4, INITCAP('Ivan'), TO_NUMBER('850'));

COMMIT;

SELECT *
FROM e_0124_hs;

CREATE VIEW empl_salary
AS SELECT iE AS employee_id,
          nE AS first_name,
          sE AS salary
    FROM e_0124_hs;

SELECT *
FROM empl_salary;

--                                          145. Simple and Complex VIEW         

-- SIMPLE   ( st)
-- COMPLEX  ( st)

--                                          SIMPLE 

-- DONT WORK DML commands

SELECT *
FROM students;

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (1, 'Alex', 3, 2); 

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (2, 'Petr', 2, 4);      

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (7, 'Alex', 5, 1);       

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (6, 'Petr', 4, 1); 

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (3, 'Zaur', 4, 2);

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (4, 'John', 4, 1);       

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (5, 'Ivan', 2, 4);      

COMMIT;

CREATE VIEW v101
AS SELECT name,
          course
   FROM students;

SELECT *
FROM v101;

INSERT INTO v101
    (name, course)
VALUES ('John', 4);

DELETE 
FROM v101
WHERE name = 'Alex' OR
      course < 4;

COMMIT;

SELECT *
FROM v101;

/* Output:
            Petr	4
            John	4
            John	4
*/

SELECT *
FROM students;

/* Output:
            6	Petr	4	1
            4	John	4	1
         null   John	4   null	
*/

-- but

DELETE 
FROM students
WHERE id IS NULL;

ALTER TABLE students
MODIFY (id NOT NULL);

INSERT INTO v101
    (name, course)
VALUES ('John', 4);      -- NOT WORK (id TABLE students NOT NULL)

--                                          COMLEX
SELECT *
FROM students;

CREATE VIEW v105
AS SELECT SUBSTR(name, 2) AS short_name,
          name,
          course
    FROM students;

SELECT *
FROM v105;

INSERT INTO v105
VALUES ('Ivan', 3);  -- NOT WORK (not correct (SUBSTR(name)))

DELETE
FROM v105
WHERE name = 'Alex';

----

DROP TABLE students;

CREATE TABLE students
    (id NUMBER CONSTRAINT st_id_pk PRIMARY KEY,
     name VARCHAR2(15),
     course NUMBER CONSTRAINT st_course_ch CHECK (course > 1 AND course < 6),
     faculty_id NUMBER CONSTRAINT st_fid_fk
                       REFERENCES faculties (id));

SELECT *
FROM students;

SELECT *
FROM faculties;

DROP TABLE v106;

CREATE TABLE v106
AS SELECT DISTINCT name,
                   course
FROM students;

SELECT *
FROM V106;

INSERT INTO v106
VALUES ('Ivan', 3);

DELETE
FROM v106
WHERE name = 'Ivan';

----

CREATE TABLE v107
AS SELECT name AS n,
          course AS c
FROM students;

SELECT *
FROM v107;

DELETE
FROM v107
WHERE n = 'John';

SELECT ROWNUM AS r,
       n,
       c
FROM v107;

----

CREATE TABLE v108
AS SELECT ROWNUM AS r,
          name,
          course
FROM students;

SELECT *
FROM v108;

INSERT INTO v108
VALUES (8, 'John D', 3);

DELETE
FROM v108
WHERE r = 1;

--                                          146. CREATE VIEW

/*
  CREATE OR REPLACE { FORCE | NOFORCE } VIEW
  schema.view_name (alias_1, alias_2, ...)
  AS subquery
  WITH CHECK OPTION { CONSTRAINT constraint_tname }
  WITH READ ONLY { CONSTRAINT constraint_name };
*/

DROP TABLE students;

CREATE TABLE students
    (id INTEGER CONSTRAINT st_id_pkey PRIMARY KEY,
     name VARCHAR2(15) CONSTRAINT st_name_nnull NOT NULL,
     course INTEGER CONSTRAINT st_course_ch CHECK (course > 0 AND course <= 6));

INSERT INTO students
    (id, name, course)
VALUES (1, 'Alex', 3);

INSERT INTO students
    (id, name, course)
VALUES (2, 'Petr', 6);

INSERT INTO students
    (id, name, course)
VALUES (3, 'Masha', 2);

INSERT INTO students
    (id, name, course)
VALUES (4, 'Zaur', 1);

INSERT INTO students
    (id, name, course)
VALUES (5, 'Ivan', 4);

INSERT INTO students
    (id, name, course)
VALUES (6, 'Sveta', 1);

COMMIT;

SELECT *
FROM students;

--                                          OR REPLACE:

SELECT *
FROM fin_emp2;

/* Output:
            Sales,           304500
            Marketing,       32000
            Administration,  4400
            Purchasing,      24900
            Shipping,        156400
            IT,              32800
            Executive,       58000
            Finance,         51600
            Public Relations,10000
            Human Resources, 6500
            Accounting,      20300
 */

CREATE OR REPLACE VIEW fin_emp2
AS SELECT *
FROM students;

SELECT *
FROM fin_emp2;

/* Output:
           1,  Alex,   3
           2,  Petr,   6
           3,  Masha,  2
           4,  Zaur,   1
           5,  Ivan,   4
           6,  Sveta,  1
 */

--                                          FORCE / NOFORCE (default)

CREATE OR REPLACE VIEW v201
AS SELECT name,
          surname
FROM students;              -- NOT WORK (not column 'surname' in table 'students')

CREATE FORCE VIEW v201
AS SELECT name,
          surname
FROM students;              -- WORK (FORCE)

SELECT *
FROM v201;                  -- NOT WORK

--                                          WITH CHECK OPTION

CREATE VIEW v202
AS SELECT *
FROM students
WHERE course > 2;

INSERT INTO v202
    (id, name, course)
VALUES (8, 'Lee', 1);  -- ADD

SELECT *
FROM v202;

----

CREATE VIEW v203
AS SELECT *
FROM students
WHERE course > 2 WITH CHECK OPTION;

INSERT INTO v203
    (id, name, course)
VALUES (8, 'Lee', 1);  -- NOT ADD

UPDATE v203
SET course = 1
WHERE id = 7;         -- NOT UPDATE

SELECT *
FROM v203;

--                                          WITH READ ONLY

CREATE VIEW v204
AS SELECT *
FROM students
WITH READ ONLY ;       -- NOT DML COMMANDS

INSERT INTO v204
    (id, name, course)
VALUES (8, 'Lee', 4);  -- NOT WORK (READ ONLY)

--                                          CONSTRAINT

CREATE VIEW v205
AS SELECT *
FROM students
WITH READ ONLY CONSTRAINT limitation_one;

INSERT INTO v205
    (id, name, course)
VALUES (8, 'Lee', 4);  -- NOT WORK (ERROR: limitation_one)

--                                          ALIAS

CREATE VIEW v206  (a, b, c)
AS SELECT *
FROM students;

SELECT *
FROM v206;

-- OR

CREATE VIEW v207
AS SELECT id,
          name,
          course
FROM students;

SELECT *
FROM v207;

--                                          147. Change ALTER VIEW and DELETE VIEW

--                                          ALTER VIEW

-- ALTER VIEW schema.view_name COMPILE;

CREATE  FORCE VIEW v18
AS SELECT name,
          surname
   FROM students;

SELECT *
FROM v18;  -- NOT WORK (not 'surname' in 'student')

ALTER TABLE students
ADD (surname VARCHAR2 (30));

SELECT *
FROM v18;               -- WORK (autocompile)

-- OR

ALTER VIEW v18 COMPILE; -- WORK (hand compile)

SELECT *
FROM v18;

--                                          DELETE VIEW

-- DROP VIEW schema.view_name;

DROP VIEW v18;

SELECT *
FROM v18;  -- NOT VIEW

--                                          EXAMPLES

SELECT *
FROM v202;

CREATE VIEW v202a
AS SELECT *
   FROM v202;

SELECT *
FROM v202a;

----

CREATE VIEW v300
AS SELECT *
   FROM students;

----

CREATE VIEW v301
AS SELECT *
   FROM students
   WHERE id > 4;

SELECT *
FROM v301
WHERE name = 'Sveta';

-- the same thing ...

SELECT *
FROM students
WHERE id > 4 AND
      name = 'Sveta';

--                                          148. SYNONYM
/* ACCESS => Command line:

CMD> sqlplus sys/oracle@orclpdb2 as sysdba
    SQL> grant create public synonym to hr;
         Grant succeeded.
    SQL> grant drop public synonym to hr;
         Grant succeeded.

 */

-- FIRST: PRIVATE SYNONYM => THEN: PUBLIC SYNONYM

SELECT *
FROM hr.employees@orclpdb2;  -- DATABASE LINK (@orclpdb2)

SELECT *
FROM hr.employees;

SELECT *
FROM employees;

-- OR SYNONYM:

SELECT *
FROM emp; -- IF THIS SYNONYM FOR TABLE 'employees'

--                                          PRIVATE SYNONYM
/*
    CREATE SYNONYM synonym_name
    FOR object_name;
*/

SELECT *
FROM students;

CREATE SYNONYM synonym_one
FOR students;

SELECT *
FROM synonym_one;

DELETE
FROM synonym_one
WHERE id = 8;

--                                          PUBLIC SYNONYM
/*
    CREATE PUBLIC SYNONYM synonym_name
    FOR object_name;
*/

CREATE PUBLIC SYNONYM synonym_one
FOR employees;

SELECT *
FROM synonym_one;  -- PRIVATE SYNONYM FOR 'students'

--                                          DELETE SYNONYM
/*
  DROP PUBLIC SYNONYM synonym_name;
*/

DROP SYNONYM synonym_one;

DROP PUBLIC SYNONYM synonym_one;

SELECT *
FROM synonym_one;  -- PRIVATE SYNONYM FOR 'students'

--                                          ALTER SYNONYM
/*
  ALTER PUBLIC SYNONYM synonym_name
  COMPILE;
*/

--                                          149. Introduction to SEQUENCE
/*
    CREATE SEQUENCE schema.sequence_name  -- simple sequence (1, 2, 3, ... N)
    INCREMENT BY number                   -- increase by: 3  (1, 4, 7, ... N) OR increase by: -3 (1, -2, -5, ... -N)
    START WITH number                     -- start with: 5   (5, 6, 7, ... N)
    { MAXVALUE number | NOMAXVALUE }      -- NOMAXVALUE (default) OR MAXVALUE - 5 (1, 2, 3, 4, 5, ERROR) OR MAXVALUE: 3 + CYCLE (1, 2, 3, 1, 2, 3, ... N)
    { MINVALUE number | NOMINVALUE }      -- NOMINVALUE (default) OR MINVALUE: 6 + increase by: -2 + start with: 10 - (10, 8, 6, ERROR)
    { CYCLE | NOCYCLE }                   -- NOCYCLE    (default) OR
    { CACHE number | NOCACHE };           -- NOCACHE    (default: 20 (1, 2, ... 20)) OR
*/

--                                          150. Work with the SEQUENCE. Part 1

CREATE SEQUENCE sequence_one;

--                                          NEXTVAL

SELECT sequence_one.nextval
FROM dual;

--                                          CURRVAL

SELECT sequence_one.currval
FROM dual;

----

DROP TABLE students;

CREATE TABLE students
    (id INTEGER,
     name VARCHAR2 (15),
     course INTEGER,
     faculty_id INTEGER);

CREATE SEQUENCE seq_students;

---->

DROP TABLE faculties;

CREATE TABLE faculties
    (id INTEGER,
     name VARCHAR2 (15));

CREATE SEQUENCE seq_faculties
START WITH 20
INCREMENT BY 5;

---->

INSERT INTO faculties
    (id, name)
VALUES (seq_faculties.nextval, 'IT');

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (seq_students.nextval, 'Alex', 3, seq_faculties.currval);

INSERT INTO faculties
    (id, name)
VALUES (seq_faculties.nextval, 'Marketing');

INSERT INTO faculties
    (id, name)
VALUES (seq_faculties.nextval, 'Philology');

INSERT INTO students
    (id, name, course, faculty_id)
VALUES (seq_students.nextval, 'Zaur', 5, 25);

COMMIT;

---->

SELECT *
FROM students;

SELECT *
FROM faculties;

----

DROP SEQUENCE sequence_test_1;

CREATE SEQUENCE sequence_test_1
INCREMENT BY 2
MAXVALUE 17;

SELECT sequence_test_1.nextval
FROM dual;

-- Output: 1, 3, 5, 7, 9, 11, 13, 15, 17, ERROR

----

DROP SEQUENCE sequence_test_2;

CREATE SEQUENCE sequence_test_2
INCREMENT BY 2
MAXVALUE 17
CYCLE;     -- ERROR (number to CACHE (default 20))

CREATE SEQUENCE sequence_test_2
INCREMENT BY 2
MAXVALUE 17
CYCLE
CACHE 3;

SELECT sequence_test_2.nextval
FROM dual;

-- Output: 1, 3, 5, 7, 9, 11, 13, 15, 17, 1, 3, 5, ... N

----

DROP SEQUENCE sequence_test_3;

CREATE SEQUENCE sequence_test_3
START WITH 7
INCREMENT BY 4
MAXVALUE 17
CYCLE
CACHE 2;

SELECT sequence_test_3.nextval
FROM dual;

-- Output: 7, 11, 15, 1, 5, 9, 13, 17, 1, 5, ... N

----

CREATE SEQUENCE seq_for_t;

CREATE SEQUENCE seq_for_num
START WITH 10
INCREMENT BY 5;

CREATE TABLE t_1
    (id INTEGER,
     num INTEGER);

CREATE TABLE t_2
    (id INTEGER,
     num INTEGER);

INSERT INTO t_1
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_1
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_2
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_2
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_1
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_2
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_2
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

INSERT INTO t_1
    (id, num)
VALUES (seq_for_t.nextval, seq_for_num.nextval);

COMMIT;

SELECT *
FROM t_1;

/* Output:
     1,  10
     2,  15
     5,  30
     8,  45
*/

SELECT *
FROM t_2;

/* Output:
     3,  20
     4,  25
     6,  35
     7,  40
*/

----

DROP TABLE students;

DROP SEQUENCE seq_simple_students;

CREATE TABLE students
    (id INTEGER,
     name VARCHAR2(15));

CREATE SEQUENCE seq_simple_students;

INSERT INTO students
    (id, name)
VALUES (seq_simple_students.nextval, 'Alex');

COMMIT;

INSERT INTO students
    (id, name)
VALUES (seq_simple_students.nextval, 'Zaur');

ROLLBACK;

INSERT INTO students
    (id, name)
VALUES (seq_simple_students.nextval, 'Masha');

COMMIT;

SELECT *
FROM students;

/* Output:
   1, Alex
   3, Masha
*/

--                                          151. Work with the SEQUENCE. Part 2

--                                          WITHOUT PASSES IN PRIMARY KEY (not effective)

CREATE TABLE seq_table
    (id INTEGER);

INSERT INTO seq_table
    (id)
VALUES (1);

COMMIT;

SELECT *
FROM seq_table;

---->

DROP TABLE students;

CREATE TABLE students
    (id INTEGER CONSTRAINT st_id_pk PRIMARY KEY,
     name VARCHAR2 (15));

INSERT INTO students
    (id, name)
VALUES ((SELECT id FROM seq_table), 'Alexey');

UPDATE seq_table
SET id = id + 1;

COMMIT;

----

SELECT *
FROM students;

SELECT *
FROM seq_table;

----

INSERT INTO students
    (id, name)
VALUES ((SELECT id FROM seq_table), 'Zaur');

UPDATE seq_table
SET id = id + 1;

INSERT INTO students
    (id, name)
VALUES ((SELECT id FROM seq_table), 'Petr');

UPDATE seq_table
SET id = id + 1;

INSERT INTO students
    (id, name)
VALUES ((SELECT id FROM seq_table), 'Masha');

UPDATE seq_table
SET id = id + 1;

COMMIT;

----

SELECT *
FROM students;

SELECT *
FROM seq_table;

--                                          ALTER SEQUENCE
/*
    ALTER SEQUENCE schema.sequence_name
    INCREMENT BY number
    { MAXVALUE number | NOMAXVALUE }
    { MINVALUE number | NOMINVALUE }
    { CYCLE | NOCYCLE }
    { CACHE number | NOCACHE };
*/

CREATE SEQUENCE seq_table_test
INCREMENT BY 2;

CREATE TABLE seq_test
    (id INTEGER,
     name VARCHAR2(15));

---->

INSERT INTO seq_test
    (id, name)
VALUES (seq_table_test.nextval, 'Alexey');

INSERT INTO seq_test
    (id, name)
VALUES (seq_table_test.nextval, 'Masha');

COMMIT;

---->

SELECT *
FROM seq_test;

/* Output:
     1,   Alexey
     3,   Masha
*/

---->

ALTER SEQUENCE seq_table_test
INCREMENT BY 5;

---->

INSERT INTO seq_test
    (id, name)
VALUES (seq_table_test.nextval, 'Ivan');

INSERT INTO seq_test
    (id, name)
VALUES (seq_table_test.nextval, 'Zaur');

COMMIT;

---->

SELECT *
FROM seq_test;

/* Output:
     1,   Alexey
     3,   Masha
     8,   Ivan
     13,  Zaur
*/

--                                          DELETE SEQUENCE
/*
  DROP SEQUENCE schema.sequence_name;
*/

DROP SEQUENCE seq_table_test;

INSERT INTO seq_test
    (id, name)
VALUES (seq_table_test.nextval, 'Zaur'); -- ERROR (sequence does not exist)
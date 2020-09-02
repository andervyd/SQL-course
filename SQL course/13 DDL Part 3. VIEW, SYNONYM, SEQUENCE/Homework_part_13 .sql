-- task 01:
CREATE TABLE emp1000
AS SELECT first_name,
          last_name,
          salary,
          department_id
   FROM employees;

SELECT *
FROM emp1000;

-- task 02:
CREATE VIEW v1000
AS SELECT first_name,
          last_name,
          salary,
          department_name,
          city
   FROM employees e
   JOIN departments d
   ON (e.department_id = d.department_id)
   JOIN locations l
   ON (d.location_id = l.location_id);

SELECT *
FROM v1000;

---->
CREATE FORCE VIEW v1000
AS SELECT first_name,
          last_name,
          salary,
          department_name,
          e.city
   FROM emp1000 e
   JOIN departments d
   ON (e.department_id = d.department_id);

SELECT *
FROM v1000;

-- task 03:
ALTER TABLE emp1000
ADD (city VARCHAR2 (30));

-- task 04:
ALTER VIEW v1000 COMPILE;

-- task 05:
CREATE SYNONYM syn1000
FOR v1000;

-- task 06:
DROP VIEW v1000;

-- task 07:
DROP SYNONYM syn1000;

-- task 08:
DROP TABLE emp1000;

-- task 09:
DROP SEQUENCE seq1000;

CREATE SEQUENCE seq1000
START WITH 12
INCREMENT BY 4
MAXVALUE 200
CYCLE;

-- task 10:

ALTER SEQUENCE seq1000
NOMAXVALUE
NOCYCLE;

SELECT seq1000.nextval
FROM dual;

SELECT seq1000.currval
FROM dual;

-- task 11:
SELECT *
FROM employees;

INSERT INTO employees
    (employee_id, last_name, email, hire_date, job_id)
VALUES (seq1000.nextval, 'Snow', 'JSNOW', SYSDATE, 'IT_PROG');

INSERT INTO employees
    (employee_id, last_name, email, hire_date, job_id)
VALUES (seq1000.nextval, 'Lee', 'BLEE', SYSDATE, 'IT_PROG');

-- task 12:
COMMIT;
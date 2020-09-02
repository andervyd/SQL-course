--                                          SUBQUERY
-- Types of SUBQUERY: 
--                   SINGLE ROW   (37 st)
--                   MULTYPLE ROW (95 st)
--                   SCALAR       ()

SELECT AVG(salary)
FROM employees;

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT AVG(salary) 
      FROM employees);

SELECT (
       SELECT MIN(min_salary) 
       FROM jobs) AS min_salary,
        (SELECT MAX(LENGTH(first_name)) 
        FROM employees) AS max_name
FROM dual;

SELECT first_name,
       last_name
FROM employees
WHERE employee_id IN (
      SELECT manager_id 
      FROM employees);

SELECT department_name,
       MIN(salary),
       MAX(salary)
FROM (
     SELECT salary, department_name 
     FROM employees e
     JOIN departments d
     ON  (e.department_id = d.department_id))
GROUP BY department_name;
       
--                                          SINGLE-ROW SUBQUERY       

SELECT MAX(salary)
FROM employees;  -- max salary: 24000

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary < 24000 / 5;

-- or

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary < (
      SELECT MAX(salary) 
      FROM employees) / 5;

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT AVG(salary) 
      FROM employees);

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary >= (
      SELECT salary 
      FROM employees 
      WHERE employee_id = 180);

-----
-- 01:
SELECT AVG(salary) 
FROM employees 
GROUP BY job_id;

-- 02:
SELECT MAX(AVG(salary)) 
FROM employees 
GROUP BY job_id;

-- 03:
SELECT job_title
FROM jobs j
JOIN employees e
ON (j.job_id = e.job_id)
GROUP BY job_title;

-- 04:
SELECT job_title
FROM jobs j
JOIN employees e
ON (j.job_id = e.job_id)
GROUP BY job_title
HAVING AVG(salary) = (
       SELECT MAX(AVG(salary)) 
       FROM employees 
       GROUP BY job_id);


--                                          MULTYPLE-ROW SUBQUERY       
-- ANY (115 st)
-- ALL (124 st)

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE job_id IN (
      SELECT job_id 
      FROM jobs 
      WHERE min_salary > 8000);

---

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT salary 
      FROM employees 
      WHERE department_id = 100); -- NOT WORK

-- work with ANY:

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT MIN(salary) 
      FROM employees 
      WHERE department_id = 100)
ORDER BY salary DESC;

-- or

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > ANY(
      SELECT salary 
      FROM employees 
      WHERE department_id = 100);

-- work with ALL:

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT MAX(salary)
      FROM employees 
      WHERE department_id = 100)
ORDER BY salary;

--or

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > ALL(
      SELECT salary 
      FROM employees 
      WHERE department_id = 100);

----

SELECT DISTINCT department_name
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id);

-- or

SELECT department_name
FROM departments
WHERE department_id IN (
      SELECT DISTINCT department_id 
      FROM employees);

--                                          CORRELATED SUBQUERY       
        
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT AVG(salary) 
      FROM employees);
       
SELECT e1.first_name,
       e1.last_name,
       e1.salary
FROM employees e1
WHERE e1.salary > (
      SELECT AVG(e2.salary) 
      FROM employees e2 
      WHERE e2.department_id = e1.department_id);
       
--                                          Example:
-- Tables:     MODELS                BUYERS               PAYMENT                      ORDERS
--          id |  name         id | name | city         id | type          id | model_id | buyer_id | type_id 
--          ----------         ------------------       ----------         ----------------------------------
--           1 | C-200          1 | Ivan | Moscow        1 | cash           1 |    1     |    1     |   2
--           2 | E-300          2 | Zaur | Baku          2 | card           2 |    3     |    2     |   1  (search info: S-500, Baku, cash)
--           3 | S-500          3 | Petr | London        3 | credit         3 |    3     |    3     |   1

SELECT * 
FROM orders o
JOIN models m
ON (o.model_id = m.id) 
JOIN buyers b
ON (o.buyer_id = b.id)
JOIN payment p
ON (o.type_id = p.id)
WHERE m.name = 'S-500' 
      AND b.city = 'Baku'
      AND p.type = 'cash';

-- or

SELECT *
FROM orders
WHERE model_id IN (
      SELECT id 
      FROM models 
      WHERE name = 'S-500')
  AND buyer_id IN (
      SELECT id 
      FROM buyers 
      WHERE city = 'Baku')
  AND payment_id IN (
      SELECT id 
      FROM models 
      WHERE type = 'cash');
      
----

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM countries;

-- 01:
SELECT country_id 
FROM countries 
WHERE country_name = 'United Kingdom';

-- 02:
SELECT location_id 
FROM locations 
WHERE country_id IN (
      SELECT country_id 
      FROM countries 
      WHERE country_name = 'United Kingdom');

-- 03:
SELECT department_id 
FROM departments 
WHERE location_id IN (
      SELECT location_id 
      FROM locations 
      WHERE country_id IN (
          SELECT country_id 
          FROM countries 
          WHERE country_name = 'United Kingdom'));

-- 04:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE department_id IN (
      SELECT department_id 
      FROM departments 
      WHERE location_id IN (
          SELECT location_id 
          FROM locations 
          WHERE country_id IN (
              SELECT country_id 
              FROM countries 
              WHERE country_name = 'United Kingdom')));

----

-- 01:
SELECT AVG(salary) 
FROM employees;

-- 02:
SELECT job_id 
FROM jobs 
WHERE UPPER(job_title) LIKE '%MANAGER';

-- 03:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE job_id IN (
      SELECT job_id 
      FROM jobs 
      WHERE UPPER(job_title) LIKE '%MANAGER')
 AND salary > (
      SELECT AVG(salary) 
      FROM employees);

----

-- 01:
SELECT first_name, salary 
FROM employees 
WHERE INITCAP(first_name) = 'David';

-- 02:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
      SELECT MAX(salary) 
      FROM employees 
      WHERE INITCAP(first_name) = 'David')
ORDER BY salary; 

-- or

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > ALL(
      SELECT salary 
      FROM employees 
      WHERE INITCAP(first_name) = 'David');
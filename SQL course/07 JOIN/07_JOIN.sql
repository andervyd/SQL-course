--                                          JOIN
-- INNER JOIN  (9 st) -
--      SELF JOIN (315 st)
-- OUTER JOIN  (338 st)
-- CROSS JOIN  (464 st)
-- ORACLE JOIN (486 st)

-- EQUIJOIN
-- NONEQUIJOIN (267 st)

--                                          INNER JOIN (NATURAL JOIN)
-- NUTURAL JOIN (17 st)
-- USING        (84 st)
-- ON           (143 st)

-- First table:  source
-- Second table: target

--                                          NUTURAL JOIN
-- SELECT column(s)
-- FROM table_source
-- NATURAL JOIN table_target
-- WHERE condition(s);

SELECT *
FROM regions;

SELECT *
FROM countries;

SELECT *
FROM regions
NATURAL JOIN countries;

SELECT *
FROM regions
NATURAL JOIN countries
WHERE region_name = 'Europe';

SELECT region_id,
       region_name,
       country_id,
       country_name
FROM regions
NATURAL JOIN countries;

SELECT region_id,
       regions.region_name,
       countries.country_id,
       countries.country_name
FROM regions 
NATURAL JOIN countries;

SELECT region_id,
       r.region_name,
       c.country_id,
       c.country_name
FROM regions r
NATURAL JOIN countries c;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT e.first_name,
       e.last_name, 
       e.salary,
       d.department_name,
       department_id,
       manager_id
FROM employees e
NATURAL JOIN departments d;

SELECT *
FROM employees;

SELECT *
FROM countries;

SELECT *               -- NOT
FROM employees
NATURAL JOIN countries;

--                                          NUTURAL JOIN with USING
-- SELECT column(s)
-- FROM table_source
-- JOIN table_target
-- USING (column(s))
-- WHERE condition(s);

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT first_name,
       last_name, 
       salary,
       department_name,
       department_id,
       e.manager_id AS end_manager,
       d.manager_id AS dep_manager
FROM employees e
JOIN departments d
USING (department_id);

SELECT first_name,
       last_name, 
       salary,
       department_name,
       department_id,
       manager_id
FROM employees e
JOIN departments d
USING (department_id, manager_id);

SELECT *
FROM countries;

SELECT *
FROM regions;

SELECT *
FROM countries
JOIN regions
USING (region_id);

SELECT *
FROM employees;

SELECT *
FROM job_history;

SELECT first_name,
       last_name, 
       e.job_id,
       start_date, 
       end_date
FROM employees e
JOIN job_history jh
USING (employee_id);

--                                          NUTURAL JOIN with ON
-- SELECT column(s)
-- FROM table_source
-- JOIN table_target
-- ON (column_one = column_two)
-- WHERE condition(s);
 
SELECT first_name,
       last_name, 
       employees.job_id,
       start_date, 
       end_date,
       employees.employee_id,
       job_history.employee_id
FROM employees
JOIN job_history
ON (employees.employee_id = job_history.employee_id);

SELECT *
FROM regions;

SELECT *
FROM departments;

SELECT *
FROM departments
JOIN regions
ON (region_id * 10 = department_id);

SELECT first_name,
       last_name, 
       jh.job_id,
       start_date, 
       end_date
FROM employees
JOIN job_history jh
USING (employee_id, department_id);

SELECT first_name,
       last_name, 
       jh.job_id,
       start_date, 
       end_date
FROM employees e
JOIN job_history jh
ON (e.employee_id = jh.employee_id 
    AND e.department_id = jh.department_id);

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT first_name,
       department_name
FROM employees
JOIN departments
ON (employee_id = departments.manager_id);

--                                          Join more tables
--                                          NATURAL JOIN : example

SELECT *
FROM regions;

SELECT *
FROM locations;

SELECT *
FROM countries;

SELECT *
FROM locations
NATURAL JOIN countries 
NATURAL JOIN regions;

--                                          USING JOIN : example

SELECT *
FROM locations
JOIN countries 
USING (country_id)
JOIN regions 
USING (region_id);

--                                          ON JOIN : example

SELECT first_name,
       last_name,
       jh.job_id,
       start_date,
       end_date,
       department_name
FROM employees e
JOIN job_history jh
ON (e.employee_id = jh.employee_id)
JOIN departments d
ON (jh.department_id = d.department_id);

--                                          All JOIN : example

SELECT first_name,
       last_name,
       jh.job_id,
       start_date,
       end_date,
       department_name
FROM employees e
JOIN job_history jh
USING (employee_id)
JOIN departments d
ON (jh.department_id = d.department_id);

SELECT department_name,       
       MIN(salary),
       MAX(salary)
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
GROUP BY department_name 
ORDER BY department_name DESC;

--                                          NONEQUIJOIN with ON

-- SELECT column(s)
-- FROM table_source
-- JOIN table_target
-- ON (column_one {inequality operator} column_two);

SELECT *
FROM jobs;

SELECT first_name,
       salary,
       min_salary,
       max_salary
FROM employees e
JOIN jobs j
ON (e.job_id = j.job_id 
    AND salary * 2 < max_salary);

SELECT first_name,
       salary,
       min_salary,
       max_salary
FROM employees e
JOIN jobs j
ON (e.job_id = j.job_id 
    AND salary = max_salary);

SELECT first_name,
       salary,
       min_salary,
       max_salary
FROM employees e
JOIN jobs j
ON (e.job_id = j.job_id 
    AND salary < max_salary);

SELECT first_name,
       salary,
       min_salary,
       max_salary
FROM employees e
JOIN jobs j
ON (e.job_id = j.job_id 
    AND 
    salary BETWEEN min_salary + 2000 AND max_salary - 3000);

--                                          SELF JOIN

SELECT employee_id,
       first_name,
       manager_id
FROM employees;

SELECT emp1.employee_id,
       emp1.first_name,
       emp1.manager_id,
       emp2.first_name AS manager_name
FROM employees emp1
JOIN employees emp2
ON (emp1.manager_id = emp2.employee_id);

SELECT emp2.first_name AS manager_name,
       COUNT(*)
FROM employees emp1
JOIN employees emp2
ON (emp1.manager_id = emp2.employee_id)
GROUP BY emp2.first_name
ORDER BY COUNT(*) DESC;

--                                          OUTER JOIN
-- LEFT OUTER JOIN  (343 st)
-- RIGHT OUTER JOIN (409 st)
-- FULL OUTER JOIN  (436 st)

--                                          LEFT OUTER JOIN
-- INNER JOIN => LEFT TABLE

-- SELECT column(s)
-- FROM table_source
-- LEFT OUTER JOIN table_target
-- ON (column_one = column_two);
 
SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT first_name,
       last_name,
       salary,
       department_name
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id);
 
SELECT first_name,
       last_name,
       salary,
       department_name
FROM employees e
LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT first_name,
       last_name,
       salary,
       department_name
FROM departments d
LEFT OUTER JOIN employees e
ON (e.department_id = d.department_id);

SELECT postal_code,
       city,
       department_id
FROM locations l
JOIN departments d
ON (d.location_id = l.location_id);

SELECT postal_code,
       city,
       department_id
FROM locations l
LEFT OUTER JOIN departments d
ON (d.location_id = l.location_id);

SELECT department_name,
       d.department_id,
       first_name
FROM departments d
LEFT OUTER JOIN employees e
ON (d.department_id = e.department_id);


SELECT department_name,
       d.department_id,
       first_name
FROM departments d
LEFT OUTER JOIN employees e
ON (d.department_id = e.department_id)
WHERE first_name IS NULL;

--                                          RIGHT OUTER JOIN
-- INNER JOIN => RIGHT TABLE

-- SELECT column(s)
-- FROM table_source
-- RIGHT OUTER JOIN table_target
-- ON (column_one = column_two);
 
SELECT first_name,
       last_name,
       salary,
       department_name
FROM departments d
RIGHT OUTER JOIN employees e
ON (e.department_id = d.department_id);

SELECT *
FROM countries;

SELECT *
FROM locations;

SELECT country_name,
       city,
       street_address
FROM locations l
RIGHT OUTER JOIN countries c
ON (l.country_id = c.country_id);

--                                          FULL OUTER JOIN
-- INNER JOIN => LEFT TABLE => RIGHT TABLE

-- SELECT column(s)
-- FROM table_source
-- FULL OUTER JOIN table_target
-- ON (column_one = column_two);
 
SELECT first_name,
       last_name,
       salary,
       department_name
FROM departments d
FULL OUTER JOIN employees e
ON (e.department_id = d.department_id);

SELECT NVL(first_name, 'no employee') AS first_name,
       NVL(last_name, 'no employee') AS last_name,
       NVL(salary, 0) AS salary,
       NVL(department_name, 'no department') AS department
FROM departments d
FULL OUTER JOIN employees e
ON (e.department_id = d.department_id);

--                                          CROSS JOIN
-- Cartesian product

-- SELECT column(s)
-- FROM table_source
-- CROSS JOIN table_target;
 
SELECT *
FROM countries;

SELECT *
FROM regions;

SELECT COUNT(*)
FROM countries
CROSS JOIN regions;

SELECT *
FROM countries
CROSS JOIN regions
ORDER BY country_id;

--                                          ORACLE JOIN SYNTAX
-- INNER JOIN: 

-- SELECT column(s)
-- FROM table_1 t1,
--      table_2 t2
-- WHERE t1.column_1 = t2.column_2;

SELECT first_name,
       last_name,
       salary,
       d.department_id,
       department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- RIGHT OUTER JOIN: 

-- SELECT column(s)
-- FROM table_1 t1,
--      table_2 t2
-- WHERE t1.column_1(+) = t2.column_2;

SELECT first_name,
       last_name,
       salary,
       d.department_id,
       department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;

-- LEFT OUTER JOIN: 

-- SELECT column(s)
-- FROM table_1 t1,
--      table_2 t2
-- WHERE t1.column_1 = t2.column_2(+);

SELECT first_name,
       last_name,
       salary,
       d.department_id,
       department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

-- CROSS JOIN: 

-- SELECT column(s)
-- FROM table_1 t1,
--      table_2 t2;

SELECT first_name,
       last_name,
       salary,
       d.department_id,
       department_name
FROM employees e, departments d;
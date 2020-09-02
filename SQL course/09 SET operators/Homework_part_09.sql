-- task 01:
SELECT manager_id,
       TO_CHAR(NULL) AS job_id,
       TO_NUMBER(NULL) AS department_id,
       SUM(salary) AS sum_salary
FROM employees
GROUP BY manager_id
UNION
SELECT TO_NUMBER(NULL),
       job_id,
       TO_NUMBER(NULL),
       SUM(salary)
FROM employees
GROUP BY job_id
UNION
SELECT TO_NUMBER(NULL),
       TO_CHAR(NULL),
       department_id,
       SUM(salary)
FROM employees
GROUP BY department_id;

-- task 02:
SELECT department_id
FROM employees
WHERE manager_id = 100
MINUS
SELECT department_id
FROM employees
WHERE manager_id IN (145, 201);

-- task 03:
SELECT first_name,
       last_name, 
       salary
FROM employees
WHERE first_name LIKE '_a%'
INTERSECT
SELECT first_name,
       last_name, 
       salary
FROM employees
WHERE LOWER(last_name) LIKE '%s%'
ORDER BY salary DESC;

-- task 04:
SELECT location_id,
       postal_code,
       city
FROM locations
WHERE country_id IN (
      SELECT country_id
      FROM countries
      WHERE country_name IN ('Italy', 'Germany'))
UNION ALL 
SELECT location_id,
       postal_code,
       city
FROM locations
WHERE postal_code LIKE '%9%';

-- task 05:
SELECT country_id AS id,
       country_name AS country,
       region_id AS region
FROM countries
WHERE LENGTH(country_name) > 8 
UNION
SELECT *
FROM countries
WHERE region_id != (
      SELECT region_id
      FROM regions
      WHERE region_name = 'Europe')
ORDER BY country DESC;
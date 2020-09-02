-- task 01:
SELECT *
FROM employees
WHERE LENGTH(first_name) = (
      SELECT MAX(LENGTH(first_name)) 
      FROM employees);

-- task 02:
SELECT *
FROM employees
WHERE salary > (
      SELECT AVG(salary) 
      FROM employees)
ORDER BY salary DESC;

-- task 03:
SELECT MIN(SUM(salary)) 
FROM employees 
GROUP BY manager_id;

SELECT 'City: ' || city  AS city_min_salary
FROM locations 
WHERE location_id IN (
      SELECT location_id 
      FROM departments 
      WHERE manager_id IN (
         SELECT employee_id 
         FROM employees 
         WHERE salary < (
            SELECT MIN(SUM(salary)) 
            FROM employees 
            GROUP BY manager_id))); -- NOT CORRECT
      
----
-- 01:
SELECT 'City: ' || city  AS city_min_salary, 
       SUM(salary)
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id)
GROUP BY city;

-- 02:
SELECT MIN(SUM(salary))
FROM employees e
JOIN departments d 
ON (e.department_id = d.department_id)
JOIN locations l 
ON (d.location_id = l.location_id)
GROUP BY city;
       
-- 03: (connect)       
SELECT 'City: ' || city  AS city_min_salary
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id)
GROUP BY city
HAVING SUM(salary) = (
       SELECT MIN(SUM(salary)) 
       FROM employees e
       JOIN departments d 
       ON (e.department_id = d.department_id)
       JOIN locations l 
       ON (d.location_id = l.location_id)
       GROUP BY city);

-- task 04:
SELECT job_id 
FROM jobs 
WHERE UPPER(job_title) LIKE '%MANAGER';

SELECT salary 
FROM employees 
WHERE job_id = ANY(
       SELECT job_id 
       FROM jobs 
       WHERE UPPER(job_title) LIKE '%MANAGER');
       
----

SELECT *
FROM employees
WHERE manager_id IN(
      SELECT employee_id 
      FROM employees 
      WHERE salary > 1500); 
 
-- task 05:
SELECT * 
FROM employees 
WHERE department_id IS NULL; 

----
SELECT *
FROM departments
WHERE department_id NOT IN(
      SELECT DISTINCT department_id
      FROM employees 
      WHERE department_id IS NOT NULL);

-- task 06:
SELECT DISTINCT manager_id,
       first_name FROM employees 
       WHERE manager_id IS NULL;

SELECT *
FROM employees 
WHERE employee_id NOT IN(
      SELECT DISTINCT manager_id
      FROM employees 
      WHERE manager_id IS NOT NULL);

----

SELECT *
FROM employees
WHERE manager_id IS NULL;

-- task 07:
SELECT DISTINCT manager_id
FROM employees 
WHERE manager_id IS NOT NULL;

SELECT *
FROM employees e
WHERE (
      SELECT COUNT(*)
      FROM employees
      WHERE manager_id = e.manager_id) > 6;

-- task 08:
SELECT *
FROM employees 
WHERE  job_id = ALL(
      SELECT job_id
      FROM employees 
      WHERE UPPER(job_id) LIKE '%IT%');

----
SELECT *
FROM employees 
WHERE  department_id = (
      SELECT department_id
      FROM departments 
      WHERE department_name = 'IT');

-- task 09:
SELECT *
FROM employees
WHERE manager_id IN(
      SELECT employee_id
      FROM employees
      WHERE TO_CHAR(hire_date, 'YYYY') = '1995')
  AND hire_date < TO_DATE('010195', 'DDMMYY');   -- WORK

SELECT emp.*
FROM employees emp
JOIN employees man   ON (emp.manager_id = man.employee_id)
WHERE TO_CHAR(man.hire_date, 'YYYY') = '1995'
      AND emp.hire_date < TO_DATE('01-01-2005', 'DD-MM-YYYY');
      
SELECT emp.*
FROM employees emp
WHERE TO_CHAR(hire_date, 'YYYY') = '1995';

-- task 10:
SELECT *
FROM employees e
WHERE manager_id IN(
      SELECT employee_id
      FROM employees
      WHERE TO_CHAR(hire_date, 'MON') = 'JAN')
  AND (SELECT LENGTH(job_title)
      FROM jobs
      WHERE job_id = e.job_id) > 5;   -- WORK

----
SELECT employee_id, TO_CHAR(hire_date, 'Month')
FROM employees
WHERE TO_CHAR(hire_date, 'MON') = 'JAN';

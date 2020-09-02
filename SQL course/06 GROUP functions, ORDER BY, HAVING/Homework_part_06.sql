-- Task 01
SELECT department_id,
       MIN(salary)    AS min_salary,
       MAX(salary)    AS max_salary,
       MIN(hire_date) AS min_date,
       MAX(hire_date) AS max_date,
       COUNT(*)       AS count_staff
FROM employees
GROUP BY department_id
ORDER BY count_staff DESC;

-- Task 02
SELECT SUBSTR(first_name, 1, 1) AS first_char,
       COUNT(*)     
FROM employees
GROUP BY SUBSTR(first_name, 1, 1)
HAVING COUNT(*) > 1
ORDER BY 2 DESC;

-- Task 03
SELECT department_id AS id,
       TO_CHAR(salary, '$999,999') AS salary,  
       COUNT(*) AS cn
FROM employees
GROUP BY department_id,
         TO_CHAR(salary, '$999,999');
         
-- Task 04
SELECT TO_CHAR(hire_date, ' DDTh "of" Day') AS hire_date, 
       ' staff: ' || COUNT(*) AS staff
FROM employees
GROUP BY TO_CHAR(hire_date, ' DDTh "of" Day');

-- Task 05
SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 30
       AND
       SUM(salary) > 300000;

-- Task 06
SELECT region_id
FROM countries
GROUP BY region_id
HAVING SUM(LENGTH(country_name)) > 50;

-- Task 07
SELECT job_id,
       TO_CHAR(ROUND(AVG(salary)), '$999,999') AS avg_salary
FROM employees
GROUP BY job_id;

-- Task 08
SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(DISTINCT job_id) > 1;

-- Task 09
SELECT department_id,
       job_id,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM employees
GROUP BY department_id,
         job_id
HAVING AVG(salary) > 10000;

-- Task 10
SELECT manager_id
FROM employees
WHERE commission_pct IS NULL
GROUP BY manager_id
HAVING AVG(salary) BETWEEN 6000 AND 9000;

-- Task 11
SELECT ROUND(MAX(AVG(salary)), -3) AS max_salary
FROM employees
GROUP BY department_id;
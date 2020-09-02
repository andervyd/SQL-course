/* https://habr.com/ru/post/461567/ */

--                                          Restricting and Sorting Data
SELECT *
FROM employees;

SELECT *
FROM employees
WHERE first_name = 'David';

SELECT *
FROM employees
WHERE job_id = 'IT_PROG';

SELECT *
FROM employees
WHERE department_id = 50
      AND salary > 4000;

SELECT *
FROM employees
WHERE department_id IN (20, 30);

SELECT *
FROM employees
WHERE first_name LIKE '%a';

SELECT *
FROM employees
WHERE department_id IN (50, 80) 
      AND commission_pct IS NOT NULL;

SELECT *
FROM employees
WHERE first_name LIKE '%n%n%';

SELECT *
FROM employees
WHERE first_name LIKE '%____%';

SELECT *
FROM employees
WHERE salary BETWEEN 8000 AND 9000;


SELECT *
FROM employees
WHERE first_name LIKE '%\%%' ESCAPE '\';


SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL;


SELECT first_name || ' (' || LOWER(job_id) || ')'
FROM employees;

--                                          Using Single-Row Functions to Customize Output




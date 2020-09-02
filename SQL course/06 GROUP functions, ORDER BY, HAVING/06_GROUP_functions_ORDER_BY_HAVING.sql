--                                          Group functions (Multiple-row)
-- COUNT (8 st)  
-- SUM   (60 st)
-- AVG   (87 st)
-- MAX   (119 st)
-- MIN   (121 st)

--                                          COUNT
-- COUNT({ * | DISTINCT | ALL } expression })

select COUNT(*)
from employees;

select COUNT(*)
from employees
where salary > 5000;

select COUNT(salary)
from employees;

select COUNT(ALL salary)
from employees;

select COUNT(commission_pct)
from employees;

select COUNT(DISTINCT commission_pct)
from employees;

select COUNT(NVL(commission_pct, 0))
from employees;

select COUNT(DISTINCT(NVL(commission_pct, 0)))
from employees;

select COUNT(*), COUNT(commission_pct), COUNT(DISTINCT commission_pct)
from employees;

select COUNT(first_name)
from employees;

select COUNT(DISTINCT first_name)
from employees;

select COUNT(first_name), COUNT(DISTINCT first_name)
from employees;

select first_name, last_name, 'abs'
from employees;

select COUNT('abs')
from employees;

select COUNT(*) as counter
from employees;

select COUNT(*), first_name -- NOT
from employees;

--                                          SUM
-- SUM({DISTINCT | ALL} expression)

select SUM(salary) as all_salary
from employees;

select to_char(SUM(salary), '$999,999.99') as all_salary
from employees;

select SUM(commission_pct)
from employees;

select SUM(DISTINCT(commission_pct))
from employees;

select SUM(first_name) -- NOT
from employees;

select SUM(7)
from employees;

select SUM('7')
from employees;

select 'Work years: ' || round(SUM(sysdate - hire_date) / 365.25) as years
from employees;

--                                          AVG (average)
-- AVG({ * | DISTINCT | ALL } expression })

select AVG(7)
from employees;

select AVG(salary)
from employees;

SELECT SUM(salary) / COUNT(salary)
FROM employees;

select AVG(salary)
from employees
where job_id = 'IT_PROG';

select 'Average salary: ' || TO_CHAR(ROUND(AVG(salary)), '$99,999.99') as average
from employees;

select TO_CHAR(ROUND(AVG(salary)), '$9,999.99') as average,
       TO_CHAR(ROUND(AVG(DISTINCT(salary))), '$9,999.99') as average_distinct
from employees;

select 'Years: ' || ROUND(AVG(sysdate - hire_date) / 360.25) as avg_work
from employees;

select ROUND(AVG(commission_pct), 2)
from employees;

select ROUND(AVG(NVL(commission_pct, 0)), 2)
from employees;

--                                          MIN
-- MIN({DISTINCT | ALL} expression)
--                                          MAX
-- MAX({DISTINCT | ALL} expression)

select MIN(salary),
       MAX(salary)
from employees
where department_id = 50;

select MIN(hire_date),
       MAX(hire_date)
from employees;

select MIN(last_name),
       MAX(last_name)
from employees;

select MIN(LENGTH(last_name)),
       MAX(LENGTH(last_name))
from employees;

--                                          GROUP BY

-- SELECT * | {DISTINCT column(s) alias, expression(s) alias, 
--        group_function(s) column | expression alias),}
-- FROM table_name
-- WHERE condition(s)
-- GROUP BY {column(s) | expression(s)}
-- ORDER BY {column(s) expression(s) | numeric position}
--     {ASC | DESC} {NULLS FIRST | NULLS LAST};

select department_id, 
       COUNT(*),
       TO_CHAR(AVG(salary), '$999,999.99') as avg_salary
from employees
group by department_id
order by 1, 2;

select job_id,
       TO_CHAR(MIN(salary), '$999,999.99') AS min_salary,
       TO_CHAR(MAX(salary), '$999,999.99') AS max_salary,
       TO_CHAR(AVG(salary), '$999,999.99') AS avg_salary
from employees
group by job_id
order by max_salary DESC;

select TO_CHAR(hire_date, 'Month') AS months,
       COUNT(*) AS count
from employees
group by TO_CHAR(hire_date, 'Month')
order by count DESC;

SELECT location_id,
       COUNT(*)
FROM departments
GROUP BY location_id;

SELECT department_id,
       COUNT(*)
FROM employees
GROUP BY department_id;

SELECT job_id,
       COUNT(*)
FROM employees
GROUP BY job_id;

SELECT department_id, job_id,
       COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1;

SELECT department_id, manager_id,
       COUNT(*)
FROM employees
GROUP BY department_id, manager_id;

SELECT job_id,
       TO_CHAR(hire_date, 'YYYY') AS year,
       SUM(salary)
FROM employees
WHERE job_id IN('ST_CLERK', 'SA_REP', 'SH_CLERK')
GROUP BY job_id, TO_CHAR(hire_date, 'YYYY')
ORDER BY job_id, year;

SELECT job_id,
       TO_CHAR(hire_date, 'YYYY') AS year,
       commission_pct AS commission,
       COUNT(*),
       TO_CHAR(SUM(salary), '$999,999.99') AS salary
FROM employees
WHERE job_id IN('ST_CLERK', 'SA_REP', 'SH_CLERK')
GROUP BY job_id, TO_CHAR(hire_date, 'YYYY'), commission_pct
ORDER BY job_id, year;

--                                          GROUP BY WITH HAVING

-- SELECT * | {DISTINCT column(s) alias, expression(s) alias, 
--        group_function(s) column | expression alias),}
-- FROM table_name
-- WHERE condition(s)
-- GROUP BY {column(s) | expression(s)}
-- HAVING group_condition(s)
-- ORDER BY {column(s) expression(s) | numeric position}
--     {ASC | DESC} {NULLS FIRST | NULLS LAST};

SELECT *
FROM employees
WHERE salary > 10000;

SELECT department_id,
       COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id,
       COUNT(*)
FROM employees
WHERE COUNT(*) > 3 -- NOT
GROUP BY department_id
ORDER BY department_id;

SELECT department_id,
       COUNT(*)
FROM employees
WHERE LENGTH(first_name) > 4
GROUP BY department_id
HAVING COUNT(*) > 3
ORDER BY department_id;

SELECT department_id,
       COUNT(*),
       TO_CHAR(ROUND(AVG(salary)), '$999,999.99')
FROM employees
WHERE LENGTH(first_name) > 4
GROUP BY department_id
HAVING COUNT(*) > 3 
       AND ROUND(AVG(salary)) > 5000
ORDER BY department_id;

--                                          Nested group fuctions
-- Single row functions:   WORK
-- Multiple row functions: NOT WORK

SELECT department_id,
       TO_CHAR(ROUND(AVG(salary)), '$999,999.99')
FROM employees
GROUP BY department_id;

SELECT TO_CHAR(SUM(ROUND(AVG(salary))), '$999,999.99') AS total_salary
FROM employees
GROUP BY department_id;

SELECT TO_CHAR(MAX(SUM(ROUND(AVG(salary))), '$999,999.99')) AS total_salary -- NOT
FROM employees
GROUP BY department_id;

SELECT ROUND(SUM(AVG(LENGTH(UPPER(first_name)))))
FROM employees
GROUP BY department_id;
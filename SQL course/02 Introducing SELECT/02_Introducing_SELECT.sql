--                                          SELECT
--                                          Three concepts:
-- PROJECTION - selecting columns from a table (8 st)
-- SELECTION  - selecting rows from a table    (03_Selection_operators_ORDER BY.sql, 1 st) 
-- JOINING    - concatenation of tables

--                                          SELECT statement (does not change data)
--                                          PROJECTION concept - 
--                                          Basic syntax
-- SELECT * 
-- FROM table_name;

SELECT * 
FROM HR.EMPLOYEES;
-- or
select * 
from employees;

select country_name
from countries;

select region_id, country_name
from countries;

--                                          DISTINCT
-- getting unique values

-- SELECT DISTINCT column(s) 
-- FROM table_name;

select DISTINCT job_id 
from job_history;

select DISTINCT job_id, department_id 
from job_history;

select DISTINCT commission_pct
from employees;

--                                          Operations for text data
-- concatenation ||
-- for string ''

select 'Employee: ' || first_name || ' ' || last_name name, 
       'salary: ' || salary salary 
from employees;

select 'Employee: ' || first_name || ' ' || last_name as name, 
       'salary: ' || salary as salary 
from employees; 

--                                          Operations for numerical data
-- addition "+"
-- subtraction "-"
-- multiplication "*" 
-- division "/"
-- brackets "()"
-- NULL returns NULL
-- for DATE +1 (returns days)

--                                          Expression in select list
-- SELECT column(s), expression(s) 
-- FROM table_name;

select last_name, salary, salary * 2
from employees;

select start_date, end_date, (end_date - start_date) + 1 
from job_history;

select start_date, start_date + 7
from job_history;

--                                          Table DUAL
-- consists of one column and one row
select *
from dual;

--                                          Alias
-- SELECT column(s) alias, expression(s) alias 
-- FROM table_name

-- as:
select 'Hello World!' as greeting
from dual;

-- ""
select 'Hello World!' "My greeting"
from dual;

-- _
select 'Hello World!' my_greeting
from dual;

--                                          Single quote problems
select 'It''s my life'
from dual;

select q'<It's my life>'
from dual;
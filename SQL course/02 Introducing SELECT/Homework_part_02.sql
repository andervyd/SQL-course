-- Task 01:
select * 
from regions;

-- Task 02:
select 
    first_name, department_id, salary, last_name 
from employees;

-- Task 03:
select 
    employee_id, email, 
    hire_date - 7 "One week before hire date"
from employees;

-- Task 04:
select 
    first_name || '{' || job_id || ')' as out_employee  
from employees;

-- Task 05:
select distinct first_name
from employees;

-- Task 06:
select job_title,
       'min = ' || min_salary || ', max = ' || max_salary as info, 
       max_salary as max,
       (max_salary * 2) - 2000 as new_salary 
from jobs;

-- Task 07:
select q'<Peter's dog is very clever>' 
from dual;

-- Task 08 task:
select 'Peter''s dog is very clever' 
from dual;

-- Task 09:
select 100 * 365 * 24 * 60 
from dual;
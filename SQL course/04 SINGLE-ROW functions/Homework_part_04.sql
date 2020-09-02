-- Task 01
select *
from employees
where length(first_name) > 10;

-- Task 02
select *
from employees
where mod(salary, 1000) = 0;

-- Task 03
select phone_number, 
       substr(phone_number, 1, 3)
from employees
where phone_number like '___.___.____';

-- Task 04
select *
from employees
where substr(first_name, -1) = 'm' 
      and length(first_name) > 5;

-- Task 05
select next_day(sysdate, 'FRIDAY')
from dual;

-- Task 06
select *
from employees
where months_between(sysdate, hire_date) > 150;

-- Task 07
select replace(phone_number, '.', '-') as new_phone
from employees;

-- Task 08
select upper(first_name), 
       lower(email), 
       initcap(job_id)
from employees; 

-- Task 09
select concat(first_name, salary)
from employees;

-- Task 10
select hire_date, 
       round(hire_date, 'MM') as round_MM,
       trunc(hire_date, 'YYYY') as trunc_YYYY
from employees;

-- Task 11
select rpad(first_name, 10, '$'), 
       lpad(last_name, 15, '!')
from employees;

-- Task 12
select first_name, 
       instr(first_name, 'a', 1, 2) as letter_position
from employees;

-- Task 13
select  '!!!HELLO!! MY FRIEND!!!!!!!!', 
        trim('!' from '!!!HELLO!! MY FRIEND!!!!!!!!')
from dual;

-- Task 14 
select salary,
       salary * 3.1415 as multy,
       round(salary * 3.1415) as round,
       trunc(salary * 3.1415, -3) / 1000 as trunc
from employees;

-- Task 15
select hire_date,
       add_months(hire_date, 6) as add_six_moths,
       last_day(hire_date)
from employees;
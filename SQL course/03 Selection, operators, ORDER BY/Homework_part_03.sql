-- Task 01:
select * 
from employees
where first_name = 'David';

-- Task 02:
select *
from employees
where job_id = 'FI_ACCOUNT';

-- Task 03:
select first_name, last_name, salary, department_id
from employees
where department_id = 50 and salary > 4000;

-- Task 04:
select * 
from employees
where department_id in (20, 30);

-- Task 05:
select *
from employees
where first_name like '_a%a';

-- Task 06:
select *
from employees
where department_id in (50, 80) and 
      commission_pct is not null
order by 4;      

-- Task 07:
select *
from employees
where first_name like '%n%n%';

-- Task 08:
select *
from employees
where first_name like '%_____%'
order by department_id desc nulls last;

-- Task 9:
select *
from employees
where salary between 3000 and 7000 
      and commission_pct is null
      and job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

-- Task 10:
select *
from employees
where first_name like '%?%%' escape '?';

-- Task 11:
select job_id, first_name, salary
from employees
where employee_id >= 120 
      and job_id != 'IT_PROG'
order by 1, 2 desc;       
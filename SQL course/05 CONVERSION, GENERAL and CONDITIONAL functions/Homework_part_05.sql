-- Task 01
select *
from employees
where instr(lower(first_name), 'b') > 0;

-- Task 02
select *
from employees
where instr(lower(first_name), 'a', 1, 2) > 0;

-- Task 03
select substr(department_name, 1, instr(department_name, ' ') - 1) 
from departments
where instr(department_name, ' ') > 0;

-- Task 04
select first_name, substr(first_name, 2, (length(first_name) - 2))
from employees;

-- Task 05
select *
from employees
where (length(job_id) - instr(job_id, '_')) > 2
      and not instr(job_id, 'CLERK') = (instr(job_id, '_') + 1);
-- or
select *
from employees
where length(substr(job_id, instr(job_id, '_') + 1)) > 2
      and substr(job_id, instr(job_id, '_') + 1) != 'CLERK';

-- Task 06
select *
from employees
where to_char(hire_date, 'dd') = '01';

-- Task 07
select *
from employees
where to_char(hire_date, 'YYYY') = 2008;

-- Task 08
select 'Tommoroy is ' || to_char((sysdate + 1), 'DdSpTh "day of" Month')
from dual;
-- or
select to_char(sysdate + 1, 'fm"Tommorow is" DdSpTh "day of" Month') as info
from dual;

-- Task 09
select first_name, to_char(hire_date, 'ddTh "of" fmMonth, yyyy')
from employees;

-- Task 10
select first_name, salary, to_char((salary / 100 * 20 + salary), '$99,999.99') as "20%"
from employees;
-- or
select first_name, to_char(salary  + salary * 0.20, '$99,999.99') as "20%"
from employees;

-- Task 11
select to_char(to_date(sysdate, 'dd-Mon-rr hh:mi:ss') + 1/24/60/60, 'dd-Mon-rr hh:mi:ss') as sec,
       to_char(to_date(sysdate, 'dd-Mon-rr hh:mi:ss') + 1/24/60, 'dd-Mon-rr hh:mi:ss') as min,
       to_char(to_date(sysdate, 'dd-Mon-rr hh:mi:ss') + 1/24, 'dd-Mon-rr hh:mi:ss') as hour,
       to_char(to_date(sysdate, 'dd-Mon-rr hh:mi:ss') + 1, 'dd-Mon-rr hh:mi:ss') as day,
       to_char(to_date(sysdate, 'dd-Mon-rr hh:mi:ss') + 30, 'dd-Mon-rr hh:mi:ss') as month,
       to_char(to_date(sysdate, 'dd-Mon-rr hh:mi:ss') + 365.25, 'dd-Mon-rr hh:mi:ss') as year
from dual;
-- or
select sysdate                      now,
       sysdate + 1 / (24 * 60 * 60) as sec,
       sysdate + 1 / (24 * 60)      as min,
       sysdate + 1 / 24             as hour,
       sysdate + 1                  as dat,
       add_months(sysdate, 1)       as month,
       add_months(sysdate, 12)      as year
from dual;

-- Task 12
select first_name, salary, salary + to_number('$12,345.55', '$99,999.99') as new_salary
from employees;

-- Task 13
select first_name, hire_date, 
       round((to_date('SEP, 18:45:00 18 2009', 'MON, hh24:mi:ss dd yyyy') - hire_date) / 30) as months
from employees;
-- or
select first_name, hire_date, 
       round(months_between(to_date('SEP, 18:45:00 18 2009', 'MON, hh24:mi:ss dd yyyy'), hire_date)) as months
from employees;

-- Task 14
select first_name, salary, to_char((salary / 100 * commission_pct) + salary, '$99,999.00')
from employees;
-- or
select first_name, salary, 
       to_char(salary + salary * NVL(Commission_pct, 0) , '$99,999.00')
from employees;

-- Task 15
select first_name,
       last_name,
       decode(length(first_name) - length(last_name), 0, 'same length', 'different length')
from employees;
-- or 
select first_name, last_name,
       nvl2(nullif(length(first_name), length(last_name)), 'different length', 'same length')
from employees;

-- Task 16
select first_name, commission_pct, nvl2(commission_pct, 'yes', 'no') 
from employees;

-- Task 17
select first_name, coalesce(commission_pct, manager_id, salary) as conditions
from employees;

-- Task 18
select first_name, salary,
    case
        when salary < 5000 then 'Low level'
        when salary >= 5000 
            and salary < 10000 then 'Normal level'
        when salary >= 10000 then 'High level'
    end
from employees;

-- Task 19
select decode(region_id, region_id, region_id || '-' || country_name)
from countries;
-- or
select country_name,
       decode(region_id, 1, 'Europe', 2, 'America', 3, 'Asia', 4, 'Africa', 'Unknown')
from countries;

-- Task 20
select 
case 
when region_id = region_id 
    then region_id || '-' || country_name
end
from countries;
-- or
select country_name,
    case region_id
        when 1 then 'Europe'
        when 2 then 'America'
        when 3 then 'Asia'
        when 4 then 'Africa'
    else 'Unknown'
end
from countries;

-- Task 21
select first_name, salary,
    case
        when salary < 10000 and commission_pct is null then 'BAD'
        when salary between 10000 and 15000 
            or commission_pct is not null then 'NORMAL'
        when salary >= 15000 then 'GOOD'
    end
from employees;
--                                          SELECTION concept - 

-- SELECT * | {DISTINCT column(s) alias, expression(s) alias} 
-- FROM table_name WHERE condition(s);

select first_name ||' '|| last_name as name, salary
from employees
WHERE salary = 17000;

select first_name, last_name
from employees
WHERE first_name = 'John';    

select *
from employees
WHERE hire_date = '17-JUN-87';

select * 
from job_history
WHERE job_id = 'ST_CLERK';

select *
from job_history
WHERE job_id = 'AC_ACCOUNT';

--                                          Mathematical comparison operators
-- Equal         =
-- More          >
-- Smaller       <
-- More equals   >=
-- Less is equal <=
-- Not equal     != or <>

select * 
from employees
where salary > 10000;

select *
from employees
where first_name > 'William';

select *
from employees
where hire_date > '05-JAN-00';

select * 
from employees
where first_name < 'B';

--                                          BETWEEN

select * 
from employees
where salary BETWEEN 4000 and 10000;

select * 
from job_history
where start_date BETWEEN '01-DEC-93' and '30-JUN-96';

select * 
from employees
where first_name BETWEEN 'A' and 'D';

--                                          IN

select *
from departments
where location_id IN (1700, 2400, 1400);

select * 
from job_history
where job_id in ('IT_PROG', 'SA_REP');

--                                          IS NULL

select * 
from employees
where commission_pct IS NULL;

--                                          LIKE
-- % - any number of characters
-- _ - any one character

select *
from employees
where first_name = 'Steven';

-- or

select *
from employees
where first_name LIKE 'S%';

select *
from employees
where first_name LIKE '%r';

select *
from employees
where first_name LIKE 'P___r';

--                                          ESCAPE

select *
from employees
where job_id LIKE 'FI\_%' ESCAPE '\';

--                                          Logical operators

--                                          AND

select *
from employees
where first_name like 'D%' AND salary > 10000;

--                                          OR

select * 
from employees
where first_name like 'D%' OR salary > 10000;

--                                          NOT
select * 
from employees
where job_id != 'SA_MAN';

-- or

select * 
from employees
where NOT (job_id = 'SA_MAN');

select * 
from employees
where last_name NOT like 'K%';

select * 
from employees
where job_id NOT in ('ST_MAN', 'ST_CLERK');

select * 
from employees
where salary NOT between 5000 and 10000;

select * 
from employees
where commission_pct is NOT null;

select * 
from employees
where commission_pct is NOT null and last_name like 'K%';

--                                          Operator priority
--  1 ----- ()
--  2 ----- * /
--  3 ----- + - 
--  4 ----- ||
--  5 ----- = > < >= <=
--  6 ----- [NOT]LIKE, IS[NOT]NULL, [NOT]IN 
--  7 ----- [NOT] BETWEEN
--  8 ----- != or <>
--  9 ----- NOT
-- 10 ----- AND
-- 11 ----- OR

select * 
from employees
where 
    first_name like '__n%' and commission_pct is null
or 
    first_name like 'A%' and job_id = 'SA_REP';

--                                          ORDER BY
-- SELECT * | {DISTINCT column(s) alias, expression(s) alias} 
-- FROM table_name 
-- WHERE condition(s) 
-- ORDER BY {column(s) | expression(s) | numeric position} {ASC | DESC} {NULLS FIRST | NULLS LAST};

select *
from employees
ORDER BY salary;

--                                          ASC  
-- ascending  (UP)

select *
from employees
order by salary ASC;

--                                          DESC 
-- descending (DOWN)

select *
from employees
order by salary DESC;

--                                          NULLS FIRST 
select *
from employees
order by commission_pct desc NULLS FIRST;

--                                          NULLS LAST 
select *
from employees
order by commission_pct desc NULLS LAST;

--                                           Numeric position
select first_name, last_name, salary
from employees
order by 3;

select *
from regions
order by 2;

select *
from regions
order by 2, 3;
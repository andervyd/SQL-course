--                                          FUNCTIONS
-- Single-row
-- Multiple-row

--                                          Single-row fuctions:
-- Character   (12 st)
-- Numeric     (135 st)
-- Date        () 
-- Conversion  ()
-- General     ()

--                                          CHARACTER functions:

--                                          Case conversion functions

--                                          LOWER(s)
select first_name, LOWER(first_name)
from employees;

select LOWER('HI, hOw a YoU?')
from dual;

select *
from employees
where LOWER(first_name)= 'david';

--                                          UPPER(s)
select first_name, UPPER(first_name)
from employees;

select UPPER('HI, hOw a YoU?')
from dual;

select *
from employees
where UPPER(first_name)= 'DAVID';

--                                          INITCAP(s)
select INITCAP('hI, HOw A yOu?')
from dual;

select INITCAP(job_id)
from employees;

--                                          SYSDATE
select SYSDATE
from dual;

--                                          Character manipulation functions

--                                          CONCAT(s)
select CONCAT('Dr. ', first_name)
from employees;

select CONCAT('Bay: ', 55)
from dual;

select CONCAT('My ', CONCAT('name: ', 007))
from dual;

--                                          LENGTH(s)
select first_name, LENGTH(first_name)
from employees;

select LENGTH('Hello World') as length_string
from dual;

select country_name, LENGTH(country_name) as length_country
from countries
order by LENGTH(country_name);

--                                          LPAD(s, n, p), RPAD(s, n, p)
select LPAD('Alex', 10, '-')
from dual;

select RPAD(first_name, 12, ' ') || LPAD(salary, 10, ' ') as name_salary
from employees;

select RPAD('Helloooo', 5)
from dual;

--                                          TRIM( {trailing | leading | both} trimstring from s)
select TRIM(TRAILING '@' FROM 'Alex@@@@@@@')
from dual;

select TRIM(LEADING '@' FROM '@@@@@@@Alex')
from dual;

select TRIM(BOTH '@' FROM '@@@@@@@Alex@@@@@@@')
from dual;

select TRIM(' ' FROM '       Alex       ')
from dual;

select TRIM('       Alex       ')
from dual;

--                                          INSTR(s, search string, start position, Nth occurrence)
select *
from employees
where INSTR(job_id, 'PROG') = 4;

select 'ID letter ''e'' = ' || INSTR('Alex', 'e') as letter_id
from dual;

select 'ID letter ''e'' = ' || INSTR('Nenne', 'e', 3) as letter_id
from dual;

select 'ID letter ''e'' = ' || INSTR('Alexe', 'e', 1, 2) as letter_id
from dual;

--                                          SUBSTR(s, start position, number of character)
select email, SUBSTR(email, 4)
from  employees;

select email, SUBSTR(email, 4, 2)
from  employees;

select email, SUBSTR(email, 8, 2)
from  employees;

select SUBSTR('Hi, how a you? Nice!', -5, 4)
from  dual;

--                                          REPLACE(s, search item, replacement item)
select REPLACE('XcXcXcXcX', 'c', '!_!')
from dual;

select REPLACE('XcXcXcXcX', 'c')
from dual;

select hire_date as old_format_date,  REPLACE(hire_date, '-', '.') as new_format_date 
from employees;

--                                          NUMERIC functions:

--                                          ROUND(n, pricision)
select ROUND(3.14)
from dual;

select ROUND(3.19, 1)
from dual;

select employee_id * 3.14, ROUND(employee_id * 3.14)  
from employees;

select ROUND(123456, -5)
from dual;

select ROUND(-12.3456, 2)
from dual;

select first_name, ROUND((sysdate - hire_date) * commission_pct) as comission
from employees
where commission_pct is not null;

--                                          TRUNC(n, precision)

select TRUNC(3.14)
from dual;

select TRUNC(3.19, 1)
from dual;

select TRUNC(123456, -5)
from dual;

select TRUNC(-12.3456, 2)
from dual;

--                                          MOD(dividend, divisor)

select 'Remainder of the division: ' || MOD(7, 3) as remainder
from dual;

select 'Remainder of the division: ' || MOD(3.1, 2) as remainder
from dual;

select *
from employees
where MOD(employee_id, 2) = 0;

select employee_id, first_name, MOD(employee_id, 3) + 1 as team 
from employees
order by team;

--                                          DATE functions
/*
select *
from nls_session_parameters
where parameter = 'NLS_DATE_FORMAT';
*/

select SYSDATE
from dual;

/*
SELECT TO_CHAR(SYSDATE, 'DD-MM-RR hh24:mi:ss')
FROM DUAL;
*/

select 'How year work: ' || first_name || ' - ' || ROUND((sysdate - hire_date) / 365.25) as time_to_work
from employees;

--                                          MONTHS_BETWEEN(start_date, end_date)

select ROUND(MONTHS_BETWEEN(end_date, start_date)) as months
from job_history;

select ROUND(MONTHS_BETWEEN('12-JUL-21', sysdate) * 31) as days
from dual;

--                                          ADD_MONTHS(date, number_of_months)
select sysdate, ADD_MONTHS(sysdate, 5)
from dual;

select sysdate, ADD_MONTHS(sysdate, -5)
from dual;

select ADD_MONTHS('30-SEP-19', 1)
from dual;

select ADD_MONTHS('31-DEC-19', 2)
from dual;

--                                          NEXT_DAY(date, day_of_the_week) 
-- day of the week - 1-7

select NEXT_DAY(sysdate, 1)
from dual;

select NEXT_DAY(sysdate, 'Mon')
from dual;

--                                          LAST_DAY(date)
select LAST_DAY(sysdate)
from dual;

select first_name, LAST_DAY(hire_date) - hire_date || ' days' as work_days
from employees;

--                                          ROUND(date, date precision format)

select first_name, hire_date, ROUND(hire_date, 'CC') 
from employees
where employee_id in (100, 120);

select ROUND(sysdate, 'MM')
from dual;

--                                          TRUNC(date, date precision format)

select first_name, hire_date, TRUNC(hire_date, 'CC') 
from employees
where employee_id in (100, 120);

select TRUNC(sysdate, 'MM')
from dual;
--                                          Conversion functions
-- TO_CHAR   (6 st)
-- TO_DATE   (200 st)
-- TO_NUMBER (232 st)

--                                          TO_CHAR(number to char)
-- TO_CHAR(number, format_mask, nls_parameters) = T

select TO_CHAR(18)
from dual;

--                                          Format mask:

-- Element     Description                        Format           Number       Text
--  9           Width                              99999            18           18        
--  0           Zero display                       099999           18           000018         
--  .           Decimal point position             099999.999       18.35        000018.350        
--  D           Decimal point position             099999D999       18.35        000018.350     
--  ,           Comma position                     099,999,999      1234567      001,234,567           
--  G           Group separator position           099G999G999       1234567      001,234,567
--  $           $ Sign                             $099999          18           $000018
--  L           Local currency                     L099999          18           $000018
--  MI          Sign position                      099999MI         -18          000018-
--  PR          Brackets for negative numbers      099999PR         18           <000018>
--  S           Prefix + or -                      S099999          18           +000018

select TO_CHAR(18, '99999') from dual;
select TO_CHAR(181818, '99999') from dual; -- NOT

select TO_CHAR(18, '099999') from dual;
select TO_CHAR(181818, '099999') from dual;

select TO_CHAR(18.35, '099999.999') from dual;

select TO_CHAR(18.35, '099999D999') from dual;

select TO_CHAR(1234567, '099,999,999') from dual;

 select TO_CHAR(1234567, '099G999G999') from dual;
 
select TO_CHAR(18, '$099999') from dual;

select TO_CHAR(18, 'L099999') from dual;

select TO_CHAR(-18, '099999MI') from dual;

select TO_CHAR(18, '099999PR') from dual;

select TO_CHAR(18, 'S099999') from dual;

-- Example:

select TO_CHAR(18.45, '$99D99') from dual;

select first_name, salary * 1.11111111 as multiplication,
       TO_CHAR(salary * 1.11111111, '$99,999.999')as "mask: $99,99.,999",
       TO_CHAR(salary * 1.11111111, '$9,999.99') as "mask: $9,999.99"
from employees;       

--                                          TO_CHAR(date to char)
-- TO_CHAR(date, format mask, nls_parameters) = T

select TO_CHAR('16-APR-85') from dual;

--                                          Format mask:
-- Example: '20-SEP-19'

-- Item       Description                                                    Text
--  Y          Last number of the year                                        9
--  YY         Last two numbers of the year                                   19
--  YYY        Last three numbers of the year                                 019
--  YYYY       Whole year                                                     2019
--  RR         Year in two-number format                                      19
--  YEAR       Letter spelling of the year (Case-sensitive)                   TWENTY NINETEEN
--  MM         Month in 2-number format                                       09
--  MON        Three letters from the name of the month (Case-sensitive)      SEP
--  MONTH      Month lettering (Case-sensitive)                               SEPTEMBER                                      
                                  
select TO_CHAR(sysdate, 'Y') from dual;
select TO_CHAR('16-APR-85', 'Y') from dual; -- NOT                                     
                                       
select TO_CHAR(sysdate, 'YY') from dual;

select TO_CHAR(sysdate, 'YYY') from dual;

select TO_CHAR(sysdate, 'YYYY') from dual;

select TO_CHAR(sysdate, 'RR') from dual;

select TO_CHAR(sysdate, 'YEAR') from dual;
select TO_CHAR(sysdate, 'Year') from dual;
select TO_CHAR(sysdate, 'year') from dual;

select TO_CHAR(sysdate, 'MM') from dual;

select TO_CHAR(sysdate, 'MON') from dual;
select TO_CHAR(sysdate, 'Mon') from dual;
select TO_CHAR(sysdate, 'mon') from dual;

select TO_CHAR(sysdate, 'MONTH') from dual;
select TO_CHAR(sysdate, 'Month') from dual;
select TO_CHAR(sysdate, 'month') from dual;
                                           
-- Example:

select hire_date, TO_CHAR(hire_date, 'Month')
from employees;

select hire_date, TO_CHAR(hire_date, 'Month', NLS_DATE_LANGUAGE = JAPAN)
from employees;

select hire_date, TO_CHAR(hire_date, 'fmMonth') || ' - month.' as "fmMONTH" 
from employees;

select first_name, hire_date 
from employees
where TO_CHAR(hire_date, 'fmMONTH') = 'AUGUST';

--                                          Format mask:
-- Example: '20-SEP-19'

-- Item       Description                                                              Text
--  D          Day of week                                                              6
--  DD         Day of month two digits                                                  20
--  DDD        Day of the year                                                          263
--  DY         Three letters from the name of the day of the week (Case-sensitive)      FRI
--  DAY        Full name of the day of the week (Case-sensitive)                        FRIDAY
--  W          Week of month                                                            3   
--  WW         Week of the year                                                         38
--  Q          Quarter of the year                                                      3
--  CC         Century                                                                  21

select TO_CHAR(sysdate, 'D') from dual;

select TO_CHAR(sysdate, 'DD') from dual;

select TO_CHAR(sysdate, 'DDD') from dual;

select TO_CHAR(sysdate, 'DY') from dual;
select TO_CHAR(sysdate, 'Dy') from dual;
select TO_CHAR(sysdate, 'dy') from dual;

select TO_CHAR(sysdate, 'DAY') from dual;
select TO_CHAR(sysdate, 'Day') from dual;
select TO_CHAR(sysdate, 'day') from dual;

select TO_CHAR(sysdate, 'W') from dual;

select TO_CHAR(sysdate, 'WW') from dual;

select TO_CHAR(sysdate, 'Q') from dual;

select TO_CHAR(sysdate, 'CC') from dual;

--                                          Format mask:
-- Example: '20-SEP-19 16:17:18'

-- Item                     Description                               Text
--  AM, PM, A.M. or P.M.     Indicator                                 PM
--  HH, HH12 and HH24        Time format                               04,04,16
--  MI                       Minutes                                   17    
--  SS                       Seconds                                   18      
--  SSSSS                    Seconds After Midnight                    58638      
--  /. ,? #!                 Punctuation 'MM.YY'                       09.19   
--  "Any Text"               '"Quarter" Q "of" Year'                     Quarter 3 of Twenty Nineteen     
--  TH                       'DDth "of" Month'                         20TH of September
--  SP                       Spelling (spell) 'MmSP Month Yyyysp'      Nine September Two Thousand Nineteen        
--  THSP or SPTH             Combination: 'hh24SpTh'                   sixteenth      

select TO_CHAR(sysdate, 'AM') from dual;

select TO_CHAR(sysdate, 'HH24') from dual;

select TO_CHAR(sysdate, 'HH:MI') from dual;

select TO_CHAR(sysdate, 'hh24:mi:SS') from dual;

select TO_CHAR(sysdate, 'SSSSS') from dual;

select TO_CHAR(sysdate, 'fmDAY!Mon?yyyy#') from dual;

select TO_CHAR(sysdate, '"quarter" q "of" year') from dual;

select TO_CHAR(sysdate, 'DDth "of" Month') from dual;

select TO_CHAR(sysdate, 'yyyySP; mmSP') from dual;

select TO_CHAR(sysdate, 'hh24SpTh') from dual;

-- Example:

select 'My colleague with ID = ' ||
       employee_id ||
       ' and job_id = ' ||
       job_id ||
       ' joined us on ' ||
       TO_CHAR(hire_date, 'Day "the" ddTH "of" fmMonth YYYY')
from employees;
       
--                                          TO_DATE(char to date)
-- TO_DATE(text, format mask, nls_parameters) = D

select TO_DATE('16-APR-85') from dual;

select TO_DATE('18:40 2019!17-Sep', 'hh24:mi yyyy!dd-Mon')
from dual;

--
select TO_DATE('28-Sep-19 15:16:17', 'dd-Mon-rr hh24:mi:ss')
from dual;

select TO_CHAR(TO_DATE('28-Sep-19 15:16:17', 'dd-Mon-rr hh24:mi:ss'), 'dd-Mon-rr hh24:mi:ss')
from dual;
--

--
select *
from employees
where hire_date < '01-JAN-05';

select *
from employees
where hire_date < TO_DATE('01-JAN-05', 'dd-Mon-yy');
--

select TO_CHAR(TO_DATE('18-Sep-19', 'dd-Mon-rr'), 'Month')
from dual;
              
select TO_CHAR(TO_DATE('15?1987$17$18$19/09', 'hh24?YYYY$MI$SS$DD/mm'), 'dd-MON-yyyy hh24:mi:ss')
from dual; 
       
--                                          TO_NUMBER(numberto char)

-- TO_NUMBER(text, format mask, nls_parameters) = N

select TO_NUMBER('42.5') from dual;

select TO_NUMBER('$4,234.5', '$99,999.999') from dual;

select TO_NUMBER('<4234.5>', '99999.999PR') from dual;
    
--    
select TO_CHAR(3.17, '99.9') from dual;
    
select TO_NUMBER('3.17', '99.99') from dual;
    
select TO_CHAR(TO_NUMBER('3.17', '99.99'), '99.9') from dual;
--    
    
--                                          NESTED functions

select first_name,
       employee_id,
       LENGTH(employee_id),
       SUBSTR(first_name, LENGTH(employee_id)),
       LENGTH(SUBSTR(first_name, LENGTH(employee_id)))
from employees;

--                                          General functions (work with NULL)     

--                                          NVL(value, ifnull)
select NVL(5, 7) from dual;

select NVL(null, 7) from dual;

select first_name,
       NVL(commission_pct, 0)
from employees;

select first_name,
       NVL(substr(first_name, 6), 'name is short')
from employees;

select first_name,
       commission_pct,
       NVL(salary * commission_pct, 500) as bonus
from employees;

--                                          NVL2(value, ifnotnull, ifnull)

select NVL2(5, 7, 9) from dual;

select NVL2(null, 7, 9) from dual;

select first_name,
       NVL2(commission_pct, commission_pct, 0)
from employees;

select first_name,
       NVL2(commission_pct, 'yes', 'no')
from employees;

--                                          NULLIF(value1, value2)

select NULLIF(18, 18) from dual;
select NULLIF(17, 18) from dual;

select NULLIF('18', '18') from dual;

select NULLIF(18, '18') from dual; -- NOT
select NULLIF(18, TO_NUMBER('18')) from dual;

select NULLIF('18-SEP-98', '18/SEP/98') from dual; 
select NULLIF(TO_DATE('18-SEP-98'), TO_DATE('18/SEP/98')) from dual; 

select country_id, country_name,
       NVL2(NULLIF(country_id, UPPER(SUBSTR(country_name, 1, 2))), 'no match', 'coincidence')       
from countries;

--                                          COALESCE(value1, value2, ..., valueN)

-- COALESCE(value1, value2, value3) = NVL(value1, NVL(value2, value3))

select COALESCE(1, 2, null, 3) from dual; 
select COALESCE(null, 2, null, 3) from dual; 
select COALESCE(null, null, null, 3) from dual; 

select first_name, commission_pct, manager_id, salary,
       COALESCE(commission_pct, manager_id, salary) as info
from employees; 

--                                          Conditional functions:
-- logic: if-then-else

--                                          DECODE(expr, comp1, iftrue1, comp2, iftrue2, ... compN, iftrueN, iffalse)

select DECODE(3 * 4, 12, 'twenty') from dual;
select DECODE(3 * 4, 14, 'twenty') from dual;

select DECODE(3 * 4, 10, 'ten', 11, 'elevan', 5, 'five') from dual;
select DECODE(3 * 4, 10, 'ten', 11, 'elevan', 5, 'five', 'not match') from dual;
select DECODE(3 * 4, 10, 'ten', 11, 'elevan', 12, 'twenty',  5, 'five') from dual;

select DECODE(null, 5, 'ok', null, 55) from dual;

select first_name, commission_pct,
       DECODE(commission_pct, null, 'not commissions', 0.1, 'few', 0.4, 'many', 'middle')
from employees
where employee_id between 140 and 180;

--                                          Conditional function CASE
-- Simple CASE    (344 st)
-- Searched CASE  (394 st)

--                                          Simple CASE
-- CASE expr
--  WHEN comp1 THEN iftrue1
--  WHEN comp2 THEN iftrue2
--  ...
--  WHEN compN THEN iftrueN
--  ELSE iffalse
-- END
--

select
    CASE 3 * 4
        WHEN 12 THEN 'true -    twelve'
    END
from dual;
 
select
    CASE 3 * 4
        WHEN 10     THEN 'ten'
        WHEN 24 / 2 THEN 'twelve 1'
        WHEN 12     THEN 'twelve 2'
    END
from dual;

select
    CASE 3 * 4
        WHEN 10     THEN '10'
        WHEN 24 / 2 THEN 12          -- NOT 
        WHEN 12     THEN 'twelve 2'
    END
from dual;

select
    CASE 3 * 5
        WHEN 10     THEN '10'
        WHEN 24 / 2 THEN 'twelve 1'
        WHEN 12     THEN 'twelve 2'
        ELSE 'not found'
    END
from dual;

select first_name,
    CASE length(first_name)
        WHEN 4 THEN 'length name - 4'
        WHEN 5 THEN 'length name - 5'
        WHEN 6 THEN 'length name - 6'
        ELSE 'length name more six'
    END
from employees;

--                                          Searched CASE

--                                          Simple CASE
-- CASE 
--  WHEN comp1 THEN iftrue1
--  WHEN comp2 THEN iftrue2
--  ...
--  WHEN compN THEN iftrueN
--  ELSE iffalse
-- END
--

select
    CASE 
        WHEN 3 * 4 = 12 THEN 'true -    twelve'
    END
from dual;

select
    CASE 
        WHEN 3 + 4 = 10  THEN '10'
        WHEN 'ok' = 'ok' THEN 'true' 
        WHEN 3 + 3 = 6   THEN 'twelve 2'
    END as case
from dual;

select first_name, salary, commission_pct,
    CASE 
        WHEN length(first_name)<= 5     THEN '#1'
        WHEN salary * 10 > 10000        THEN '#2'
        WHEN commission_pct is not null THEN '#3'
        ELSE 'not conditions'
    END as case_statement
from employees;
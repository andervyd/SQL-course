--                                          SET OPERATORS:

--                                          COMPOUND QUERY
-- SELECT * 
-- FROM table_name_1
-- SET OPERATIONS
-- SELECT * 
-- FROM table_name_2

-- UNION ALL       (16 st)
-- UNION           (81 st)
-- INTERSECT       (125 st)

-- MINUS (ORACLE)  (164 st)
-- EXCEPT (SQL)    
  
-- PRACTICE        (217 st)  
--                                          UNION ALL

--   NAME_TABLE_1    NAME_TABLE_2     
--     Steven          Neena          
--     Lex             Austin        
--     Neena           Bruce          
--     Chen            Lex             
--     James                           

-- Output: 
--         Steven                 
--         Lex                    
--         Neena                 
--         Chen               
--         James             
--         Neena  
--         Austin
--         Bruce    
--         Lex        
  
-- Example:
 
----
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';

SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%'
UNION ALL
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';

SELECT job_id, job_title, min_salary 
FROM jobs 
WHERE job_id LIKE '%MAN%'
UNION ALL
SELECT job_id, job_title, min_salary 
FROM jobs 
WHERE job_id LIKE '%MAN%'
ORDER BY min_salary DESC;

----
SELECT * 
FROM jobs 
UNION ALL
SELECT * 
FROM jobs;

SELECT * 
FROM jobs 
UNION ALL
SELECT * 
FROM jobs
ORDER BY min_salary DESC;  -- NOT WORK

SELECT * 
FROM jobs 
UNION ALL
SELECT * 
FROM jobs
ORDER BY 3 DESC;

--                                          UNION

--   NAME_TABLE_1    NAME_TABLE_2     SORTS:
--     Steven          Neena           Chen       Austin
--     Lex             Austin          James      Bruce
--     Neena           Bruce           Lex        Lex - 
--     Chen            Lex             Neena      Neena - 
--     James                           Steven

-- Output:                  
--         Austin
--         Bruce
--         Chen 
--         James
--         Lex           
--         Neena  
--         Steven
  
-- Example:
 
----
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';

SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%'
UNION
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';
 
----
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 4500 AND 8000
UNION
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 10000 AND 15000;

--                                          INTERSECT

--   NAME_TABLE_1    NAME_TABLE_2     SORTS:
--     Steven          Neena           Chen       Austin
--     Lex             Austin          James      Bruce
--     Neena           Bruce           Lex        Lex - 
--     Chen            Lex             Neena      Neena - 
--     James                           Steven

-- Output:                  
--         Lex                    
--         Neena
  
-- Example:
 
----
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';

SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%'
INTERSECT
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';
 
----
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 4500 AND 6000
INTERSECT
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 6000 AND 8000;

--                                          MINUS (ORACLE)

--   NAME_TABLE_1    NAME_TABLE_2     SORTS:
--     Steven          Neena           Chen       Austin
--     Lex             Austin          James      Bruce
--     Neena           Bruce           Lex -      Lex  
--     Chen            Lex             Neena -    Neena  
--     James                           Steven

-- Output: 
    
--         Chen               
--         James             
--         Steven            
  
-- Example:
 
----
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';

SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%'
MINUS
SELECT * 
FROM jobs 
WHERE job_id LIKE '%MAN%';
 
----
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 4500 AND 6000
MINUS
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 6000 AND 8000;

SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 6000 AND 8000
MINUS
SELECT * 
FROM jobs 
WHERE min_salary 
      BETWEEN 4500 AND 6000;

--                                          PRACTICE

SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%a%'
INTERSECT
SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%e%'
MINUS
SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%l%';

----

SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%a%'
UNION
SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%e%'
MINUS
SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%l%';


SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%a%'
UNION
( SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%e%'
MINUS
SELECT first_name,
       salary
FROM employees
WHERE first_name LIKE '%l%' );

----
SELECT manager_id
FROM employees
WHERE department_id = 20
INTERSECT
SELECT manager_id
FROM employees
WHERE department_id = 30
MINUS
SELECT manager_id
FROM employees
WHERE department_id = 40;

----
SELECT department_id,
       SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY 1;


SELECT job_id,
       SUM(salary)
FROM employees
GROUP BY job_id
ORDER BY 1;


SELECT department_id,
       TO_CHAR(null) AS job_id,
       SUM(salary)
FROM employees
GROUP BY department_id 
UNION
SELECT TO_NUMBER(null),
       job_id,
       SUM(salary)
FROM employees
GROUP BY job_id;
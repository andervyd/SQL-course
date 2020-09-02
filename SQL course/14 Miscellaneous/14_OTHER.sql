--                                          Contents:

-- 153. SINGLE AMPERSAND SUBSTITUTION (&)            (11 st)
-- 154. DOUBLE AMPERSAND SUBSTITUTION (&&)           (90 st)
-- 155. DEFINE AND UNDEFINE                          (118 st)
--      a. UNDEFINE                          (120 st)
--      b. DEFINE                            (142 st)
--      c. SET DEFINE ON / OFF               (160 st)
-- 156. VERIFY                                      (166 st)

--                                          153. SINGLE AMPERSAND SUBSTITUTION (&)

SELECT &next;

---->

SELECT &select_list
FROM &table
WHERE &conditions
ORDER BY &column;

----

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE employee_id = 130;

----> or

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE employee_id = &id;    -- &id = employee_id (example: 130)

---- 

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE first_name = &name;   -- &name = firs_name (example: 'Neena')

---- or

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE first_name = '&name';   -- &name = firs_name (example: Neena)

----

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE employee_id < &id AND
      salary > &salary
ORDER BY salary DESC;

----

SELECT first_name,
       last_name,
       &column
FROM employees;

----

SELECT first_name,
       last_name,
       &column
FROM employees
ORDER BY &order;

----

SELECT *
FROM students;

UPDATE students
SET &what
WHERE &con;

COMMIT;

--                                          154. DOUBLE AMPERSAND SUBSTITUTION (&&)

-- SEARCH firs name and last name where is letter 's':

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE first_name LIKE '%&letter%' AND
      last_name LIKE '%&letter%';     -- WORK BUT NOT CORRECT

---->

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE first_name LIKE '%&&letter%' AND
      last_name LIKE '%&letter%';     -- WORK AND CORRECT BUT ORACLE REMEMBERED THE VALUE

----

SELECT first_name,
       last_name,
       &&column
FROM employees
ORDER BY &column;

--                                          155. DEFINE AND UNDEFINE

--                                          UNDEFINE

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE first_name LIKE '%&&letter%' AND
      last_name LIKE '%&letter%';     -- WORK AND CORRECT BUT ORACLE REMEMBERED THE VALUE (letter)

---->

UNDEFINE letter;

---->

SELECT first_name,
       last_name,
       salary
FROM employees
WHERE first_name LIKE '%&&letter%' AND
      last_name LIKE '%&letter%';     -- WHEN USED 'UNDEFINE' ORACLE RESETS THE VALUE (letter)

--                                          DEFINE

-- DEFINE;     (shows all variables this session)

DEFINE;

----> or

-- DEFINE variable_name;     (shows this variable value)

DEFINE letter;  -- ('s')

----> or

-- DEFINE variable_name = value;     (set a value to a variable)

DEFINE letter = 'a'; -- (change: 's' => 'a')

--                                          SET DEFINE ON / OFF

SET DEFINE OFF;  -- OFF AMPERSANT

SET DEFINE ON;   -- ON AMPERSANT

--                                          156. VERIFY

/* Command line:
CMD> sqlplus hr/hr@orclpdb2;

SQL> SELECT first_name, salary FROM employees WHERE salary > &value;
Enter value for value: 10000

old   1: SELECT first_name, salary FROM employees WHERE salary > &value  -- SHOWS OLD VALUE
new   1: SELECT first_name, salary FROM employees WHERE salary > 10000   -- SHOWS NEW VALUE

FIRST_NAME               SALARY
-------------------- ----------
Steven                    24000
Neena                     17000
Lex                       17000
Alexander                 13000
Nancy                     12000
Den                       11000
John                      14000
Karen                     13500
Alberto                   12000
Gerald                    11000
Eleni                     10500

FIRST_NAME               SALARY
-------------------- ----------
Clara                     10500
Lisa                      11500
Ellen                     11000
Michael                   13000
Pat                       19000
Shelley                   12000

SQL> SET VERIFY OFF;                                                       -- TURN OFF

SQL> SELECT first_name, salary FROM employees WHERE salary > &value;       -- SHOWS ONLY OLD VALUE
Enter value for value: 10000

FIRST_NAME               SALARY
-------------------- ----------
Steven                    24000
Neena                     17000
Lex                       17000
Alexander                 13000
Nancy                     12000
Den                       11000
John                      14000
Karen                     13500
Alberto                   12000
Gerald                    11000
Eleni                     10500

FIRST_NAME               SALARY
-------------------- ----------
Clara                     10500
Lisa                      11500
Ellen                     11000
Michael                   13000
Pat                       19000
Shelley                   12000

*/
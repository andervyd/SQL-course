--                                          Contents:

-- 132. Introduction to CONSTRAINT        
-- 133. UNIQUE CONSTRAINT                 ( st)
-- 134. NOT NULL CONSTRAINT               ( st)
-- 135. PRIMARY KEY CONSTRAINT            ( st)
-- 136. FOREIGN KEY CONSTRAINT            ( st)
-- 137. ON DELETE options for FOREIGN KEY ( st)
-- 138. CHECK CONSTRAINT                  ( st)
-- 139. Introduction to INDEX             ( st)
-- 140. INDEX B-TREE part 1               ( st)
-- 141. INDEX B-TREE part 2               ( st)
-- 142. INDEX BITMAP                      ( st)

--                                          UNIQUE CONSTRAINT
-- SINGLE ( st)
-- MULTY  ( st)

--                                          SINGLE UNIQUE CONSTRAINT

CREATE TABLE students
    (id NUMBER CONSTRAINT st_id_unique UNIQUE,
     name VARCHAR2 (15),
     course NUMBER,
     faculty_id INTEGER,
     avg_score NUMBER (5, 2),
     start_date DATE,
     scholarship INTEGER);

-- or

CREATE TABLE students
    (id NUMBER,
     name VARCHAR2 (15),
     course NUMBER,
     faculty_id INTEGER,
     avg_score NUMBER (5, 2),
     start_date DATE,
     scholarship INTEGER,
     CONSTRAINT st_id_unique UNIQUE (id));

SELECT * 
FROM students;

INSERT INTO students
    (id, name, course, faculty_id, avg_score, start_date, scholarship)
VALUES (1, 'Zaur', 3, 1, 8.7, TO_DATE('01-SEP-17'), 1600);

INSERT INTO students
    (id, name, course, faculty_id, avg_score, start_date, scholarship)
VALUES (NULL, 'Ivan', 2, 2, 7.3, TO_DATE('07-SEP-18'), 980);

INSERT INTO students
    (id, name, course, faculty_id, avg_score, start_date, scholarship)
VALUES (2, 'Alex', 3, 1, 8.5, TO_DATE('02-SEP-17'), 1800);

COMMIT;

--                                          MULTY UNIQUE CONSTRAINT

DROP TABLE students;

CREATE TABLE students
    (id NUMBER,
     name VARCHAR2 (15),
     course NUMBER,
     faculty_id INTEGER,
     avg_score NUMBER (5, 2),
     start_date DATE,
     scholarship INTEGER,
     CONSTRAINT st_id_unique UNIQUE (id, name));














CREATE TABLE faculties
    (id NUMBER,
     name VARCHAR2 (15));














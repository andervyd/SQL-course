-- task 01;
CREATE TABLE friends
AS (SELECT employee_id AS id,
           first_name AS name,
           last_name AS surname
    FROM employees
    WHERE commission_pct IS NOT NULL);

SELECT *
FROM friends;

-- task 02;
ALTER TABLE friends
ADD (email VARCHAR2 (30) DEFAULT NULL);

SELECT *
FROM friends;

-- task 03;
ALTER TABLE friends
MODIFY (email VARCHAR (30) DEFAULT 'no email');

ALTER TABLE friends
DROP COLUMN email; 

SELECT *
FROM friends;

-- task 04;
DELETE 
FROM friends
WHERE id = 180;

INSERT INTO friends
    (id, name, surname)
VALUES (180, 'John', 'Lee');

SELECT *
FROM friends;

-- task 05;
ALTER TABLE friends
RENAME COLUMN id
           TO friends_id;

SELECT *
FROM friends;

-- task 06;
DROP TABLE friends;

-- task 07;
CREATE TABLE friends
    (id NUMBER (6, 0),
     name VARCHAR2 (20),
     surname VARCHAR2 (30),
     email VARCHAR2 (100),
     salary NUMBER (8, 2) DEFAULT TO_NUMBER('1000.00', '999999.99'),
     city VARCHAR2 (30),
     birthday DATE DEFAULT TO_DATE(SYSDATE, 'DD-MON-RR'));

SELECT *
FROM friends;

-- task 08;
INSERT INTO friends
    (id, name, surname, email, salary, city, birthday)
VALUES (1, 'John', 'Lee', 'lee@mail.com', 2500, 'New York', '12-SEP-87');

SELECT *
FROM friends;

-- task 09;
INSERT INTO friends
    (id, name, surname, email, city)
VALUES (2, 'John', 'Doe', 'doe@mail.com', 'New York');

SELECT *
FROM friends;

-- task 10;
COMMIT;

-- task 11;
AlTER TABLE friends
DROP COLUMN salary;

SELECT *
FROM friends;

-- task 12;
ALTER TABLE friends
SET UNUSED COLUMN email;

SELECT *
FROM friends;

-- task 13;
ALTER TABLE friends
SET UNUSED COLUMN birthday;

SELECT *
FROM friends;

-- task 14;
ALTER TABLE friends
DROP UNUSED COLUMNS;

-- task 15;
ALTER TABLE friends
READ ONLY; 

-- task 16;
UPDATE friends
SET name = 'Alex'
WHERE id = 1;

-- task 17;
ALTER TABLE friends
READ WRITE;

TRUNCATE TABLE friends;

SELECT *
FROM friends;

-- task 18;
DROP TABLE friends;

SELECT *
FROM friends;
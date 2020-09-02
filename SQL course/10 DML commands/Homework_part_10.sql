-- task 01: 
CREATE TABLE locations2 
AS (SELECT * 
    FROM locations 
    WHERE 1 = 2); 
    
DELETE
FROM locations2;

SELECT *
FROM locations2;

COMMIT;

-- task 02: 
INSERT INTO locations2
    (location_id, street_address, city, country_id)
VALUES (TO_NUMBER(3300), INITCAP('1314 Sezam'), INITCAP('Milan'), UPPER('IT'));

INSERT INTO locations2
    (location_id, street_address, city, country_id)
VALUES (TO_NUMBER(3400), INITCAP('1516 Turynit'), INITCAP('Turin'), UPPER('IT'));

-- task 03: 
SELECT *
FROM locations2;

COMMIT;

-- task 04: 
INSERT INTO locations2
VALUES (TO_NUMBER('3500'), INITCAP('144 De Golle'), 
        TO_NUMBER('341678'), INITCAP('Paris'), 
        INITCAP('Provinse Le Burge'), UPPER('FR'));

INSERT INTO locations2
VALUES (TO_NUMBER(3600), INITCAP('1516 Julies Verne'), 
        TO_NUMBER('2300987'), INITCAP('Lion'), 
        INITCAP('Provinse Burgun De Pory'), UPPER('FR'));

-- task 05: 
SELECT *
FROM locations2;

COMMIT;

-- task 06: 
INSERT INTO locations2
    (SELECT *
     FROM locations
     WHERE LENGTH(state_province) > 9);

-- task 07: 
SELECT *
FROM locations2;

COMMIT;

-- task 08: 
CREATE TABLE locations4europe 
AS (SELECT * 
    FROM locations 
    WHERE 1 = 2); 

-- task 09: 
INSERT ALL
WHEN 1 = 1 THEN
INTO locations2
VALUES (location_id, street_address, postal_code, 
        city, state_province, country_id)
WHEN country_id IN (
    SELECT country_id 
    FROM countries
    WHERE region_id = 1) THEN
INTO locations4europe (location_id, street_address, city, country_id)
VALUES (location_id, street_address, city, country_id)
SELECT * FROM locations;

-- task 10: 
SELECT *
FROM locations2;

SELECT *
FROM locations4europe;

COMMIT;

-- task 11: 
UPDATE locations2
SET postal_code = 'not used'
WHERE postal_code IS NULL;

-- task 12: 
SELECT *
FROM locations2
WHERE postal_code = 'not used';

ROLLBACK;

SELECT *
FROM locations2
WHERE postal_code IS NULL;

-- task 13: 
UPDATE locations2
SET postal_code = (
    SELECT postal_code
    FROM locations
    WHERE location_id = 2600)
WHERE postal_code IS NULL;

-- task 14: 
SELECT *
FROM locations2
WHERE postal_code IN (
SELECT postal_code
FROM locations
WHERE location_id = 2600);

COMMIT;

-- task 15: 
DELETE
FROM locations2
WHERE UPPER(country_id) = 'IT';

SELECT *
FROM locations2
WHERE UPPER(country_id) = 'IT';

-- task 16: 
SAVEPOINT delete_IT_country;

-- task 17: 
UPDATE locations2
SET street_address = 'Sezame st.18'
WHERE location_id > 2500;

SELECT *
FROM locations2
WHERE location_id > 2500;

-- task 18: 
SAVEPOINT update_street_address;

-- task 19: 
DELETE
FROM locations2
WHERE street_address = 'Sezame st.18';

-- task 20: 
ROLLBACK TO SAVEPOINT delete_IT_country; 

-- task 21: 
COMMIT;
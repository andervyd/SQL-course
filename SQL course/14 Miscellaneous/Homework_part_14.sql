-- task 01:
CREATE TABLE test200 
    (id INTEGER,
     name_one VARCHAR2(25),
     name_two VARCHAR2(25),
     address_one VARCHAR2(25),
     address_two VARCHAR2(25));

-- task 02:
UPDATE test200
SET &column = &value
WHERE id = &id_value;

-- task 03:
SELECT *
FROM test200
WHERE name_one = '&&val_1'    AND
      name_two = '&val_1'     AND
      address_one = '&&val_2' AND
      address_two = '&val_2';

-- task 04:
UNDEFINE val_1; 

-- task 05:
UNDEFINE val_2; 
-- Filter by WHERE clause
-- Read like this order: FROM -> WHERE -> SELECT
SELECT name, area FROM cities WHERE area > 4000;

/*
    Other than > operator we have other operators also.
    = -> Equals to
    > Greater than
    < Less than
    >= Greater or equals to
    <= Less or equals to
    IN value present in a list
    <> not equals to
    != not equals to
    BETWEEN value between two other values
    NOT IN value not present in a list
*/

SELECT name, area FROM cities WHERE area <> 4015;
SELECT name, area FROM cities WHERE area BETWEEN 2000 AND 4000;
SELECT name, area FROM cities WHERE name IN ('Delhi', 'Shanghai');
SELECT name, area FROM cities WHERE name NOT IN ('Delhi', 'Shanghai');

-- Compound Check
SELECT name, area
FROM cities
WHERE area NOT IN (3043, 38393) AND name = 'Delhi';

SELECT name, area
FROM cities
WHERE area NOT IN (3043, 38393) OR name = 'Delhi';

-- Calculations in WHERE clause
SELECT
    name
FROM 
    cities
WHERE
    population / area > 6000;


-- Updating Records
UPDATE
    cities
SET
    population = 39505000
WHERE
    name = 'Tokyo';

-- Delete Records
DELETE FROM cities
WHERE name = 'Tokyo';

-- Write query here to update the 'units_sold' of the phone with name 'N8' to 8543
UPDATE
    phones
SET
    units_sold = 8543
WHERE
    name = 'N8';

-- Write query here to select all rows and columns of the 'phones' table
SELECT * FROM phones;

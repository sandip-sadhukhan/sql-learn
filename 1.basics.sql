-- Create Table
CREATE TABLE cities (
	name VARCHAR(50),
	country VARCHAR(50),
	population INTEGER,
	area INTEGER
);

-- Insert Data
INSERT INTO cities (name, country, population, area)
VALUES ('Tokyo', 'Japan', 38505000, 8223);

-- Bulk Insert
INSERT INTO cities (name, country, population, area)
VALUES
	('Delhi', 'India', 2812500, 2240),
	('Shanghai', 'China', 22125000, 4015),
	('Sao Paulo', 'Brazil', 20935000, 3043);

-- Show all data from Table
SELECT * FROM cities;

-- Show some selected column
SELECT name, country FROM cities;

-- Calculated Columns
SELECT name, population / area FROM cities;
-- With column name
SELECT name, population / area AS density FROM cities;

-- String Operators and Functions
-- Join Two string
-- Pipe operator ||
SELECT name || country FROM cities;

SELECT name || ', ' || country AS location FROM cities;

-- Using Concat
SELECT CONCAT(name, country) AS location FROM cities;

SELECT CONCAT(name, ', ', country) AS location FROM cities;

-- Using Lower & Upper
SELECT
	CONCAT(UPPER(name), ', ', UPPER(country)) AS location
FROM cities;

SELECT
	UPPER(CONCAT(name, ', ', country)) AS location
FROM cities;

SELECT
	LOWER(CONCAT(name, ', ', country)) AS location
FROM cities;

-- Length of string
SELECT name, LENGTH(name) AS length_of_name FROM cities;
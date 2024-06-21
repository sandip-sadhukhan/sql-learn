-- Create Table
CREATE TABLE cities (
	name VARCHAR(50),
	country VARCHAR(50),
	population INTEGER,
	area INTEGER
);

-- Insert Data
INSERT INTO cities (name, country, population, area)
VALUES ('Tokyo', 'Japan', 3000330, 38393);

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
SELECT name, population / area as density FROM cities;





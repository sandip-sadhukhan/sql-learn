-- Query: What unique departments are there?
SELECT DISTINCT department
FROM products;

-- Query: How many unique departments are there?
SELECT COUNT(DISTINCT department)
FROM products;


-- Find all columns with unique name and department together
SELECT DISTINCT department, name
FROM products;

-- Can't use COUNT on more than one column if DISTINCT is used
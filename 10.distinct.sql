-- Query: What unique departments are there?
SELECT DISTINCT department
FROM products;

-- Query: How many unique departments are there?
SELECT COUNT(DISTINCT department)
FROM products;


-- Find all rows with unique name and department together
SELECT DISTINCT department, name
FROM products;

-- To count the number of unique (department, name) combinations
-- You cannot use COUNT(DISTINCT department, name) directly in Oracle
-- Instead, use one of the following approaches:

-- Option 1: COUNT over concatenated columns (simple but beware of delimiter collisions)
SELECT COUNT(DISTINCT department || ':' || name) AS unique_dept_name_count
FROM products;

-- Option 2: Recommended - Use COUNT with a nested DISTINCT subquery
SELECT COUNT(*) AS unique_dept_name_count
FROM (
    SELECT DISTINCT department, name
    FROM products
);

-- Option 3: Using DENSE_RANK (analytic function) - another valid approach
SELECT COUNT(*) AS unique_dept_name_count
FROM (
    SELECT department, name,
           DENSE_RANK() OVER (ORDER BY department, name) AS rk
    FROM products
)
WHERE rk IS NOT NULL;  -- Not needed here, but shows structure
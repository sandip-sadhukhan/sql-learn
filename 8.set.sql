-- Question: Find the 4 products with the highest price and the 4
-- products with the highest price/weight ratio.

-- Using UNION (removes duplicates if any product appears in both sets)
(
    SELECT *
    FROM products
    ORDER BY price DESC
    FETCH FIRST 4 ROWS ONLY
)
UNION
(
    SELECT *
    FROM products
    ORDER BY (price / weight) DESC
    FETCH FIRST 4 ROWS ONLY
);

-- UNION ALL: Appends both results without removing duplicates
(
    SELECT *
    FROM products
    ORDER BY price DESC
    FETCH FIRST 4 ROWS ONLY
)
UNION ALL
(
    SELECT *
    FROM products
    ORDER BY (price / weight) DESC
    FETCH FIRST 4 ROWS ONLY
);

-- Parentheses are required around subqueries that contain ORDER BY with FETCH/LIMIT


-- IMPORTANT: Below query will still throw an error!
-- UNION requires both queries to have the same number of columns, same names (recommended), and compatible data types.
SELECT * FROM products
UNION
SELECT * FROM orders;  -- Error: different column counts and types


/*
Some other types of SET operations in Oracle:

UNION          - Combine results of two queries, remove duplicate rows
UNION ALL      - Combine results of two queries, keep all rows (including duplicates)

INTERSECT      - Rows common to both queries (duplicates removed)
-- Note: Oracle does NOT support INTERSECT ALL

MINUS          - Rows in first query but NOT in second query (duplicates removed)
-- Note: Oracle does NOT support EXCEPT or EXCEPT ALL (use MINUS instead)
*/

-- Common products in both top-4 sets (intersection)
(
    SELECT *
    FROM products
    ORDER BY price DESC
    FETCH FIRST 4 ROWS ONLY
)
INTERSECT
(
    SELECT *
    FROM products
    ORDER BY (price / weight) DESC
    FETCH FIRST 4 ROWS ONLY
);

-- Products in the top-4 highest price that are NOT in the top-4 highest price/weight ratio
-- (Set difference: A - B)
(
    SELECT *
    FROM products
    ORDER BY price DESC
    FETCH FIRST 4 ROWS ONLY
)
MINUS
(
    SELECT *
    FROM products
    ORDER BY (price / weight) DESC
    FETCH FIRST 4 ROWS ONLY
);
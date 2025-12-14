-- By default sorting is ascending i.e. small first then big ones.
SELECT *
FROM products
ORDER BY price;

-- For descending order, i.e. big first then smaller ones.
SELECT *
FROM products
ORDER BY price DESC;


-- Explicitly ascending (same as default)
SELECT *
FROM products
ORDER BY price ASC;


-- Order by multiple fields
-- First sort by price, then if two rows have the same price, use weight as a
-- tie breaker.
SELECT *
FROM products
ORDER BY price ASC, weight DESC;


/*
Offset & Limit (Pagination in Oracle):

In Oracle, there are two common ways to achieve OFFSET and LIMIT:

1. Modern way (Oracle 12c and later) - using FETCH and OFFSET (recommended)
2. Older way - using ROWNUM (works in all versions)
*/

-- Modern syntax (Oracle 12c+)
SELECT *
FROM users
ORDER BY id
OFFSET 40 ROWS
FETCH NEXT 5 ROWS ONLY;

-- Equivalent older syntax using ROWNUM (for pre-12c compatibility)
SELECT *
FROM (
    SELECT u.*, ROWNUM AS rn
    FROM (
        SELECT *
        FROM users
        ORDER BY id
    ) u
    WHERE ROWNUM <= 45  -- OFFSET 40 + LIMIT 5
)
WHERE rn > 40;


-- LIMIT 5 only (top 5 rows)
-- Modern
SELECT *
FROM users
ORDER BY id
FETCH FIRST 5 ROWS ONLY;

-- Older
SELECT *
FROM (
    SELECT *
    FROM users
    ORDER BY id
)
WHERE ROWNUM <= 5;


-- OFFSET 40 + LIMIT 5 (skip first 40, take next 5)
-- Modern (preferred)
SELECT *
FROM users
ORDER BY id
OFFSET 40 ROWS
FETCH NEXT 5 ROWS ONLY;


-- 5 Least expensive products
SELECT *
FROM products
ORDER BY price
FETCH FIRST 5 ROWS ONLY;

-- Or for older Oracle versions:
SELECT *
FROM (
    SELECT *
    FROM products
    ORDER BY price
)
WHERE ROWNUM <= 5;
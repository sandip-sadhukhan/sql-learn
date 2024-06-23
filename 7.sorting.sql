-- By default sorting is ascending ie. small first then big once.
SELECT *
FROM products
ORDER BY price;

-- For descending order, ie. big first then smaller once.
SELECT *
FROM products
ORDER BY price DESC;


-- By default is ASC
SELECT *
FROM products
ORDER BY price ASC;


-- Order by multiple fields
-- First sort by price, then if two rows has same price, then use weight as a
-- tie breaker for them to sort.
SELECT *
FROM products
ORDER BY price ASC, weight DESC;


/*
Offset & Limit:

'OFFSET 3' means skip the first three rows of the result set.
'LIMIT 2' means only give the first rows of the result set.

'OFFSET 3 LIMIT 2' means Give 4th and 5th row of the table.

NOTE: Useful for pagination feature.
*/

SELECT *
FROM users
OFFSET 40;

SELECT *
FROM users
LIMIT 5;

SELECT *
FROM users
LIMIT 5
OFFSET 40;

-- 5 Least expensive products
SELECT *
FROM products
ORDER BY price
LIMIT 5;

-- Question: Find the 4 products with the highest price and the 4
-- products with the highest price/weight ratio.
(
    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 4
)
UNION
(
    SELECT *
    FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);

-- UNION: Append both results, remove duplicates
-- UNION ALL: Append both results and not remove duplicates.

(
    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 4
)
UNION ALL
(
    SELECT *
    FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);

-- Parenthesis is not needed normally but needed when we use LIMIT, ORDER BY
-- etc. otherwise DB will throw error.


-- IMPORTANT: Below query will throw error!!!!!
-- Union only works when we have same name of columns and same data type.
SELECT * FROM products
UNION
SELECT * FROM orders;


/*
Some other types of SET operations.

UNION - Join together the results of two queries and remove duplicate rows.
UNION ALL - Join together the results of two queries.

INTERSECT - Find the rows common in the results of two queries. Remove duplicates.
INTERSECT ALL - Find the rows common in the results of two queries.

EXCEPT - Find the rows that are present in first query but not second query. Remove duplicates.
EXCEPT ALL - Find the rows that are present in first query but not second query.
*/

(
    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 4
)
INTERSECT
(
    SELECT *
    FROM products
    ORDER BY price / weight DESC
    LIMIT 4
)

-- NOTE: Intersect all is useful when first and second query return duplicate
-- rows, so intersect will remove duplicates, but if we want then we can use
-- INTERSECT ALL.


-- Return first table except the records of second table
-- Basically SET DIFFERENCE = A - B. A is first table, B is second table.
(
    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 4
)
EXCEPT
(
    SELECT *
    FROM products
    ORDER BY price / weight DESC
    LIMIT 4
)


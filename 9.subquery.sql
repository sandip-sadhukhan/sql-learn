-- Query: List the name and price of all products that are more expensive
-- than all products in the 'Toys' department.

SELECT name, price
FROM products
WHERE price > (
    SELECT MAX(price)
    FROM products
    WHERE department = 'Toys'
);

-- Where can I use subquery?
SELECT
    p1.name,
    (SELECT COUNT(*) FROM products) -- Scalar subquery: returns a single value
FROM (SELECT * FROM products) p1 -- Derived table: source of rows
JOIN (SELECT * FROM products) p2 ON p1.id = p2.id -- Derived table in JOIN
WHERE p1.id IN (SELECT id FROM products); -- List subquery: single column, multiple rows


/*
    Understanding the shape of a query results is key!

    SELECT * FROM orders -> Many rows, many columns
    SELECT id FROM orders -> Many rows, one column
    SELECT COUNT(*) FROM orders -> One row, one column (Scalar query)
*/

-- Subquery inside SELECT (scalar subquery)
SELECT name, price, (
    SELECT MAX(price) FROM products  -- Returns NULL if no rows (though unlikely here)
) AS overall_max_price
FROM products
WHERE price > 867;


-- Subquery inside FROM (derived table - must have an alias)
SELECT name, price_weight_ratio
FROM (
    SELECT name, price / weight AS price_weight_ratio 
    FROM products
) p
WHERE price_weight_ratio > 5;

-- Another example
SELECT *
FROM (SELECT MAX(price) FROM products) p;


-- Practical use of subquery in FROM
-- Query: Find the average number of orders per user
SELECT AVG(order_count)
FROM (
    SELECT user_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY user_id
) p;


-- Subquery in JOIN clause
SELECT first_name
FROM users
JOIN (
    SELECT user_id
    FROM orders
    WHERE product_id = 3
) o
ON o.user_id = users.id;


-- Subquery in WHERE clause
-- Query: Show the id of orders that involve a product with a price/weight
-- ratio greater than 50.
SELECT id
FROM orders
WHERE product_id IN (
    SELECT id
    FROM products
    WHERE price / weight > 50
);


-- Query: Show the name of all products with a price greater than the average
-- product price.
SELECT name
FROM products
WHERE price > (SELECT AVG(price) FROM products);


-- Query: Show the name of all products that are not in the same department
-- as products with a price less than 100.
-- Note: If any department has only products < 100 and some NULL prices exist, careful with NOT IN
SELECT name
FROM products
WHERE department NOT IN (
    SELECT department
    FROM products
    WHERE price < 100
    AND department IS NOT NULL  -- Safe handling if NULL departments possible
);


-- Query: Show the name, department, and price of products that are more
-- expensive than all products in the 'Industrial' department
SELECT name, department, price
FROM products
WHERE price > (
    SELECT MAX(price)
    FROM products
    WHERE department = 'Industrial'
);

-- Alternate solution using > ALL
SELECT name, department, price
FROM products
WHERE price > ALL (
    SELECT price
    FROM products
    WHERE department = 'Industrial'
);

/*
> ALL  -> Greater than every value returned by subquery
< ALL, >= ALL, <= ALL, = ALL, <> ALL work similarly.

> SOME -> Greater than at least one value (SOME is synonym for ANY)
> ANY is equivalent to > SOME
*/

-- Correlated Sub-Query
-- Query: Show the name, department, and price of the most expensive product in
-- each department.
SELECT name, department, price
FROM products p1
WHERE price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.department = p1.department
);


-- Query: Without using JOIN or GROUP BY in the main query, print the number of orders for each product
SELECT name,
    (
        SELECT COUNT(*)
        FROM orders o1
        WHERE o1.product_id = p1.id
    ) AS num_orders
FROM products p1;


-- SELECT without FROM clause (scalar subqueries)
-- Single value
SELECT (
    SELECT MAX(price) FROM products
) AS max_price;

-- Multiple aggregates at once
SELECT
    (SELECT MAX(price) FROM products) AS max_price,
    (SELECT MIN(price) FROM products) AS min_price,
    (SELECT AVG(price) FROM products) AS avg_price;

-- Query: List the name and price of all products that are most expensive
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
    (SELECT COUNT(name) FROM products) -- A source of a value
FROM (SELECT * FROM products) as p1 -- A source of rows
JOIN (SELECT * FROM products) as p2 ON p1.id = p2.id -- A source of rows
WHERE p1.id IN (SELECT id FROM products); -- A source of a column


/*
    Understanding the shape of a query results is key!

    SELECT * FROM orders -> Many rows, many columns
    SELECT id FROM orders -> Many rows, one column
    SELECT COUNT(*) FROM orders -> One row, one column (Scalar query)
*/

-- Subquery inside SELECT
SELECT name, price, (
    SELECT MAX(price) FROM products -- if this value is not found, then it will return NULL
)
FROM products
WHERE price > 867;


-- Subquery inside FROM
-- Any subquery, so long as the outer selects/wheres/etc are compatible
-- Subquery must have an alias applied to it.
SELECT name, price_weight_ratio
FROM (SELECT name, price / weight AS price_weight_ratio FROM products) AS p
WHERE price_weight_ratio > 5;

-- More example
SELECT *
FROM (SELECT MAX(price) FROM products) AS p;


/*
Practical use of subquery in a FROM.

Query: Find the average number of orders for all users.

(There can be multiple solution of this problem, but we are using sub query solution here)
*/

SELECT AVG(order_count)
FROM (
    SELECT user_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY user_id
) AS p;


/*
    Subquery in JOIN clause example

    Any subquery that returns data compatible with the 'ON' clause

    NOTE: below query is pointless but added just for example.
*/

SELECT first_name
FROM users
JOIN (
    SELECT user_id
    FROM orders
    WHERE product_id = 3
) AS o
ON o.user_id = users.id


/*
    Subquery in WHERE clause

    Structure of data allowed to be returned by subquery changes
    depending on the comparison operator. For below example we are using
    'IN' operator, so need 1 column multiple rows structure from subquery.

    For example if you use <, >, <=, >=, =, <> or != then subquery should give
    single value.
    For IN and NOT IN it expect a list, so subquery should give single column
    results.


    Query: Show the id of orders that involve a product with a price/weight
    ratio greater than 50.

    NOTE: This is an example. We can avoid subquery using joins also in this case.
*/
SELECT id
FROM orders
WHERE product_id IN (
    SELECT id
    FROM products
    WHERE price / weight > 50
);

-- NOTE: sometimes Postgres try to understand what query we need then
-- rewrite the query, so if you use join or subquery it may give same results.


-- Query: Show the name of all products with a price greater than the average
-- product price.
SELECT name
FROM products
WHERE price > (SELECT AVG(price) FROM products);


-- Query: Show the name of all products that are not in the same department
-- as products with a price less than 100.
SELECT name
FROM products
WHERE department NOT IN (
    SELECT department
    FROM products
    WHERE price < 100
);


-- Query: Show the name, department, and price of products that are more
-- expensive than all products in the 'Industrial department'
SELECT name, department, price
FROM products
WHERE price > (
    SELECT MAX(price)
    FROM products
    WHERE department = 'Industrial'
);

-- Alternate solution of the above
SELECT name, department, price
FROM products
WHERE price > ALL (
    SELECT price
    FROM products
    WHERE department = 'Industrial'
);

/*
> ALL -> Means if the left side is greater than all of the records of right side.
Similarly we have < ALL, >= ALL, <= ALL, = ALL, <> ALL.

We also have '> SOME' Which means if left side is greater than at least one record
of the right side records.

Similarly we have < SOME, >= SOME, <= SOME, = SOME, <> SOME.
ANY is a alias name of SOME. So > SOME is exactly same as > ANY.
*/

--------------

/*
Correlated Sub-Query

Query: Show the name, department, and price of the most expensive product in
each department.
*/

SELECT name, department, price
FROM products AS p1
WHERE p1.price = (
    SELECT MAX(price)
    FROM products AS p2
    WHERE p2.department = p1.department
);


/*
Query: Without using a join or a group by, print the number of orders for each
product
*/
SELECT name,
    (
        SELECT COUNT(*)
        FROM orders AS o1
        WHERE o1.product_id = p1.id
    ) AS num_orders
FROM products AS p1;


-- SELECT without FROM
-- If subquery result is single value
SELECT (
    SELECT MAX(price) FROM products
);

-- Useful when you need to print out aggregation type values at once.
SELECT
    (SELECT MAX(price) FROM phones) AS max_price,
    (SELECT MIN(price) FROM phones) AS min_price,
    (SELECT AVG(price) FROM phones) AS avg_price;

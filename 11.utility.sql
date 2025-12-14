-- Find the greatest in a list
SELECT GREATEST(20, 10, 30) FROM dual;  -- Output: 30

-- Query: Compute the cost to ship each item.
-- Shipping is the maximum of (weight * $2) or $30
SELECT name, GREATEST(weight * 2, 30) AS cost_to_ship
FROM products;

-- Least/minimum value
SELECT LEAST(1, 20, 50, 100) FROM dual;  -- Output: 1

-- Query: All products are on sale.
-- Price is the least of the product price * 0.5 or $400
SELECT name, LEAST(price * 0.5, 400) AS sale_price
FROM products;


-- CASE keyword (both searched and simple forms work identically in Oracle)
-- Query: Print each product and its price. Also print a description of the
-- price. If price > 600 then 'high', if price > 300 then 'medium' else 'cheap'
SELECT
    name,
    price,
    CASE
        WHEN price > 600 THEN 'high'
        WHEN price > 300 THEN 'medium'
        ELSE 'cheap'  -- Without ELSE, result would be NULL for unmatched cases
    END AS price_category
FROM products;

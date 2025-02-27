/*
 Row level validation:
 Things we can check for when a row is being inserted/updated
 - Is a given value defined?
 - Is a value unique in its column?
 - Is a value >, <, >=, <=, = some other value?
 */

-- Table without any validation
CREATE TABLE products1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40),
    department VARCHAR(40),
    price INTEGER,
    weight INTEGER
);


INSERT INTO products1 (name, department, price, weight)
VALUES
    ('Shirt', 'Clothes', 20, 1);

SELECT * FROM products1;


-- Price will be NULL
INSERT INTO products1 (name, department, weight)
VALUES
    ('Shirt', 'Clothes', 3);

/*
Not Null Constraints:

1. When Creating the Table
    CREATE TABLE products1 (
        id SERIAL PRIMARY KEY,
        name VARCHAR(40),
        department VARCHAR(40),
        price INTEGER NOT NULL,
        weight INTEGER
    );
2. After the table was created
*/
ALTER TABLE products1
ALTER COLUMN price
SET NOT NULL;

-- Gives error: "column "price" of relation "products1" contains null values"

-- set price to 9999 for null rows, then run alter command
UPDATE products1
SET price = 9999
WHERE price IS NULL;


INSERT INTO products1 (name, department, weight)
VALUES
    ('Shoes', 'Clothes', 5);
-- Give error: "null value in column "price" of relation "products1" violates not-null constraint"


/*
Default value for a column:

When creating the table:
CREATE TABLE products1 (
    ....
    price INTEGER DEFAULT 999,
    ...
)

After creating the table
*/

ALTER TABLE products1
ALTER COLUMN price
SET DEFAULT 999;


/*
Unique constraints:
CREATE TABLE products1 (
    ...
    name VARCHAR(50) UNIQUE,
    ...
)

Or after created the table
*/

ALTER TABLE products1
ADD UNIQUE (name);

-- First delete already duplicate record otherwise above query will give error.
DELETE FROM products1
WHERE id IN (SELECT id FROM products1 WHERE name = 'Shirt' OFFSET 1);


-- Shirt already exists, so this will give error
-- duplicate key value violates unique constraint "products1_name_key"
INSERT INTO products1 (name, department, price, weight)
VALUES
    ('Shirt', 'Tool', 30, 3);

-- DELETE Constraints
ALTER TABLE products1
DROP CONSTRAINT products1_name_key;


-- Multi column unique Constraints
ALTER TABLE products1
ADD UNIQUE (name, department);

ALTER TABLE products1
DROP CONSTRAINT products1_name_department_key;


/* Don't allow negative price
Currently it will not give any error if we put negative price

When creating the table 
CREATE TABLE products (
    ...
    price INTEGER CHECK (price > 0),
    ...
)

Or after creating the table
*/
ALTER TABLE products1
ADD CHECK (price > 0);

DELETE FROM products1 WHERE price <= 0;

INSERT INTO products1 (name, department, price, weight)
VALUES
    ('Belt', 'Clothes', -99, 1);


-- Checks over multiple columns
CREATE TABLE orders1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    est_delivery TIMESTAMP NOT NULL,
    CHECK (created_at < est_delivery)
);

INSERT INTO orders1 (name, created_at, est_delivery)
VALUES ('Shirt', '2000-Nov-20 01:00AM', '2000-Nov-25 01:00AM');

-- Give error
-- new row for relation "orders1" violates check constraint "orders1_check"
INSERT INTO orders1 (name, created_at, est_delivery)
VALUES ('Shirt', '2000-Nov-20 01:00AM', '2000-Nov-10 01:00AM');
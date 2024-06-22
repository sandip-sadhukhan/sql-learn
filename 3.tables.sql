/*
Three types of relationships:
- One to many OR many to one [Many side of the relationship gets the foreign key column]
- One to one
- Many to many
*/

-- Auto increment ID
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50)
)


INSERT INTO users (username)
VALUES
    ('monahan93'),
    ('pferrer'),
    ('si93onis'),
    ('99stroman');

SELECT * FROM users;


-- How to define Foreign key in table
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200),
    user_id INTEGER REFERENCES users(id)
)

INSERT INTO PHOTOS (url, user_id)
VALUES
    ('http:/one.jpg', 4),
    ('http:/754.jpg', 2),
    ('http:/35.jpg', 3),
    ('http:/256.jpg', 4);

SELECT * FROM photos;

-- Find all the photos created by user with ID 4
SELECT * FROM photos WHERE user_id = 4;

-- FK to join and return data from two tables
SELECT url, username FROM photos
JOIN users ON users.id = photos.user_id;

-- This line will give error saying it violet foreign key constraints
DELETE FROM users WHERE id = 4;

/*
Reason - we have photos with user_id = 1, so what will happen to them?

We can control this by on delete options.

[On delete option] -> [What happens if you try to delete a user when a photo is still referencing it]
ON DELETE NO ACTION -> Throws an error (Default value)
ON DELETE RESTRICT -> Throws an error
ON DELETE CASCADE -> Delete related photos too!
ON DELETE SET NULL -> set `user_id=NULL` for those photos.
ON DELETE SET DEFAULT -> set `user_id` of a photo to default value if one is provided.
*/


-- Delete a table
DROP TABLE photos;


-- Example ON DELETE
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200),
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL
)

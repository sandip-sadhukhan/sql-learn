/*
Grouping: Reduces many rows down to fewer rows.
          Done by using 'GROUP BY' keyword.

Aggregates: Reduces many values down to one.
            Done by using `aggregate functions`.
*/


/*
What the below command will do?

GROUP BY user_id -> Find the set of all unique user_id's
-> Take each row and assign it to a group based on its user_id

We only allowed to directly select common user_id column. It will give
error if we try to select any other column like `contents` directly.
*/
SELECT user_id
FROM comments
GROUP BY user_id;


/*

Different Aggregate Functions:

COUNT() -> Returns the number of values in a group of values.
SUM() -> Finds the sum of a group of numbers.
AVG() -> Finds the average of a group of numbers.
MIN() -> Returns the minimum value from a group of numbers.
MAX() -> Returns the maximum value from a group of numbers.

NOTE: We can't select any other normal column with aggregate column.
      It will give error.
*/

SELECT MAX(id)
FROM comments;

-- Combine Aggregate with Group by.
-- Total number of comment done by each user
SELECT user_id, COUNT(id) AS num_comments_created
FROM comments
GROUP BY user_id;


SELECT * FROM photos;
-- When we used COUNT then null values are not counted
SELECT COUNT(user_id) FROM photos;
-- * will count total rows irrespective of null values.
SELECT COUNT(*) FROM photos;

-- Better to use COUNT(*)
SELECT user_id, COUNT(*)
FROM comments
GROUP BY user_id;

-- Find the number of comments for each photo
SELECT photo_id, COUNT(*) as num_comments_per_photo
FROM comments
GROUP BY photo_id;

-- Join with Aggregate and Group by
SELECT photos.url, COUNT(*) as num_comments_per_photo
FROM comments
JOIN photos ON photos.id = comments.photo_id
GROUP BY photos.url;

-- Order of keywords: FROM -> JOIN -> WHERE -> GROUP BY -> HAVING

-- Having: Filters the set of groups.

-- Find the number of comments for each photo where the photo_id is
-- less than 3 and the photo has more than 2 comments.

SELECT photo_id, COUNT(*)
FROM comments
WHERE photo_id < 3
GROUP BY photo_id
HAVING COUNT(*) > 2;

-- Find the users(user_ids) where the user has commented on the
-- first 50 photos and the user added more than 20 comments on those
-- photos.
SELECT user_id, COUNT(*)
FROM comments
WHERE photo_id <= 50
GROUP BY user_id
HAVING COUNT(*) > 20;

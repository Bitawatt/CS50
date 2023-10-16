-- Write a query to list the titles of all movies with a release date on or after 2018
-- 1 column, title

SELECT title
FROM movies
WHERE year >= 2018
ORDER BY title;
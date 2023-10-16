-- Write a query to list the names of all people who starred in a movie released in 2004
--  ordered by birth year
-- 1 column, name

SELECT DISTINCT people.name
FROM movies m
JOIN stars ON m.id = movie_id
JOIN people ON stars.person_id = people.id
WHERE year = 2004
ORDER BY people.birth;

/*
 people.birth, m.title, m.year
 AND people.birth IS NOT NULL
 */
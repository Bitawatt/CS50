-- Write a query to list the titles of all movies in which both Bradley Cooper and Jennifer Lawrence starred.
-- 1 column, title

SELECT m.title
FROM movies m
JOIN stars s ON m.id = s.movie_id
JOIN people p ON s.person_id = p.id
WHERE p.name = 'Jennifer Lawrence' AND m.id IN (
    SELECT s2.movie_id
    FROM stars s2
    JOIN people p2 ON p2.id = s2.person_id
    WHERE p2.name = 'Bradley Cooper'
    );

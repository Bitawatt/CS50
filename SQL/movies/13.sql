-- Write a query to list the names of all people who starred in a movie in which Kevin Bacon also starred.
-- Be sure to only query (and exclude) the Kevin Bacon born in 1958.

SELECT DISTINCT p.name
FROM movies m
JOIN stars s ON m.id = s.movie_id
JOIN people p ON s.person_id = p.id
WHERE m.id IN (
    SELECT s2.movie_id
    FROM stars s2
    JOIN people p2 ON s2.person_id = p2.id
    WHERE p2.name = 'Kevin Bacon' AND p2.birth = 1958
) AND p.name <> 'Kevin Bacon';

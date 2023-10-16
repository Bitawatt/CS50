-- Write a query to list the titles of the five highest rated movies (in order) that Chadwick Boseman starred in
--  starting with the highest rated.

SELECT m.title
FROM movies m
JOIN ratings r ON m.id = r.movie_id
JOIN people p ON s.person_id = p.id
JOIN stars s ON m.id = s.movie_id
WHERE p.name = 'Chadwick Boseman'
ORDER BY r.rating DESC LIMIT 5;
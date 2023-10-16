-- Write a query to list the names of all the people who have directed a movie that received a rating of at least 9.0
-- 1 column, name of each director
-- DISTINCT

SELECT DISTINCT p.name
FROM movies m
JOIN ratings r ON m.id = r.movie_id
JOIN directors d ON m.id = d.movie_id
JOIN people p ON d.person_id = p.id
WHERE r.rating >= 9.0;
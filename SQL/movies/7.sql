-- Write a query to list all movies released in 2010 and their ratings, in descending order by rating.
-- Movies with the same rating ordered alphabetically

SELECT title, ratings.rating
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
WHERE year = 2010
ORDER BY ratings.rating DESC, title;
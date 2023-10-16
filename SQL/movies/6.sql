-- Write a query to determine the average rating of all movies released in 2012

SELECT avg(ratings.rating)
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
WHERE year = 2012;
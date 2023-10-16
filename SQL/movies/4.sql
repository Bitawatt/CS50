-- write a query to determine the number of movies with an IMDb rating of 10.0.
-- 1 column, 1 row

SELECT COUNT(movie_id)
FROM ratings
WHERE rating = 10.0;

/*
SELECT songs.name
FROM songs
JOIN artists ON songs.artist_id = artists.id
GROUP BY songs.id
HAVING COUNT(artists.id) > 1;
*/
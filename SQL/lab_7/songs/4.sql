-- Write a SQL query that lists the names of any songs that have danceability, energy, and valence greater than 0.75.
-- The query should output a table with a single column for the name of each song.

SELECT name
FROM songs
WHERE danceability > 0.75 AND energy > 0.75 AND valence > 0.75;

/*
+---------------------------------------------+
|                    name                     |
+---------------------------------------------+
| Dura                                        |
| Me Niego                                    |
| Feel It Still                               |
| 1, 2, 3 (feat. Jason Derulo & De La Ghetto) |
| Criminal                                    |
+---------------------------------------------+
*/
-- Write a SQL query that returns the average energy of all the songs.
-- The query should output a table with a sinle column and a single row containing the average energy.

SELECT AVG(energy)
FROM songs;

/*
+-------------+
| AVG(energy) |
+-------------+
| 0.65906     |
+-------------+
*/

/*
SELECT AVG(danceability), AVG(energy), AVG(valence)
FROM songs;

+-------------------+-------------+--------------+
| AVG(danceability) | AVG(energy) | AVG(valence) |
+-------------------+-------------+--------------+
| 0.71646           | 0.65906     | 0.484443     |
+-------------------+-------------+--------------+
*/
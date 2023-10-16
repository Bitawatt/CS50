-- Write a SQL query that returns the average energy of songs that are by Drake.
-- The query should output a table with a single column and single row containing average energy.

SELECT AVG(energy)
FROM songs
WHERE artist_id = (
    SELECT id
    FROM artists
    WHERE name = 'Drake');

/*
+-------------+
| AVG(energy) |
+-------------+
| 0.599       |
+-------------+
*/
-- Write a SQL query that lists the names of songs that are by Post Malone.
-- The query should return a single column for the name of each song.

SELECT name
FROM songs
WHERE artist_id = (
    SELECT id
    FROM artists
    WHERE name = 'Post Malone');

/*
+------------------------------+
|             name             |
+------------------------------+
| rockstar (feat. 21 Savage)   |
| Psycho (feat. Ty Dolla $ign) |
| Better Now                   |
| I Fall Apart                 |
| Candy Paint                  |
| Congratulations              |
+------------------------------+
*/
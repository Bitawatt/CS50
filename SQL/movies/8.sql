-- Write a query to list the names of all people who starred in Toy Story

SELECT DISTINCT people.name
FROM movies
JOIN stars ON stars.movie_id = movies.id
JOIN people ON people.id = stars.person_id
JOIN movies AS m ON m.id = stars.movie_id
WHERE m.title = 'Toy Story'

-- The below is my first successful attempt (there were many before).
-- I asked Copilot why it was so slow, and why I had to use the `DISTINCT`
--  operator, since I don't running the blocks individually w/o JOIN.
-- The above code is optimized with the help of Copilot, and looks way cooler.
-- I learned something I feel like I needed to know, and the above code seems
--  like the way this query ought to be formatted.
-- The below code works.

/*
SELECT DISTINCT people.name
FROM movies
JOIN stars ON stars.movie_id = movies.id
JOIN people ON people.id = stars.person_id
WHERE people.id IN (
    SELECT person_id
    FROM stars
    WHERE movie_id = (
        SELECT id
        FROM movies
        WHERE title = 'Toy Story'
    )
);
*/
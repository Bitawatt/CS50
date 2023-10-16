-- Keep a log of any SQL queries you execute as you solve the mystery.

/*
Goal:

    1. Discover who the theif is
    2. What city the thief escaped to, and
    3. Who the thief's accomplice is who helped them escape

Specs:

    - Keep a log of all (valid) queries run on the database
        - comment each query
            - describing why the query is run
            - what information is desired from running each query

Hints:

    - The crime took place:
        - July 28, 2021
        - on Humphrey Street
        - in Fiftyville (USA)
    - executing `.tables` will list all of the tables in the database.
    - executing `.schema TABLE_NAME`, will show the `CREATE_TABLE` command
        used to create the table.
    - check out the `crime_scene_reports` table first, for a report that
        mathches the date and location of the crime.

Investigation:

    1.
        Query: */
            SELECT *
            FROM crime_scene_reports
            WHERE
                year = 2021
                AND month = 7
                AND day = 28
                AND street = 'Humphrey Street'
            ;
        /*
        Result:
+-----+------+-------+-----+-----------------+-----------------------------------------------------------------------------+
| id  | year | month | day |     street      |                            description                                      |
+-----+------+-------+-----+-----------------+-----------------------------------------------------------------------------+
| 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. |
|     |      |       |     |                 |     Interviews were conducted today with three witnesses who were present   |
|     |      |       |     |                 |     at the time – each of their interview transcripts mentions the bakery.  |
| 297 | 2021 | 7     | 28  | Humphrey Street | Littering took place at 16:36. No known witnesses.                          |
+-----+------+-------+-----+-----------------+-----------------------------------------------------------------------------+

        Comments:
            Query ran for the sake of the available information.

        Information:
            - 10:15am
            - Humphrey Street bakery
            - crime_scene_reports.id
                - 295
            - three witnesses

        Next: Query the bakery security logs then maybe the airport

    2.
        Query: */
            SELECT *
            FROM bakery_security_logs
            WHERE
                year = 2021
                AND month = 7
                AND day = 28
                AND hour = 10
            ;
        /*
        Result: (amended after the next query)
            +---+------+-------+-----+------+--------+----------+---------------+
            | i | year | month | day | hour | minute | activity | license_plate |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 8      | entrance | R3G7486       |
            | 5 |      |       |     |      |        |          |               |
            | 8 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 14     | entrance | 13FNH73       |
            | 5 |      |       |     |      |        |          |               |
            | 9 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
            | 6 |      |       |     |      |        |          |               |
            | 0 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
            | 6 |      |       |     |      |        |          |               |
            | 1 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
            | 6 |      |       |     |      |        |          |               |
            | 2 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
            | 6 |      |       |     |      |        |          |               |
            | 3 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
            | 6 |      |       |     |      |        |          |               |
            | 4 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
            | 6 |      |       |     |      |        |          |               |
            | 5 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
            | 6 |      |       |     |      |        |          |               |
            | 6 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+
            | 2 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
            | 6 |      |       |     |      |        |          |               |
            | 7 |      |       |     |      |        |          |               |
            +---+------+-------+-----+------+--------+----------+---------------+

        Comments:
            Due to the relevant information from the crime_scene_report, we fortunately have
                documentation of the comings and goings at the bakery, and a possible plate #.

        Information:
            license_plate:
                - 5P2BI95

        Next: Let's check out those interviews, and then maybe atms between the bakery
                and the airport.

    3.
        Query:
        */
            SELECT *
            FROM interviews
            WHERE
                year = 2021
                AND month = 7
                AND day = 28
                AND transcript LIKE '%bakery%'
            ;
        /*
        Result:
+---+---------+------+-------+-----+--------------------------------------------------------------------------------------------------------------------+
| i |  name   | year | month | day |                                               transcript                                                           |
+---+---------+------+-------+-----+--------------------------------------------------------------------------------------------------------------------+
| 1 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. |
| 6 |         |      |       |     | If you have security footage from the bakery parking lot, you might want to look for cars that left the parking    |
| 1 |         |      |       |     | lot in that time frame.                                                                                            |
+---+---------+------+-------+-----+--------------------------------------------------------------------------------------------------------------------+
| 1 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's   |
| 6 |         |      |       |     | bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                 |
| 2 |         |      |       |     |                                                                                                                    |
+---+---------+------+-------+-----+--------------------------------------------------------------------------------------------------------------------+
| 1 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute.                |
| 6 |         |      |       |     | In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. |
| 3 |         |      |       |     | The thief then asked the person on the other end of the phone to purchase the flight ticket.                       |
+---+---------+------+-------+-----+--------------------------------------------------------------------------------------------------------------------+

        Comments: This was the logical first step
            From the above interviews we should be able to:
                - query who:
                    - `exit`ed the bakery between 10:15 am, and 10:25 am.
                    - made an atm_transactions, withdraw, on 'Leggett Street' on July 28, 2021
                        - from there get the `bank_account.person_id` from the `atm.account_number`
                    - made a `phone_calls` the between 10:15 am, and 10:25 am, on July 28, 2021. (`phone_calls.duration` is ambiguous)
                    - was on a flight out of town the next morning (purportedly the earliest)

        Information: (lots)
            - theif left bakery between:
                - 10:15 and 10:25
            - theif visited:
                - atm on Leggett Street
                - made a withdrawal
            - theif called someone:
                - < 1-minute
                - earliest flight
                    - Fiftyville departure
                    - July 29, 2021
                    - someone (not the theif, the accomplice) purchased a ticket

        Next:
            - re-query for license plates exiting the bakery
                - relate table.people with license plates
            - use the above query to cross:
                - passengers on flight
                - phone calls
            - query the atm
            - query the flight
                - purchase info (none)

    4.
        Query:
            - find the exiting license plates
                */
                SELECT p.name
                FROM bakery_security_logs b
                JOIN people p ON b.license_plate = p.license_plate
                WHERE
                    year = 2021
                    AND month = 7
                    AND day = 28
                    AND hour = 10
                    AND minute < 25
                    AND activity = 'exit';
                /*
            - the above not yet run
            - cross the phone calls (phone calls didn't yield results???)
                */
                SELECT *
                FROM people
                WHERE name IN
                (
                    SELECT p.name
                    FROM bakery_security_logs b
                    JOIN people p ON b.license_plate = p.license_plate
                    WHERE
                        year = 2021
                        AND month = 7
                        AND day = 28
                        AND hour = 10
                        AND minute < 25
                        AND activity = 'exit'
                )
                ;
                /*
            Result: People from bakery exits ~ 10-mins f/theft (really just here for mental reference)
                +------------+---------+----------------+-----------------+---------------+
                |     id     |  name   |  phone_number  | passport_number | license_plate |
                +------------+---------+----------------+-----------------+---------------+
                | 221103     | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
                | 243696     | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       |
                | 396669     | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
                | 398010     | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
                | 467400     | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
                | 514354     | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
                | 560886     | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
                | 686048     | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
                +------------+---------+----------------+-----------------+---------------+

            Query: duplicate the above query and adjust
                - Calls less than a minute of those exiting the backery at the time of the thing
                */
                SELECT *
                FROM phone_calls
                Where -- duration < 60 AND -- we don't know the units of `phone_calls.duration`
                    caller IN
                    (
                    SELECT phone_number
                    FROM people
                    WHERE name IN
                    (
                        SELECT p.name
                        FROM bakery_security_logs b
                        JOIN people p ON b.license_plate = p.license_plate
                        WHERE
                            year = 2021
                            AND month = 7
                            AND day = 28
                            AND hour = 10
                            AND minute < 25
                            AND activity = 'exit'
                    )
                )
                ;
                /* *we'll save this for later, it's not much use now. (What kind of call log doesn't
                    have a time-stamp?!) **oh, those in relational database***

            Result: *So many people on their phone!*

                +------------+----------------+----------------+------+-------+-----+----------+
                |     id     |     caller     |    receiver    | year | month | day | duration |
                +------------+----------------+----------------+------+-------+-----+----------+
                | 221        | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       |
                | 224        | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       |
                | 233        | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
                | 251        | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       |
                | 255        | (770) 555-1861 | (725) 555-3243 | 2021 | 7     | 28  | 49       |
                +------------+----------------+----------------+------+-------+-----+----------+

            Query: quickly query the atm the morning of
                */
                SELECT *
                FROM atm_transactions
                WHERE
                    year = 2021
                    AND month = 7
                    AND day = 28
                    AND atm_location = 'Leggett Street'
                    AND transaction_type = 'withdraw'
                ;
                /*
                +------------+----------------+------+-------+-----+----------------+------------------+--------+
                |     id     | account_number | year | month | day |  atm_location  | transaction_type | amount |
                +------------+----------------+------+-------+-----+----------------+------------------+--------+
                | 246        | 28500762       | 2021 | 7     | 28  | Leggett Street | withdraw         | 48     |
                | 264        | 28296815       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |
                | 266        | 76054385       | 2021 | 7     | 28  | Leggett Street | withdraw         | 60     |
                | 267        | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     |
                | 269        | 16153065       | 2021 | 7     | 28  | Leggett Street | withdraw         | 80     |
                | 288        | 25506511       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |
                | 313        | 81061156       | 2021 | 7     | 28  | Leggett Street | withdraw         | 30     |
                | 336        | 26013199       | 2021 | 7     | 28  | Leggett Street | withdraw         | 35     |
                +------------+----------------+------+-------+-----+----------------+------------------+--------+
            Comment: With the assumption that `bank_accounts.person_id` = `people.id` we should be able to JOIN
                        these said tables with `atm_transactions`, i.e., the above query to get a name of those
                        who made an atm withdraw and also exited the backery < 10-mins after the theft.

            Query:
                */
                SELECT *
                FROM people p
                JOIN bank_accounts acct1 ON acct1.person_id = p.id
                -- JOIN atm_transactions atm1 ON atm1.account_number = acct1.account_number -- may be redundant here, used later
                WHERE p.id =
                (
                    SELECT acct.person_id
                    FROM bank_accounts acct
                    JOIN atm_transactions atm ON atm.account_number = acct.account_number
                    WHERE atm.account_number IN (
                        -- previous query
                        SELECT account_number
                        FROM atm_transactions
                        WHERE
                            year = 2021
                            AND month = 7
                            AND day = 28
                            AND atm_location = 'Leggett Street'
                            AND transaction_type = 'withdraw'
                    )

                )
                AND p.license_plate IN (
                    -- bakery exits with phone calls query
                    SELECT license_plate
                    FROM people
                    WHERE name IN
                    (
                        SELECT p.name
                        FROM bakery_security_logs b
                        JOIN people p ON b.license_plate = p.license_plate
                        WHERE
                            year = 2021
                            AND month = 7
                            AND day = 28
                            AND hour = 10
                            AND minute < 25
                            AND activity = 'exit'
                    )
                )
                ;
                /*
            Result: **WE HAVE A MATCH!!!**
+--------+------+----------------+-----------------+---------------+----------------+-----------+---------------+
|   id   | name |  phone_number  | passport_number | license_plate | account_number | person_id | creation_year |
+--------+------+----------------+-----------------+---------------+----------------+-----------+---------------+
| 467400 | Luca | (389) 555-5198 | 8496433585      | 4328GD8       | 28500762       | 467400    | 2014          |
+--------+------+----------------+-----------------+---------------+----------------+-----------+---------------+            Comment: And who did Luca call?!

            Query: a phone_calls/people query filtered by Luca's `phone_number`
                */
                    SELECT *
                    FROM people p
                    JOIN phone_calls calls ON p.id = calls.id
                    WHERE
                /*

            Query: The Flight
                */
                SELECT *
                FROM flights
                WHERE
                    year = 2021
                    AND month = 7
                    AND day = 29
                    AND hour < 12
                    AND origin_airport_id = (
                        SELECT id
                        FROM airports
                        WHERE city = 'Fiftyville'
                    )
                ;
                /*
            Result:
                +------------+-------------------+------------------------+------+-------+-----+------+--------+
                |     id     | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
                +------------+-------------------+------------------------+------+-------+-----+------+--------+
                | 36         | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
                | 43         | 8                 | 1                      | 2021 | 7     | 29  | 9    | 30     |
                +------------+-------------------+------------------------+------+-------+-----+------+--------+
            Comment: *needs to be ORDERED BY hour and LIMIT 1 for nested use*

            Infomation:
                - Flight # 36

            Next: Query the passenger list of flight 36 with the exits of the backery

            Query:
                */
                    SELECT *
                    FROM people
                    WHERE passport_number =
                    (
                            SELECT passport_number
                            FROM passengers
                            WHERE flight_id = (
                                SELECT id
                                FROM flights
                                WHERE
                                    year = 2021
                                    AND month = 7
                                    AND day = 29
                                    AND hour < 12
                                    AND origin_airport_id = (
                                        SELECT id
                                        FROM airports
                                        WHERE city = 'Fiftyville'
                                    )
                                ORDER BY hour
                                LIMIT 1
                            )
                    )
                    ;
                /*
            Result: works
            Next: cross with those leaving the bakery
            Query:
                */
                AND passport_number IN (
                    SELECT passport_number
                    FROM people
                    WHERE name IN
                    (
                        SELECT p.name
                        FROM bakery_security_logs b
                        JOIN people p ON b.license_plate = p.license_plate
                        WHERE
                            year = 2021
                            AND month = 7
                            AND day = 28
                            AND hour = 10
                            AND minute < 25
                            AND activity = 'exit'
                    )
                )
                ;
                /*
            Result: the above match (Luca, pp_# - 8496433585) was on the flight (along with a few others that were leaving the bakery - CONSPIRACY???)
                +-----------+-----------------+------+
                | flight_id | passport_number | seat |
                +-----------+-----------------+------+
                | 36        | 1695452385      | 3B   |
                | 36        | 5773159633      | 4A   |
                | 36        | 8294398571      | 6C   |
                | 36        | 8496433585      | 7B   | *****
                +-----------+-----------------+------+

            PROBLEM: ***Luca doesn't seem to have made the phone call that was reported in the interviews***

            Query: Luca's phone_calls on July 28, 2021:
                */
                SELECT *
                FROM phone_calls
                WHERE caller = '(389) 555-5198'
                    AND year = 2021
                    AND month = 7
                    AND day = 28
                ;
                /*
            Result: NULL
            Query: Test the above query to see Luca's calls July, 27, 28, & 29.
                */
                    SELECT *
                    FROM phone_calls
                    WHERE caller = '(389) 555-5198'
                        AND year = 2021
                        AND month = 7
                        AND day IN (27, 28, 29)
                    ;
                /*
            Result: Luca did not call anyone on the 28th of July
                +-----+----------------+----------------+------+-------+-----+----------+
                | id  |     caller     |    receiver    | year | month | day | duration |
                +-----+----------------+----------------+------+-------+-----+----------+
                | 326 | (389) 555-5198 | (609) 555-5876 | 2021 | 7     | 29  | 397      |
                +-----+----------------+----------------+------+-------+-----+----------+

            Information: (EDITTED FROM ABOVE)
            - Luca left bakery between:
                - 10:15 and 10:25
            - Luca visited:
                - atm on Leggett Street
                - made a withdrawal
            - theif called someone: ***LUCA DID NOT***
                - < 1-minute
                - earliest flight (ID - 36)
                    - Fiftyville departure @ 8:20 am
                    - July 29, 2021
                    - someone (not the theif) purchased a ticket

            Next:
                Who:
                    - Was exiting the bakery
                    - Made a phone call, and
                    - Was on Flight 36

            Query:
                */
                SELECT DISTINCT *
                FROM people p
                JOIN passengers psrs ON p.passport_number = psrs.passport_number
                            AND psrs.flight_id = 36
                JOIN phone_calls calls ON p.phone_number = calls.caller
                            AND calls.year = 2021
                            AND calls.month = 7
                            AND calls.day = 28
                JOIN bakery_security_logs bake ON p.license_plate = bake.license_plate
                            AND bake.year = 2021
                            AND bake.month = 7
                            AND bake.day = 28
                            AND bake.hour = 10
                            AND bake.minute < 25
                            AND bake.activity = 'exit'
                ;
                /*
+--------+--------+----------------+-----------------+---------------+-----------+-----------------+------+-----+----------------+----------------+------+-------+-----+----------+-----+------+-------+-----+------+--------+----------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate | flight_id | passport_number | seat | id  |     caller     |    receiver    | year | month | day | duration | id  | year | month | day | hour | minute | activity | license_plate |
+--------+--------+----------------+-----------------+---------------+-----------+-----------------+------+-----+----------------+----------------+------+-------+-----+----------+-----+------+-------+-----+------+--------+----------+---------------+
| 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       | 36        | 1695452385      | 3B   | 221 | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       | 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 36        | 5773159633      | 4A   | 245 | (367) 555-5533 | (022) 555-4052 | 2021 | 7     | 28  | 241      | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 36        | 5773159633      | 4A   | 236 | (367) 555-5533 | (344) 555-9601 | 2021 | 7     | 28  | 120      | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 36        | 5773159633      | 4A   | 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 36        | 5773159633      | 4A   | 285 | (367) 555-5533 | (704) 555-5790 | 2021 | 7     | 28  | 75       | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       | 36        | 8294398571      | 6C   | 251 | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       | 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       | 36        | 8294398571      | 6C   | 224 | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       | 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
+--------+--------+----------------+-----------------+---------------+-----------+-----------------+------+-----+----------------+----------------+------+-------+-----+----------+-----+------+-------+-----+------+--------+----------+---------------+

                Next: Let's see if ***Sofia, Bruce, or Kelsey*** were at the atm on Leggett Street

                Query: added the following to the previous
                    */
                    JOIN bank_accounts acct ON p.id = acct.person_id
                        WHERE acct.account_number = (
                            SELECT account_number
                            FROM atm_transactions
                            WHERE
                                year = 2021
                                AND month = 7
                                AND day = 28
                                AND atm_location = 'Leggett Street'
                                AND transaction_type = 'withdraw'
                        )
                    ;
                    /*
                Result: NULL

                Information: No one that exited the bakery and was on the flight made the reported atm withdrawal.

                Next: Who was on the flight that also gave a crime_scene_reports interview - NULL
                        *well, I don't know...*
                    From Above:
                        From the interviews we should be able to query who:
                            - `exit`ed the bakery between 10:15 am, and 10:25 am.
                            - made an atm_transactions, withdraw, on 'Leggett Street' on July 28, 2021
                                - from there get the `bank_account.person_id` from the `atm.account_number`
                            - made a `phone_calls` the between 10:15 am, and 10:25 am, on July 28, 2021. (`phone_calls.duration` is ambiguous)
                            - was on a flight out of town the next morning (purportedly the earliest)
                    However:
                        - Luca:
                            - was on flight 36
                                - July 29,2021
                            - exited the bakery
                                - between 10:15 am and 10:25 am
                                - July 28,2021
                            - made an atm withdrawal
                                - at the Leggett Street location
                                - the morning of July 28, 2021
                            - did NOT make a phone call
                                - between 10:15 am and 10:25 am
                                - apparently on July 28, 2021 at all
                        - Sophia, Bruce, and Kelsey
                            - were on flight 36
                                - July 29,2021
                            - exited the bakery
                                - between 10:15 am and 10:25 am
                                - July 28,2021
                            - all made phone calls
                                - between 10:15 am and 10:25 am
                                - July 28,2021
                            - did NOT make any atm_transactions
                                - at the Leggett Street location
                                - the morning of July 28, 2021
                        Therefore:
                            - Since we have no persons who satisfy all of the witness interview claims:
                                - we must assume that at least one element of that information is in error.
                            - We discern that the greatest amount of uncertainty lies with the information regarding:
                                - "[the theif was] planning to take the earliest flight out of Fiftyville tomorrow."
                                    - "tomorrow" being July, 29 2021
                                    - perhaps this flight was book and they had to take the next to earliest flight (there's only two in the am)
                                        - query: finding people who exited the bakery that were on the second flight out of Fiftyville July 29, 2021
                                                 SELECT *
                                                 FROM people
                                                 WHERE passport_number =
                                                 (
                                                            SELECT passport_number
                                                            FROM passengers
                                                            WHERE flight_id = (
                                                                SELECT id
                                                                FROM flights
                                                                WHERE
                                                                    year = 2021
                                                                    AND month = 7
                                                                    AND day = 29
                                                                    AND hour < 12
                                                                    AND origin_airport_id = (
                                                                        SELECT id
                                                                        FROM airports
                                                                        WHERE city = 'Fiftyville'
                                                                    )
                                                                ORDER BY hour DESC -- added `DESC` to select the other flight the am of July 29, 2021
                                                                LIMIT 1
                                                            )
                                                            AND passport_number IN (
                                                                SELECT passport_number
                                                                FROM people
                                                                WHERE name IN
                                                                (
                                                                    SELECT p.name
                                                                    FROM bakery_security_logs b
                                                                    JOIN people p ON b.license_plate = p.license_plate
                                                                    WHERE
                                                                        year = 2021
                                                                        AND month = 7
                                                                        AND day = 28
                                                                        AND hour = 10
                                                                        AND minute < 25
                                                                        AND activity = 'exit'
                                                                )
                                                            )
                                                 )
                                                 ;
                    [- Result: NULL]
                            Next:
                                - we don't know whose phone the theif was using
                                    - perhaps it belonged to the accomplice
                                    - we could postulate that they switched phones??? and:
                                        - query: replacing `caller` with `receiver` for Luca's phone
                                            */
                                                SELECT *
                                                FROM phone_calls
                                                WHERE receiver = '(389) 555-5198'
                                                    AND year = 2021
                                                    AND month = 7
                                                    AND day = 28
                                                ;
                                            /*
                                        - and get:
                                            +-----+----------------+----------------+------+-------+-----+----------+
                                            | id  |     caller     |    receiver    | year | month | day | duration |
                                            +-----+----------------+----------------+------+-------+-----+----------+
                                            | 227 | (544) 555-8087 | (389) 555-5198 | 2021 | 7     | 28  | 595      |
                                            | 234 | (609) 555-5876 | (389) 555-5198 | 2021 | 7     | 28  | 60       |
                                            +-----+----------------+----------------+------+-------+-----+----------+
                                            - so at least some activity...
                                            - we have one `phone_calls` whose `duration` may be:
                                                - if `duration` is in `ms` then:
                                                    - both calls are less than 1-minute
                                                - if `duration` is in `seconds` then:
                                                    - neither call is ***less*** than 1-minute
                                                        - but 60-seconds is damn close to "less than a minute"
                                                - We'll go on the presumption that the second call, id 234, is that witnessed at the bakery
                                                    - query
                                                        */
                                                        SELECT *
                                                        FROM people
                                                        WHERE phone_number =
                                                        (
                                                                                SELECT caller
                                                                                FROM phone_calls
                                                                                WHERE receiver = '(389) 555-5198'
                                                                                    AND year = 2021
                                                                                    AND month = 7
                                                                                    AND day = 28
                                                                                ORDER BY id DESC
                                                                                LIMIT 1
                                                        );
                                                        /*
                                                    - and get:
                                                        +--------+---------+----------------+-----------------+---------------+
                                                        |   id   |  name   |  phone_number  | passport_number | license_plate |
                                                        +--------+---------+----------------+-----------------+---------------+
                                                        | 561160 | Kathryn | (609) 555-5876 | 6121106406      | 4ZY7I8T       |
                                                        +--------+---------+----------------+-----------------+---------------+
                                                    - let's see if `Kathryn` skipped town with `Luca`...
                                                        - we'll check `passengers` `flight_id =  36` for `Kathryn`'s `passport_number`
                                                            - query:
                                                                */
                                                                    SELECT *
                                                                    FROM passengers
                                                                    WHERE flight_id = 36 AND passport_number = '6121106406';
                                                                /*
                                                    - NOPE!
                                                    - What about any flight?
                                                        - query:
                                                                */
                                                                    SELECT *
                                                                    FROM passengers
                                                                    WHERE passport_number = '6121106406';
                                                                /*
                                                        - and get:
                                                            +-----------+-----------------+------+
                                                            | flight_id | passport_number | seat |
                                                            +-----------+-----------------+------+
                                                            | 34        | 6121106406      | 2A   |
                                                            +-----------+-----------------+------+
                                                        - and flight 34:
                                                            - query: are flights 34 & 36 perhaps the same destination?
                                                                */
                                                                    SELECT *
                                                                    FROM airports air
                                                                    JOIN flights f ON f.destination_airport_id = air.id
                                                                    WHERE f.id IN (34, 36);
                                                                /*
                                                            - no dice:
+----+--------------+-----------------------------------------+---------------+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | abbreviation |                full_name                |     city      | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+--------------+-----------------------------------------+---------------+----+-------------------+------------------------+------+-------+-----+------+--------+
| 5  | DFS          | Dallas/Fort Worth International Airport | Dallas        | 34 | 8                 | 5                      | 2021 | 7     | 28  | 17   | 20     |
| 4  | LGA          | LaGuardia Airport                       | New York City | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
+----+--------------+-----------------------------------------+---------------+----+-------------------+------------------------+------+-------+-----+------+--------+

                Information:
                    - Kathryn and Luca both boarded flights from Fiftyville within:
                        - 15-hours of each other, and
                        - 23-hours of the theft of the rubber-duckie
                        - Those flights did not have the same destination - inconclusive

                Conclusion:
                    - Of the people leaving the scene of the crime
                        - Luca is the most likely culprit
                            - since they:
                                - made an atm withdrawal at the location, on the day, a witness saw the theif making a transaction
                                - boarded a flight (the earliest flight the following morning) as the theif was overheard to be planning
                                - made a phone call of the approximate duration as reported by a witness of the heinous crime
                    - Kathryn is the most likely accomplice:
                        - since they:
                            - are with whom the phone call was that was witnessed at the scene
                                - if Luca is the culprit
                            - also boarded a flight out of Fiftyville shortly after the atroscious crime

**************************************************************************************************************************************************
||| Thanks to `Check50` an innocent man does not stand accused tonight. It was a weak case, and I'm a bit ashamed of checking it having        |||
||| concluded that Luca and Kathryn where likely the guilty parties. Upon reflection an `=` was used where `IN` was necessary in a conditional |||
||| `WHERE` statement. This resulted in only querying the first available response instead of the intended list and an erroneous result where  |||
||| Bruce did not appear in the output to be suspected. Kathryn, Luca, please accept my humble apology - it was not you.                       |||
|||                                                                                                                                            |||
**************************************************************************************************************************************************

Following is the record of my confused effort to someone that I thought didn't exist - I was mistaken...

-- All people in database who made calls < 60, on July 28, 2021
*/
                        SELECT name
                        FROM people p
                        JOIN phone_calls ON p.phone_number IN (caller, receiver)
                        Where duration < 60
                                AND year = 2021
                                AND month = 7
                                AND day = 28
                        ORDER BY name;

                        /*
                        +------------+
                        |    name    |
                        +------------+
                        | Anna       |
                        | Benista    |
                        | Bruce      |
                        | Carina     |
                        | Diana      |
                        | Doris      |
                        | Jack       |
                        | Jacqueline |
                        | James      |
                        | Kelsey     |
                        | Kelsey     |
                        | Kenny      |
                        | Larry      |
                        | Melissa    |
                        | Philip     |
                        | Robin      |
                        | Sofia      |
                        | Taylor     |
                        +------------+

-- All the people:
    - who made calls < 60 on July 28, 2021
    - on flight 36 the morning of July 29, 2021
    - from bakery_security_logs.exit within 10 minutes of the theft, and finally
    - who withdrew from the Leggett Street ATM the morning of the duck-napping

*/
                        SELECT DISTINCT p.name -- *
                        -- people who made phone calls of less than 1-minute (60-seconds)
                        FROM people p
                        JOIN phone_calls ON p.phone_number = caller
                        Where duration < 60
                                AND year = 2021
                                AND month = 7
                                AND day = 28
                                AND passport_number IN
                                -- people (by pp#) who took the first flight out of Fiftyville on July 28, 2021
                                (
                                                SELECT passport_number
                                                FROM people
                                                WHERE passport_number IN
                                                (
                                                        SELECT passport_number
                                                        FROM passengers
                                                        WHERE flight_id =
                                                        (
                                                            SELECT id
                                                            FROM flights
                                                            WHERE
                                                                year = 2021
                                                                AND month = 7
                                                                AND day = 29
                                                                AND hour < 12
                                                                AND origin_airport_id = (
                                                                    SELECT id
                                                                    FROM airports
                                                                    WHERE city = 'Fiftyville'
                                                                )
                                                            ORDER BY hour
                                                            LIMIT 1
                                                        )
                                                )
                                AND passport_number IN
                                -- people exiting the bakery within 10-minutes of the crime
                                (
                                        SELECT passport_number
                                        FROM people
                                        WHERE license_plate IN
                                        (
                                            SELECT license_plate
                                            FROM bakery_security_logs
                                            WHERE
                                                year = 2021
                                                AND month = 7
                                                AND day = 28
                                                AND hour = 10
                                                AND minute < 25
                                                AND activity = 'exit'
                                        )
                                )
                                AND passport_number IN
                                -- people who made withdrawals from Leggett Street ATM on July 28, 2021
                                (
                                    SELECT passport_number
                                    FROM people p
                                    JOIN bank_accounts acct ON p.id = acct.person_id
                                    WHERE acct.account_number IN
                                    (
                                        SELECT account_number
                                        FROM atm_transactions
                                        WHERE
                                            year = 2021
                                            AND month = 7
                                            AND day = 28
                                            AND atm_location = 'Leggett Street'
                                            AND transaction_type = 'withdraw'
                                    )
                                )
                    )
                    ;
/*

+-------+
| name  |
+-------+
| Bruce |
+-------+

-- It was Bruce, but you never know, he may have had a good reason... I mean he may have just needed some help - I know how that is...
+--------+-------+----------------+-----------------+---------------+-----+----------------+----------------+------+-------+-----+----------+
|   id   | name  |  phone_number  | passport_number | license_plate | id  |     caller     |    receiver    | year | month | day | duration |
+--------+-------+----------------+-----------------+---------------+-----+----------------+----------------+------+-------+-----+----------+
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
+--------+-------+----------------+-----------------+---------------+-----+----------------+----------------+------+-------+-----+----------+

-- There's more work to do to find the accomplice, but fist (I owe it to Luca and Kat), let's just reflect on how amazingly close I came to the
    simplest form of the answer, long ago, way up there ^ (copied from starting line: 509, then amended):
*/
                SELECT *
                FROM people p
                JOIN passengers psrs ON p.passport_number = psrs.passport_number
                            AND psrs.flight_id =
                            (
                                                SELECT id
                                                FROM flights
                                                WHERE
                                                    year = 2021
                                                    AND month = 7
                                                    AND day = 29
                                                    AND hour < 12
                                                    AND origin_airport_id =
                                                    (
                                                        SELECT id
                                                        FROM airports
                                                        WHERE city = 'Fiftyville'
                                                    )
                                                ORDER BY hour
                                                LIMIT 1
                            )
                JOIN phone_calls calls ON p.phone_number = calls.caller
                            AND calls.year = 2021
                            AND calls.month = 7
                            AND calls.day = 28
                            AND calls.duration < 60
                JOIN bakery_security_logs bake ON p.license_plate = bake.license_plate
                            AND bake.year = 2021
                            AND bake.month = 7
                            AND bake.day = 28
                            AND bake.hour = 10
                            AND bake.minute < 25
                            AND bake.activity = 'exit'
                -- above this point is how close I had gotten to the most beautiful, simplest form of the solution
                JOIN bank_accounts bank ON p.id = bank.person_id
                JOIN atm_transactions atm ON bank.account_number = atm.account_number
                            AND atm.year = 2021
                            AND atm.month = 7
                            AND atm.day = 28
                            AND atm.atm_location = 'Leggett Street'
                ; -- revisited below

-- And how did he call??
    SELECT *
    FROM people
    WHERE phone_number = '(375) 555-8161';
/*
**********************************************************************************
****  ACCOMPLICE  ****************************************************************
****--------------****************************************************************
***   +--------+-------+----------------+-----------------+---------------+    ***
***   |   id   | name  |  phone_number  | passport_number | license_plate |    ***
***   +--------+-------+----------------+-----------------+---------------+    ***
***   | 864400 | Robin | (375) 555-8161 | NULL            | 4V16VO0       |    ***
***   +--------+-------+----------------+-----------------+---------------+    ***
****                                                                         *****
**********************************************************************************
**********************************************************************************


IT WAS ROBIN!!! That BITCH!


\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
******* ONE QUERY TO RULE THEM ALL! *******
///////////////////////////////////////////

*/
    SELECT t.name AS THIEF, peeps.name AS ACCOMPLICE, t.city AS CITY
    FROM
    (
        SELECT p.name, calls.receiver, a.city
        FROM people p
        JOIN passengers psrs ON p.passport_number = psrs.passport_number
                    AND psrs.flight_id =
                    (
                        SELECT id
                        FROM flights
                        WHERE
                            year = 2021
                            AND month = 7
                            AND day = 29
                            AND hour < 12
                            AND origin_airport_id =
                            (
                                SELECT id
                                FROM airports
                                WHERE city = 'Fiftyville'
                            )
                        ORDER BY hour
                        LIMIT 1
                    )
        JOIN airports a ON f.destination_airport_id = a.id
        JOIN flights f ON psrs.flight_id = f.id
        JOIN phone_calls calls ON p.phone_number = calls.caller
                    AND calls.year = 2021
                    AND calls.month = 7
                    AND calls.day = 28
                    AND calls.duration < 60
        JOIN bakery_security_logs bake ON p.license_plate = bake.license_plate
                    AND bake.year = 2021
                    AND bake.month = 7
                    AND bake.day = 28
                    AND bake.hour = 10
                    AND bake.minute < 25
                    AND bake.activity = 'exit'
        -- above this point of the subquery is how close I had gotten to the most beautifully,
        -- simple form of the solution
        JOIN bank_accounts bank ON p.id = bank.person_id
        JOIN atm_transactions atm ON bank.account_number = atm.account_number
                    AND atm.year = 2021
                    AND atm.month = 7
                    AND atm.day = 28
                    AND atm.atm_location = 'Leggett Street'
    ) AS t
    JOIN people peeps ON t.receiver = peeps.phone_number
    ;

/*
***** Only the ANSWER *****

+-------+------------+---------------+
| THIEF | ACCOMPLICE |     CITY      |
+-------+------------+---------------+
| Bruce | Robin      | New York City |
+-------+------------+---------------+
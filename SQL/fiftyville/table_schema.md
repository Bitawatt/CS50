# TABLE .schema

## tables

    .tables
        airports              crime_scene_reports   people
        atm_transactions      flights               phone_calls
        bakery_security_logs  interviews
        bank_accounts         passengers

## table schemas

| Table Name | Column Name and Data Type | Constraints |
| --- | --- | --- |
| crime_scene_reports | id INTEGER | PRIMARY KEY(id) |
| | year INTEGER | |
| | month INTEGER | |
| | day INTEGER | |
| | street TEXT | |
| | description TEXT | |
| interviews | id INTEGER | PRIMARY KEY(id) |
| | name TEXT | |
| | year INTEGER | |
| | month INTEGER | |
| | day INTEGER | |
| | transcript TEXT | |
| atm_transactions | id INTEGER | PRIMARY KEY(id) |
| | account_number INTEGER | |
| | year INTEGER | |
| | month INTEGER | |
| | day INTEGER | |
| | atm_location TEXT | |
| | transaction_type TEXT | |
| | amount INTEGER | |
| bank_accounts | account_number INTEGER | |
| | person_id INTEGER | FOREIGN KEY(person_id) REFERENCES people(id) |
| | creation_year INTEGER | |
| airports | id INTEGER | PRIMARY KEY(id) |
| | abbreviation TEXT | |
| | full_name TEXT | |
| | city TEXT | |
| flights | id INTEGER | PRIMARY KEY(id) |
| | origin_airport_id INTEGER | FOREIGN KEY(origin_airport_id) REFERENCES airports(id) |
| | destination_airport_id INTEGER | FOREIGN KEY(destination_airport_id) REFERENCES airports(id) |
| | year INTEGER | |
| | month INTEGER | |
| | day INTEGER | |
| | hour INTEGER | |
| | minute INTEGER | |
| passengers | flight_id INTEGER | FOREIGN KEY(flight_id) REFERENCES flights(id) |
| | passport_number INTEGER | |
| | seat TEXT | |
| phone_calls | id INTEGER | PRIMARY KEY(id) |
| | caller TEXT | |
| | receiver TEXT | |
| | year INTEGER | |
| | month INTEGER | |
| | day INTEGER | |
| | duration INTEGER | |
| people | id INTEGER | PRIMARY KEY(id) |
| | name TEXT | |
| | phone_number TEXT | |
| | passport_number INTEGER | |
| | license_plate TEXT | |
| bakery_security_logs | id INTEGER | PRIMARY KEY(id) |
| | year INTEGER | |
| | month INTEGER | |
| | day INTEGER | |
| | hour INTEGER | |
| | minute INTEGER | |
| | activity TEXT | |
| | license_plate TEXT | |
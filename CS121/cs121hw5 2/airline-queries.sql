-- [Problem 6a]
WITH purchases_made (purchase_ID, timestamp) AS (
  SELECT purchase_ID, timestamp
  FROM purchase
  WHERE cust_ID = 54321
  ),
  personal_info (first_name, last_name) AS (
    SELECT first_name, last_name
    FROM customer
    WHERE cust_ID = 54321
  ),
  ticket_ids (ticket_ID, timestamp, cust_ID) AS (
    SELECT ticket_ID, timestamp, cust_ID
    FROM purchases_made NATURAL JOIN ticket
  ),
  ticket_ids_names (ticket_ID, timestamp, first_name, last_name) AS (
    SELECT ticket_ID, timestamp, first_name, last_name
    FROM ticket_ids NATURAL JOIN customer
  )
  SELECT timestamp, date, first_name, last_name
  FROM ticket_ids_names NATURAL JOIN ticket_unique NATURAL JOIN flight
  GROUP BY timestamp DESC, date ASC, first_name ASC, last_name ASC;


-- [Problem 6b]
WITH last_weeks_vals AS (
  SELECT type_code, SUM(sale_price) AS total_revenue
  FROM ticket NATURAL JOIN ticket_unique
  WHERE date > CURRENT_DATE() - INTERVAL 2 WEEK
  GROUP BY type_code)
SELECT type_code, SUM(total_revenue) AS total_revenue
  FROM last_weeks_vals NATURAL RIGHT JOIN airplane
  GROUP BY type_code;


-- [Problem 6c]
WITH international_travelers AS (
  SELECT cust_ID
  FROM flight NATURAL JOIN ticket_unique NATURAL JOIN ticket
  WHERE domestic = FALSE
  ),
  incomp_info AS (
    SELECT cust_ID
    FROM traveler
    WHERE ISNULL(passport_number) OR ISNULL(country_of_citizenship) OR 
                  ISNULL(emergency_contact) OR ISNULL(emerg_phone_number)
  )
SELECT *
FROM customer
WHERE cust_ID IN (SELECT * FROM international_travelers) AND
			   cust_ID IN (SELECT * FROM incomp_info);



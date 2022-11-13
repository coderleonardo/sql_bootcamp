-- TIMESTAMP, TIMEZONE, NOW, TIMEOFDAY, CURRENT_TIME, CURRENT_DATE
SHOW ALL;
SHOW TIMEZONE;

SELECT NOW();

SELECT TIMEOFDAY();
SELECT CURRENT_TIME;
SELECT CURRENT_DATE;

-- EXTRACT, AGE, TO_CHAR
SELECT 
	EXTRACT(YEAR FROM payment_date),
	EXTRACT(MONTH FROM payment_date), 
	AGE(payment_date),
	TO_CHAR(payment_date, 'DD-MONTH-YYYY'),
	TO_CHAR(payment_date, 'dd/mon/YY'), 
	TO_CHAR(payment_date, 'dd-MM-YYYY')
FROM payment;

-- visit: https://www.postgresql.org/docs/
-- visit: https://www.postgresql.org/docs/12/functions-formatting.html

-- Mathematical Functions
SELECT * FROM film;

SELECT ROUND(rental_rate/replacement_cost, 2)*100 AS percent_cost
FROM film;

SELECT ROUND(replacement_cost, 2)*0.1 FROM film;

-- STRINGS
SELECT * FROM customer LIMIT 5;

SELECT LENGTH(first_name) FROM customer; 
SELECT 
	(UPPER(first_name) || ' ' || UPPER(last_name)) AS full_name,
	LOWER(LEFT(first_name, 1)) || LOWER(last_name) || '@gmail.com' AS email
FROM customer;

-- SUBQUERYS
-- 	SELECT columns_name FROM table_name
-- 	WHERE EXISTS
-- 	(SELECT columns_name FROM table_name WHERE condition);

SELECT title, rental_rate FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

SELECT film_id, title FROM film
WHERE film_id IN 
	(SELECT inventory.film_id
	FROM rental
	INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY film_id;

SELECT first_name, last_name 
FROM customer AS c
WHERE EXISTS
	(SELECT * FROM payment AS p
	WHERE p.customer_id = c.customer_id
	AND amount > 11);
	
SELECT first_name, last_name 
FROM customer AS c
WHERE NOT EXISTS
	(SELECT * FROM payment AS p
	WHERE p.customer_id = c.customer_id
	AND amount > 11);
	
-- SELF JOIN
-- SELECT A.col, B.col
-- FROM table AS A 
-- JOIN table AS B ON
-- A.som_col = B.other_col;

SELECT f1.title, f2.title, f1.length 
FROM film AS f1
INNER JOIN film AS f2 ON
f1.film_id != f2.film_id AND
f1.length = f2.length;
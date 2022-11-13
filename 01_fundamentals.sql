--- SELECT column1, column2, ..., columnN FROM table_name;

-- select all columns from table actor
SELECT * FROM actor;
-- select specific columns from the table actor
SELECT last_name, first_name FROM actor;

SELECT first_name, last_name, email FROM customer;

-- SELECT DISTINCT(column) FROM table;
-- SELECT DISTINCT column1, column2, ..., columnN FROM table;
SELECT * FROM film limit 5;

SELECT DISTINCT release_year FROM film;
SELECT DISTINCT (release_year) FROM film;
SELECT DISTINCT (rental_rate) FROM film;

SELECT DISTINCT rating FROM film;

-- COUNT: return the number of rows
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM payment;
SELECT COUNT(amount) FROM payment;
SELECT COUNT(DISTINCT rating) FROM film;
SELECT COUNT(DISTINCT amount) FROM payment;

-- SELECT column FROM table WHERE conditions;
SELECT * FROM customer 
WHERE first_name = 'Jared';

SELECT * FROM film
WHERE 
	rental_rate > 4 AND 
	replacement_cost >= 19.99;
	
SELECT COUNT(title) FROM film
WHERE 
	rental_rate > 4 AND 
	replacement_cost >= 19.99 AND 
	rating != 'R';
	
SELECT COUNT(DISTINCT first_name) FROM customer 
WHERE first_name = 'Jared';

--
SELECT email FROM customer 
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

SELECT description FROM film WHERE title = 'Outlaw Hanky';

SELECT phone FROM address WHERE address = '259 Ipoh Drive';

-- ORDER BY
-- SELECT column1, column2 FROM table ORDER BY column1 ASC/DESC;]

SELECT * FROM customer ORDER BY last_name; -- ASC
SELECT * FROM customer ORDER BY last_name DESC; 

SELECT store_id, first_name, last_name 
FROM customer ORDER BY store_id ASC, first_name DESC; 

-- LIMIT (the number of row that a query returns)
SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date LIMIT 5;

--
SELECT * FROM payment LIMIT 1;
SELECT customer_id, payment_date FROM payment 
ORDER BY payment_date ASC LIMIT 10;

SELECT * FROM film LIMIT 1;
SELECT title, length FROM film 
ORDER BY length ASC LIMIT 10;

SELECT COUNT(title) FROM film 
WHERE length <= 50;

-- BETWEEN low_value AND high_value
-- NOT BETWEEN low_value AND high_value
-- ISO 8601: YYYY-MM-DD

SELECT * FROM payment LIMIT 2;
SELECT COUNT(*) FROM payment 
WHERE amount BETWEEN 8 AND 9;
SELECT COUNT(*) FROM payment 
WHERE amount NOT BETWEEN 8 AND 9;
SELECT COUNT(*) FROM payment -- be careful
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

-- value IN (option1, ..., optionN)
SELECT * FROM payment 
WHERE amount IN (0.99, 1.98, 1.99);

SELECT COUNT(*) FROM payment 
WHERE amount NOT IN (0.99, 1.98, 1.99);

-- LIKE (case sensitive) and ILIKE (case insensitive)
-- PostgreSQL does support full regex capabilities
SELECT COUNT(*) FROM customer 
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';
SELECT * FROM customer 
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

SELECT * FROM customer 
WHERE first_name ILIKE 'j%' AND last_name ILIKE 'S%';

SELECT * FROM customer 
WHERE first_name ILIKE '%er%';

SELECT * FROM customer 
WHERE first_name ILIKE '_er%';

SELECT * FROM customer 
WHERE first_name NOT ILIKE '_er%';

-- General challenge


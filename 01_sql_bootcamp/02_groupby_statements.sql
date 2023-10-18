-- AVG, MIN, MAX, COUNT
SELECT MIN(replacement_cost), MAX(replacement_cost)
FROM film;

SELECT ROUND(AVG(replacement_cost), 4)
FROM film;

SELECT SUM(replacement_cost)
FROM film;

-- GROUP BY: group by some categorical value
	-- SELECT category, AGG(data_col) 
	-- FROM table_
	-- WHERE category condition
	-- GROUP BY category
	-- ORDER BY AGG(data_col);
	
SELECT * FROM payment;

SELECT customer_id, SUM(amount), COUNT(amount) FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY customer_id;

SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount);

--
SELECT * FROM payment LIMIT 3;
SELECT staff_id, COUNT(amount) FROM payment 
GROUP BY staff_id 
ORDER BY COUNT(amount) ASC; 

SELECT * FROM film LIMIT 3;
SELECT rating, AVG(replacement_cost) FROM film
GROUP BY rating 
ORDER BY AVG(replacement_cost) ASC;

SELECT customer_id, SUM(amount) FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC LIMIT 5;

-- HAVING (filter based on the AGG function)
	-- SELECT ... FROM ...
	-- WHERE ...
	-- GROUP BY ...
	-- HAVING AGG(...) condition;
	
SELECT customer_id, SUM(amount) FROM payment
WHERE customer_id Not IN (184, 87, 477)
GROUP BY customer_id
HAVING SUM(amount) > 100;

--
SELECT customer_id, COUNT(*) FROM payment
GROUP BY customer_id 
HAVING COUNT(*) >= 40;

SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100;

--
SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110;

SELECT * FROM film LIMIT 3;
SELECT COUNT(*) FROM film 
WHERE title LIKE 'J%';

SELECT * FROM customer;
SELECT first_name, last_name FROM customer
WHERE 
	first_name LIKE 'E%e' AND
	address_id < 500
ORDER BY customer_id DESC LIMIT 1;

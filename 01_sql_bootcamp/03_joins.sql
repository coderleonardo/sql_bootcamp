-- AS (Alias)
-- SELECT columns AS new_name FROM table
SELECT amount AS rental_price 
FROM payment;

SELECT SUM(amount) AS net_revenue 
FROM payment;

SELECT COUNT(amount) AS num_transactions FROM payment;
SELECT customer_id, SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT customer_id, amount
FROM payment 
WHERE amount > 2;

-- JOINS

-- INNER JOIN
-- SELECT * FROM tableA
-- INNER JOIN tableB
-- ON tableA.col_match = tableB.col_match;
SELECT 
	payment_id,  
	payment.customer_id, 
	first_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- FULL OUTER JOIN
-- SELECT * FROM tableA
-- FULL OUTER JOIN tableB
-- ON tableA.col_match = tableB.col_match;

-- SELECT * FROM tableA
-- FULL OUTER JOIN tableB
-- ON tableA.col_match = tableB.col_match
-- WHERE tableA.id IS null OR tableB.id IS null;

SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null OR 
	payment.payment_id IS null;
	
SELECT COUNT(DISTINCT customer_id) FROM payment;
SELECT COUNT(DISTINCT customer_id) FROM customer;

-- LEFT OUTER JOIN
-- SELECT * FROM tableA
-- LEFT OUTER JOIN tableB
-- ON tableA.col_match = tableB.col_match;

SELECT film.film_id, film.title, inventory_id
FROM film
LEFT JOIN inventory ON
inventory.film_id = film.film_id;

-- SELECT * FROM tableA
-- LEFT OUTER JOIN tableB
-- ON tableA.col_match = tableB.col_match
-- WHERE tableB.id IS null;

SELECT film.film_id, film.title, inventory_id
FROM film
LEFT JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id IS null;

-- RIGHT OUTER JOIN
-- SELECT * FROM tableA
-- RIGHT OUTER JOIN tableB
-- ON tableA.col_match = tableB.col_match
-- WHERE tableB.id IS null;

-- UNION
-- SELECT column_name FROM table1
-- UNION 
-- SELECT column_name FROM table2;

-- 
SELECT address.district, customer.email
FROM customer
LEFT JOIN address 
ON customer.address_id = address.address_id
WHERE address.district = 'California';

SELECT film.title, actor.first_name, actor.last_name FROM film 
LEFT JOIN film_actor
ON film_actor.film_id = film.film_id
LEFT JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg';

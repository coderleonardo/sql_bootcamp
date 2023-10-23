-- 02. SUBQUERIES and Common Table Expressions (CTEs)

--- Subqueries in FROM statements
SELECT * FROM (
		SELECT * FROM general_hospital.patients
		WHERE date_of_birth >= '2000-01-01'
			ORDER BY master_patient_id) p
	WHERE p.name ILIKE 'm%';
	
SELECT se.* 
	FROM
		(SELECT * FROM general_hospital.surgical_encounters
			WHERE surgical_admission_date
				BETWEEN '2016-11-01' AND '2016-11-30') se
	INNER JOIN
		(SELECT master_patient_id 
			FROM general_hospital.patients
				WHERE date_of_birth >= '1990-01-01') p
	ON se.master_patient_id = p.master_patient_id;
	
--- Common Table Expressions (CTEs)	
	-- (create tables that only exist for a single query)
	-- WITH table_name/alias AS (SELECT ... ): intermediate table
WITH young_patients AS (
		SELECT * FROM general_hospital.patients
		WHERE date_of_birth >= '2000-01-01')
SELECT * FROM young_patients WHERE name ILIKE 'm%';

WITH top_counties AS (
	SELECT	
		county, 
		COUNT(*) AS num_patients
	FROM general_hospital.patients
	GROUP BY county
	HAVING COUNT(*) > 1500
	), 
	county_patients AS (
		SELECT 
			p.master_patient_id, 
			p.county
		FROM general_hospital.patients p
		INNER JOIN top_counties t
			ON p.county = t.county)
SELECT 
	p.county, 
	COUNT(s.surgery_id) AS num_surgeries
FROM general_hospital.surgical_encounters s
INNER JOIN county_patients p 
	ON s.master_patient_id = p.master_patient_id
GROUP BY p.county;

-- Subqueries for comparisons
WITH total_cost AS (
	SELECT 
		surgery_id, 
		ROUND(SUM(resource_cost), 3) AS total_surgery_cost
	FROM general_hospital.surgical_costs
		GROUP BY surgery_id)
SELECT * FROM total_cost
	WHERE total_surgery_cost > (
		SELECT AVG(total_surgery_cost)
		FROM total_cost)
	ORDER BY total_surgery_cost ASC;
	
SELECT * FROM general_hospital.vitals
	WHERE 
		bp_diastolic > (SELECT MIN(bp_diastolic) 
						FROM general_hospital.vitals)
		AND 
		bp_systolic < (SELECT MAX(bp_systolic) 
						FROM general_hospital.vitals);
						
-- Subqueries with IN and NOT statements
WITH m_patients_1 AS (
SELECT * FROM general_hospital.patients 
	WHERE master_patient_id IN (
		SELECT DISTINCT master_patient_id 
			FROM general_hospital.surgical_encounters)
	)
SELECT COUNT(*) FROM m_patients_1;

WITH m_patients_2 AS (
SELECT DISTINCT p.master_patient_id
	FROM general_hospital.patients p
	INNER JOIN general_hospital.surgical_encounters se
		ON p.master_patient_id = se.master_patient_id
	ORDER BY p.master_patient_id
	)
SELECT COUNT(*) FROM m_patients_2;

-- Subqueries with ANY and ALL

SELECT
	unit_name, 
	STRING_AGG(DISTINCT surgical_type, ',') AS cases_types
FROM general_hospital.surgical_encounters
	GROUP BY unit_name
HAVING STRING_AGG(DISTINCT surgical_type, ',') LIKE 
	ALL(
		SELECT STRING_AGG(DISTINCT surgical_type, ',')
			FROM general_hospital.surgical_encounters);
			
-- Subqueries with EXISTS
--- The query below selects all the records of p that are common to the 
--- records of s
SELECT p.*
FROM general_hospital.patients p
	WHERE EXISTS (
		SELECT 1
		FROM general_hospital.surgical_encounters s
			WHERE s.master_patient_id = p.master_patient_id);
			
-- Recursive CTEs (WITH clauses)
WITH RECURSIVE orders as (
	-- Base query
	SELECT 
		order_procedure_id, 
		order_parent_order_id, 
		0 as level
	FROM general_hospital.orders_procedures
	WHERE order_parent_order_id is NULL
		UNION ALL
	-- Recursive query
	SELECT 
		op.order_procedure_id, 
		op.order_parent_order_id, 
		o.level + 1 as level
	FROM general_hospital.orders_procedures op
	INNER JOIN orders o
		ON op.order_parent_order_id = o.order_procedure_id)
SELECT * FROM orders WHERE level != 0;
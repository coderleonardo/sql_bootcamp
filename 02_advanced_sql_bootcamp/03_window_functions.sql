-- Window Functions

--- OVER, PARTITION BY and ORDER BY
	-- (Window functions , ex. rank, requires an OVER clause)
	-- (Not allowed in WHERE, HAVING or GROUP BY clauses)
	-- SELECT 
	-- 	col1, 
	-- 	col2, 
	-- 	AVG(col2) OVER (
	-- 		PARTITION BY col1 ORDER BY col1) AS window_avg
	-- FROM table1
	-- 	WHERE ...

WITH surgical_los AS (
	SELECT 
		surgery_id, 
		(surgical_discharge_date - surgical_admission_date) AS los, 
		AVG(surgical_discharge_date - surgical_admission_date)
			OVER () AS avg_los
	FROM general_hospital.surgical_encounters
	)
SELECT 
	*, 
	ROUND(los - avg_los, 2) AS over_under
FROM surgical_los;

SELECT 
	account_id, 
	primary_icd, 
	total_account_balance, 
	RANK ()
		OVER (PARTITION BY primary_icd
			  ORDER BY total_account_balance DESC
			  )
		AS account_rank_by_icd
FROM general_hospital.accounts;

-- WINDOW and Window functions 
SELECT 
	s.surgery_id, 
	p.full_name, 
	s.total_profit, 
	AVG(total_profit) OVER w AS avg_total_profit, 
	s.total_cost, 
	SUM(total_cost) OVER w AS total_surgeon_cost
FROM general_hospital.surgical_encounters s
LEFT OUTER JOIN general_hospital.physicians p
	ON s.surgeon_id = p.id
WINDOW w AS (PARTITION BY s.surgeon_id);
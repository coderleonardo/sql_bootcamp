-- UNION
	-- Duplicated values are removed unless UNION ALL is used
SELECT 
	surgery_id
FROM general_hospital.surgical_encounters
UNION 
SELECT 
	surgery_id
FROM general_hospital.surgical_costs
ORDER BY surgery_id;

SELECT 
	surgery_id
FROM general_hospital.surgical_encounters
UNION ALL
SELECT 
	surgery_id
FROM general_hospital.surgical_costs
ORDER BY surgery_id;

-- INTERSECT: return records that exist in both tables
	-- Duplicated values are removed unless INTERSECT ALL is used
SELECT 
	surgery_id
FROM general_hospital.surgical_encounters
INTERSECT
SELECT 
	surgery_id
FROM general_hospital.surgical_costs
ORDER BY surgery_id;

-- EXCEPT: returns rows that are in the 1st query but not in the 2nd query
	-- Duplicated values are removed unless EXCEPT ALL is used
SELECT 
	surgery_id
FROM general_hospital.surgical_costs
EXCEPT
SELECT 
	surgery_id
FROM general_hospital.surgical_encounters
ORDER BY surgery_id;
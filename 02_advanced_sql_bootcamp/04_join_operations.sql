-- SELF JOIN
SELECT 
	o1.order_procedure_id, 
	o1.order_procedure_description, 
	o1.order_parent_order_id, 
	o2.order_procedure_description
FROM general_hospital.orders_procedures o1
INNER JOIN general_hospital.orders_procedures o2
	ON o1.order_parent_order_id = o2.order_parent_order_id;
	
-- CROSS JOIN (Cartesian product of the data)
SELECT 
	h.hospital_name, 
	d.department_name
FROM general_hospital.hospitals h
CROSS JOIN general_hospital.departments d;

-- FULL JOIN
	-- A combination of LEFT and RIGHT JOIN
	-- Return records that are in both tables, table 1 but not 2, table 2 but not 1
SELECT 
	d.department_id, 
	d.department_name
FROM general_hospital.departments d
FULL JOIN general_hospital.hospitals h
	ON d.hospital_id = h.hospital_id
WHERE h.hospital_id IS NULL;

-- USING Keyword and Natural JOINs (INNER by default)
	-- USING** is explicit and Natural JOIN is implicit
	-- **: better use USING over Natural for better performance
SELECT 
	h.hospital_name, 
	d.department_name
FROM general_hospital.departments d
INNER JOIN general_hospital.hospitals h
	USING (hospital_id);

SELECT 
	h.hospital_name, 
	d.department_name
FROM general_hospital.departments d
NATURAL JOIN general_hospital.hospitals h; -- Do not use this

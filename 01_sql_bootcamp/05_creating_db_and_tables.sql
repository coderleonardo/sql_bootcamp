-- CREATE TABLE: Simple query
CREATE TABLE account (
	user_id SERIAL PRIMARY KEY, 
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL, 
	email VARCHAR(250) UNIQUE NOT NULL, 
	created_on TIMESTAMP NOT NULL, 
	last_login TIMESTAMP 
);

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY, 
	job_name VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id), 
	job_id INTEGER REFERENCES job(job_id),
	hired_date TIMESTAMP
);

-- INSERT 
SELECT * FROM account;

INSERT INTO account(username, password, email, created_on)
VALUES 
	('Leonardo', 'password', 'leo@mail.com', CURRENT_TIMESTAMP)

INSERT INTO job(job_name)
VALUES
	('Business Analyst')
	
SELECT * FROM job;

INSERT INTO job(job_name)
VALUES
	('President')
	
INSERT INTO account_job(user_id, job_id, hired_date)
VALUES
	(1, 1, CURRENT_TIMESTAMP)
	
SELECT * FROM account_job;

-- UPDATE
SELECT * FROM account;

UPDATE account
SET last_login = CURRENT_TIMESTAMP

UPDATE account
SET last_login = created_on

UPDATE account_job
SET hired_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id

SELECT * FROM account_job;

UPDATE account 
SET last_login = CURRENT_TIMESTAMP 
RETURNING email, created_on, last_login

-- DELETE
SELECT * FROM job;

INSERT INTO job(job_name)
VALUES 
	('Cowboy')
	
DELETE FROM job 
WHERE job_name = 'Cowboy'
RETURNING job_id, job_name

-- ALTER TABLE table
CREATE TABLE infomation(
	info_id SERIAL PRIMARY KEY, 
	title VARCHAR(500) NOT NULL, 
	person VARCHAR(50) NOT NULL UNIQUE
);

ALTER TABLE infomation
RENAME TO new_info

ALTER TABLE new_info
RENAME COLUMN person TO people

ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL -- remove a constraint

INSERT INTO new_info(title)
VALUES 
	('some new title')
	
SELECT * FROM new_info;

-- ALTER TABLE table_name DROP COLUMN IF EXISTS col_name
ALTER TABLE new_info
DROP COLUMN IF EXISTS people
 
-- CHECK constraints
CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY, 
	first_name VARCHAR(50) NOT NULL, 
	last_name VARCHAR(50) NOT NULL, 
	birthdate DATE CHECK (birthdate > '1900-01-01'), 
	hire_date DATE CHECK (hire_date > birthdate), 
	salary INTEGER CHECK (salary > 0)
);

INSERT INTO employees(
	first_name, 
	last_name, 
	birthdate, 
	hire_date, 
	salary
) 
VALUES 
	('Leonardo', 'Cesar', '1899-11-03', '2010-01-01', 100)

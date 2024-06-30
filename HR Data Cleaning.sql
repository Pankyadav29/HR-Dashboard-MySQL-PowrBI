CREATE DATABASE HR_PROJECT;

USE hr_project;

create table hr
(
  id varchar(20),
  first_name text,
  last_name text,
  birthdate text,
  gender text,
  race text,
  department text,
  jobtitle text,
  location text,
  hire_date text,
  termdate text,
  location_city text,
  location_state text
);

-- Loading dataset 

LOAD DATA INFILE 'C:/Human Resources.csv' INTO TABLE hr 
FIELDS TERMINATED BY ','
IGNORE 1 LINES; 

SELECT * from hr;

ALTER TABLE hr 
CHANGE COLUMN id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr 
SET birthdate = CASE
WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr 
MODIFY COLUMN birthdate DATE;

UPDATE hr 
SET hire_date = CASE
WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr 
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;

UPDATE hr 
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr 
MODIFY COLUMN termdate DATE;

ALTER TABLE hr 
ADD COLUMN age INT;

UPDATE hr 
SET age = timestampdiff(YEAR, birthdate, curdate());

SELECT birthdate, age FROM hr;

SELECT
	min(age) AS youngest, 
    max(age) AS oldest 
FROM hr;

SELECT count(*) FROM hr 
WHERE age < 18;

SELECT count(*) FROM hr WHERE termdate > curdate();

SELECT count(*)
FROM hr 
WHERE termdate = '';

SELECT location 
FROM hr;
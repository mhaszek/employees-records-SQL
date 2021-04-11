-- Drop tables if exist
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;

-- Create new tables to import data
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);

CREATE TABLE titles (
	title_id VARCHAR NOT NULL PRIMARY KEY,
	title VARCHAR NOT NULL
);

-- In this table dates are imported as strings, beacuse american date formatting in the csv file throws an error 
-- during import when trying to import as date. They can be changed back to dates when querying by running 
-- "to_date(birth_date, 'MM DD YYYY')".
-- Alternatively this issue can be solved by manually changing the date format in excel prior to import. 
-- Another option is to change the database datestyle with 'ALTER SYSTEM SET datestyle to "ISO, MDY"', however 
-- according to stackoverflow this can create further issues with the database: "If at all possible, don't use 
-- DATESTYLE. It'll affect all code in your session, including things like stored procedures that might not be 
-- expecting it and might not have set an explicit overriding DATESTYLE in their definitions" by: 
-- (https://stackoverflow.com/questions/13244460/how-to-change-datestyle-in-postgresql).
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,	
	emp_title_id VARCHAR NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date VARCHAR NOT NULL,	
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,	
	hire_date VARCHAR NOT NULL
);

CREATE TABLE salaries (
	emp_no INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Import data and view the tables
SELECT * FROM departments LIMIT 10;
SELECT * FROM titles LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;

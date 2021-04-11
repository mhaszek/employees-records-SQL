-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no AS "employee number", e.last_name AS "last name", e.first_name AS "first name", e.sex, s.salary
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no
ORDER BY "employee number";

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees 
WHERE hire_date LIKE '%1986';

-- 2. Alternative solution using date.
SELECT first_name, last_name, hire_date
FROM employees 
WHERE to_date(hire_date, 'MM DD YYYY') BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY to_date(hire_date, 'MM DD YYYY');

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments d
LEFT JOIN dept_manager dm
ON dm.dept_no = d.dept_no
LEFT JOIN employees e
ON dm.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS count_of_last_name
FROM employees
GROUP BY last_name
ORDER BY count_of_last_name DESC;

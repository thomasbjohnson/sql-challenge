--DROP TABLE department;
-- Create the table for department
CREATE TABLE department(
		dept_no VARCHAR(30) PRIMARY KEY,
		dept_name VARCHAR(30)
);

-- View the table columns and datatypes

SELECT * FROM department

-- Create the table for Department employees
-- DROP TABLE dept_emp
CREATE TABLE dept_emp(
		emp_no INT,
		dept_no VARCHAR(30)
);

-- View the table columns and datatypes

SELECT * FROM dept_emp

--Create the table for Department managers
--DROP TABLE dept_manager
CREATE TABLE dept_manager(
		dept_no VARCHAR(30),
		emp_no INT PRIMARY KEY
);

-- View the table columns and datatypes

SELECT * FROM dept_manager

-- Create the table for Employees
CREATE TABLE employees(
		emp_no SERIAL PRIMARY KEY,
		emp_title_id VARCHAR(30),
		birth_date DATE,
		first_name VARCHAR(30),
		last_name VARCHAR(30),
		sex VARCHAR(4),
		hire_date DATE
);

SELECT * FROM employees;

-- Create the table for Salaries
CREATE TABLE salaries(
		emp_no SERIAL PRIMARY KEY,
		salary INT
);

SELECT * FROM salaries;

-- DROP TABLE titles
-- Create the table for Job titles
CREATE TABLE titles(
		title_id VARCHAR PRIMARY KEY,
		title VARCHAR
);

SELECT * FROM titles;


--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no AS "Employee Number", 
	   e.last_name AS "Last Name", 
	   e.first_name AS "First Name", 
	   e.sex, s.salary AS "Salary"
FROM employees AS e
JOIN salaries as s ON
e.emp_no=s.emp_no;

--SELECT * FROM employees
--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name AS "First Name",
	   last_name AS "Last Name", 
	   hire_date AS "Hire Date"
FROM employees
WHERE date_part('year', hire_date)=1986;

--3. List the manager of each department with the following information: 
--	 department number, department name, the manager's employee number, last name, first name.

SELECT dm.dept_no AS "Department Number", d.dept_name AS "Department Name", e.emp_no AS "Employee Number",
	   e.last_name AS "Last Name", e.first_name AS "First Name"
FROM employees AS e
	JOIN dept_manager AS dm
	ON (dm.emp_no=e.emp_no)
		JOIN department AS d
			ON (dm.dept_no=d.dept_no);

--4. List the department of each employee with the following information: employee number, 
--	 last name, first name, and department name.
   
SELECT de.emp_no AS "Employee Number", e.last_name AS "Last Name", 
	   e.first_name AS "First Name", d.dept_name AS "Department Name"
FROM employees AS e
	JOIN dept_emp AS de
		ON (de.emp_no=e.emp_no)
			JOIN department AS d
				ON (d.dept_no=de.dept_no);
				
--5. List first name, last name, and sex for employees whose first name is "Hercules" 
--   and last names begin with "B."

--CREATE VIEW hercules_b AS
SELECT first_name AS "First Name", last_name AS "Last Name", sex AS Sex 
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
--(
--	SELECT * FROM hercules_b
--	WHERE "Last Name" LIKE 'B%'
--);

--6. List all employees in the Sales department, including their employee number, last name, 
--	 first name, and department name.

SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", 
	   e.first_name AS "First Name", d.dept_name AS "Department Name"
FROM employees AS e
	JOIN dept_emp AS de
		ON (e.emp_no=de.emp_no)
			JOIN department AS d
				ON (de.dept_no=d.dept_no)
				WHERE d.dept_name='Sales';

--7. List all employees in the Sales and Development departments, including their employee number, 
--	 last name, first name, and department name.

SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", 
	   e.first_name AS "First Name", d.dept_name AS "Department Name"
FROM employees AS e
	JOIN dept_emp AS de
		ON (e.emp_no=de.emp_no)
			JOIN department AS d
				ON (de.dept_no=d.dept_no)
				WHERE d.dept_name='Sales' OR d.dept_name='Development';
				
--8. In descending order, list the frequency count of employee last names, i.e., how many
--	 employees share each last name.

SELECT last_name AS "Last Name", COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;


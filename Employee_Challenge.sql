-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE employees (
	  emp_no INT NOT NULL,
	  birth_date DATE NOT NULL,
	  first_name VARCHAR NOT NULL,
	  last_name VARCHAR NOT NULL,
	  gender VARCHAR NOT NULL,
	  hire_date DATE NOT NULL,
--FOREIGN KEY (emp_no) REFERENCES titles (emp_no),
	  PRIMARY KEY (emp_no)
	  
);
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
   emp_no INT NOT NULL,
   dept_no VARCHAR(4) NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  	PRIMARY KEY (emp_no,dept_no)
);
CREATE TABLE titles (
   emp_no INT NOT NULL,
   title VARCHAR (50) NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no,title,from_date)
);
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  	PRIMARY KEY (emp_no)
);

SELECT emp_no, first_name, last_name, birth_date
INTO new_employees
FROM employees
ORDER BY emp_no

SELECT title, from_date, to_date
FROM titles

SELECT ne.emp_no,
       ne.first_name,
	   ne.last_name,
	   ne.birth_date,
	   ti.title,
	   ti.from_date,
	   ti.to_date
INTO retirement_titles
FROM new_employees as ne
LEFT JOIN titles as ti
ON ne.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM retirement_titles;
- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO retiring_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM Unique_Titles;
DROP TABle Unique_Titles;

SELECT title, COUNT(title) AS "new count"
INTO retire_title
FROM retiring_titles
GROUP BY title
ORDER BY "new count" DESC; 
SELECT * FROM retire_title

--Deliverable 2
SELECT e.emp_no,
       e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no;
SELECT * FROM mentorship_eligibility;
--USE distinct on
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, birth_date, from_date, to_date, title
INTO mentor_eligible
FROM mentorship_eligibility
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no, to_date DESC;

SELECT * FROM mentor_eligible;



use employees;

-- Change the “Business Analysis” department name to “Data Analysis”. --
UPDATE departments 
SET 
    dept_name = 'data Analysis'
WHERE
    dept_no IN ('d010');
    
-- check if it worked --
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

-- Remove the department number 10 record from the “departments” table. --
DELETE FROM departments 
WHERE
    dept_no IN ('d010');
    
-- check --
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question. --
SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997? --
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
-- ans = 31,909,143,195 --

/*1. Which is the highest employee number in the database?

2. Which is the lowest employee number in the database?
*/
-- 1 --
SELECT 
    MAX(emp_no)
FROM
    employees;
-- ans = 999903 --

-- 2 -- 
SELECT 
    MIN(emp_no)
FROM
    employees;
-- ans = 10001 --

-- What is the average annual salary paid to employees who started after the 1st of January 1997? --
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
-- ans = 67717.7450

/*Round the average amount of money spent on salaries for all contracts 
that started after the 1st of January 1997 to a precision of cents.
*/
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
-- ans = $67717.75 --

-- Allow null values is the department copy created earlier --
alter table departments_dup change column dep_name dept_name varchar(40) null;

-- add new departments --
insert into departments_dup (dept_no) values ('d010'), ('d011');

-- check --
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no DESC;

-- add a new column called department manager to the table --
alter table departments_dup add column dept_man varchar(255) null after dept_name;

-- check --
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no DESC;

/*Select the department number and name from the ‘departments_dup’ table and add a third 
column where you name the department number (‘dept_no’) as ‘dept_info’. 
If ‘dept_no’ does not have a value, use ‘dept_name’.
*/
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

/* Modify the code obtained from the previous exercise in the following way. 
Apply the IFNULL() function to the values from the first and second column, 
so that ‘N/A’ is displayed whenever a department number has no value, 
and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
*/
SELECT 
    dept_no,
    dept_name,
    IFNULL(dept_no, 'N/A') AS dept_info,
    IFNULL(dept_name, 'Department not provided') AS dep_name
FROM
    departments_dup
ORDER BY dept_no;



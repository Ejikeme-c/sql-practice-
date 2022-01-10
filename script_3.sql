-- connect to the employees database--
use employees;

-- select the names of all employees--
SELECT 
    first_name, last_name
FROM
    employees;
    
-- select the department number from the department table --
SELECT 
    dept_no
FROM
    departments;
    
-- select the whole department table --
SELECT 
    *
FROM
    departments;

-- show all employees with first name as denis --
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
-- retrieve all employees with first name as elvis -- 
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';

-- retrieve all female employees called kellie --
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'kellie' AND gender = 'F';
    
-- retrieves a list of all employees whose first name is either kellie or aruna --
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';

-- all female with first name of either kellie or aruna --
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');

-- all employees with first name either denis or elvis --
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');       
    
-- all employees apart from ones named john, mark or jacob --
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
-- employees with firts 4 leters of the name as mark --
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mark%');
    
-- employees hired in the year 2000 --
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000%');
    
-- employees that thier employee number starts with 1000 and is only 5 characters long --
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
-- employees with 1. jack contained in the first name 2. not in the first name --
-- 1 --
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');
-- 2 --    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%jack%');
    
-- 1. salaries between 66000 & 70000 2. employees with # not between 10004 & 10012 3. depart. # between d003 & d006 --
-- 1 --
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN '66000' AND '70000';
-- 2 --
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
-- 3 --
SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';
    
-- Retrieve a list with data about all female employees who were hired in the year 2000 or after. --
use employees;

SELECT 
    *
FROM
    employees
WHERE
    gender = 'f'
        AND hire_date >= '2000-01-01';
        
-- Extract a list with all employees’ salaries higher than $150,000 per annum. --
SELECT 
    *
FROM
    salaries
WHERE
    salary > '150000';
    
-- Obtain a list with all different “hire dates” from the “employees” table. --
SELECT DISTINCT
    hire_date
FROM
    employees;

-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?--
SELECT 
    COUNT(salary)
FROM
    salaries
WHERE
    salary >= '100000';

/* How many managers do we have in the “employees” database? 
Use the star symbol (*) in your code to solve this exercise.
*/
SELECT 
    COUNT(*)
FROM
    dept_manager;

-- Select all data from the “employees” table, ordering it by “hire date” in descending order. --
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/* 
Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column.
*/
SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > '80000'
GROUP BY salary
ORDER BY salary;

-- Select all employees whose average salary is higher than $120,000 per annum.--
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

-- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000. --
SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no ASC;

-- Select the first 100 rows from the ‘dept_emp’ table. --
SELECT 
    *
FROM
    dept_emp
LIMIT 100;

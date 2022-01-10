use employees;

DELETE FROM departments_dup 
WHERE
    dept_no IN ('d002');

insert into departments_dup (dept_no) values ('d010'), ('d011');

CREATE TABLE dept_man_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    from_date DATE NOT NULL,
    to_date DATE
);

insert into dept_man_dup select * from dept_manager;

insert into dept_man_dup (emp_no, from_date) 
values (999904, '2017-01-01'), (999905, '2017-01-01'), (999906, '2017-01-01'), (999907, '2017-01-01');

delete from dept_man_dup where dept_no in('d001');

/*
Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date. 
*/

SELECT 
    t1.emp_no,
    t1.first_name,
    t1.last_name,
    t2.dept_no,
    t2.from_date
FROM
    employees t1
        INNER JOIN
    dept_manager t2 ON t2.emp_no = t1.emp_no;

/*
Join the 'employees' and the 'dept_manager' tables to return a 
subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name.  
*/
use employees;

SELECT 
    t1.emp_no,
    t1.first_name,
    t1.last_name,
    t2.dept_no,
    t2.from_date
FROM
    employees t1
        LEFT JOIN
    dept_manager t2 ON t1.emp_no = t2.emp_no
WHERE
    last_name IN ('Markovitch')
ORDER BY dept_no DESC , emp_no;

/*
Extract a list containing information about all managers’ 
employee number, first and last name, department number, and hire date. 
Use the old type of join syntax to obtain the result.
*/
SELECT 
    t1.emp_no,
    t1.first_name,
    t1.last_name,
    t2.dept_no,
    t1.hire_date
FROM
    employees t1,
    dept_manager t2
WHERE
    t1.emp_no = t2.emp_no
ORDER BY emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

/* 
Select the first and last name, the hire date, and the job title 
of all employees whose first name is “Margareta” and have the last name “Markovitch”.
*/
SELECT 
    t1.emp_no,
    t1.first_name,
    t1.last_name,
    t2.title,
    t1.hire_date
FROM
    employees t1
        JOIN
    titles t2 ON t1.emp_no = t2.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY emp_no;

/*
Use a CROSS JOIN to return a list with all possible combinations 
between managers from the dept_manager table and department number 9.
*/
SELECT 
    t1.*, t2.*
FROM
    dept_manager t1
        CROSS JOIN
    departments t2
WHERE
    t2.dept_no = 'd009'
ORDER BY emp_no;

-- Return a list with the first 10 employees with all the departments they can be assigned to. --
SELECT 
    t1.*, t2.*
FROM
    departments t1
        CROSS JOIN
    employees t2
WHERE
    emp_no <= '10010';
    
-- Select all managers’ first and last name, hire date, job title, start date, and department name. --
SELECT 
    t1.emp_no,
    t1.first_name,
    t1.last_name,
    t1.hire_date,
    t2.title,
    t3.from_date,
    t4.dept_name
FROM
    employees t1
        JOIN
    titles t2 ON t1.emp_no = t2.emp_no
        JOIN
    dept_manager t3 ON t2.emp_no = t3.emp_no
        JOIN
    departments t4 ON t3.dept_no = t4.dept_no
WHERE
    t2.title = 'Manager'
ORDER BY emp_no;

-- How many male and how many female managers do we have in the ‘employees’ database? --
SELECT 
    t1.gender, COUNT(t2.emp_no) AS no_manager
FROM
    employees t1
        JOIN
    dept_manager t2 ON t1.emp_no = t2.emp_no
GROUP BY t1.gender;
-- ans = 13F & 11M 

-- create a duplicate for the employees table --
drop table if exists employees_dup;
CREATE TABLE employees_dup (
    emp_mo INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

-- copy contents from employees table to the duplicate -- 
insert into employees_dup select * from employees limit 20;


-- connect to the employees database --
use employees;

-- Select ten records from the “titles” table to get a better idea about its content. --
SELECT 
    *
FROM
    titles
LIMIT 10;

/* Then, in the same table, insert information about employee number 999903. 
State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.
*/
-- insert and employee with employee number 999903 --
insert into employees values (999903, '1980-01-16', 'oriel', 'martin', 'm', '1997-10-01');
insert into titles (emp_no, title, from_date) values ( 999903, 'Senior Engineer', '1997-10-01'); 

-- check if it was inserted --
SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC
LIMIT 10;

/*Insert information about the individual with employee number 999903 into the “dept_emp” table. 
He/She is working for department number 5, and has started work on  October 1st, 1997; 
her/his contract is for an indefinite period of time.
*/
insert into dept_emp values (999903, 'd005', '1997-10-01', '9999-01-01'); 

-- check --
SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

-- create a replica of the department table --
CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dep_name VARCHAR(40) NOT NULL
);

-- copy the contents into the table --
insert into departments_dup (dept_no, dep_name) select * from departments;

-- check if it copied --
SELECT 
    *
FROM
    departments_dup;
    
-- Create a new department called “Business Analysis”. Register it under number ‘d010’. --
insert into departments values ('d010', 'Business Analysis');


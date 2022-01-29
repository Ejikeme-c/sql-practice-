/*
compare the average salary of male vs female in the entire company until year 2002
*/
use employees_mod;

SELECT 
    YEAR(s.from_date) AS work_year,
    e.gender,
    td.dept_name,
    ROUND(AVG(s.salary), 2) AS avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp d ON d.emp_no = e.emp_no
        JOIN
    t_departments td ON d.dept_no = td.dept_no
GROUP BY work_year , gender , td.dept_name
HAVING work_year <= '2002'
ORDER BY work_year, td.dept_name;

-- Find the average salary of the male and female employees in each department. --
use employees;

SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    employees e
        JOIN
    salaries s ON s.emp_no = e.emp_no
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY gender , dept_name
ORDER BY de.dept_no;

-- Find the lowest department number encountered in the 'dept_emp' table. Then, find the highest department number. --
SELECT 
    MIN(dept_no), MAX(dept_no)
FROM
    dept_emp; 

/*
Obtain a table containing the following three fields for all individuals whose employee number is not
greater than 10040:
- employee number
- the lowest department number among the departments where the employee has worked in 
- assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020,
and '110039' to those whose number is between 10021 and 10040 inclusive. 
*/
SELECT 
    emp_no,
    MIN(dept_no),
    CASE
        WHEN emp_no <= 10020 THEN 110022
        ELSE 110039
    END AS manager
FROM
    dept_emp
WHERE
    emp_no <= 10040
GROUP BY emp_no;

-- Retrieve a list of all employees that have been hired in 2000 --
SELECT 
    *
FROM
    employees
WHERE
    YEAR(hire_date) = '2000'
ORDER BY emp_no;

/*
1. Retrieve a list of all employees from the ‘titles’ table who are engineers.
2. Repeat the exercise, this time retrieving a list of all employees from the ‘titles’ table who are senior
engineers.
*/ 

-- 1. --
SELECT 
    e.*, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title LIKE '%engineer%'
GROUP BY emp_no
ORDER BY emp_no;

-- 2 --
SELECT 
    e.*, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'senior engineer'
GROUP BY emp_no
ORDER BY emp_no;

/*
Create a procedure that asks you to insert an employee number and that will obtain an output containing
the same number, as well as the number and name of the last department the employee has worked in.
Finally, call the procedure for employee number 10010. 
*/
delimiter $$

create  procedure  last_dept(in p_emp_no int)
begin 
SELECT 
    d.emp_no, d.dept_no, de.dept_name
FROM
    dept_emp d
        JOIN
    departments de ON d.dept_no = de.dept_no
WHERE
    emp_no = p_emp_no
        AND from_date = (SELECT 
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no); 
end$$

delimiter ;

call last_dept(10010);

/*
How many contracts have been registered in the ‘salaries’ table with duration of more than one year and
of value higher than or equal to $100,000? 
*/
SELECT 
    COUNT(salary)
FROM
    salaries
WHERE
    salary >= 100000
        AND DATEDIFF(to_date, from_date) > 365;

/*
Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set the
hire date to equal the current date. Format the output appropriately (YY-mm-dd).
Extra challenge: You can try to declare a new variable called 'today' which stores today's data, and then
use it in your trigger! 
*/
set @today = date_format(sysdate(), '%YY-%mm-%dd');

delimiter $$

create trigger check_hire_date
 before insert on employees 
 for each row 
 begin 
 if new.hire_date > @today 
 then set new.hire_date = @today; 
 end if; 
 end$$ 
 
 delimiter ;
use employees;

create index i_salary on salaries (salary); 

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    
/*
Extract a dataset containing the following information about the employees: employee number, first name, and last name. 
Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT.
*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    (MAX(s.salary) - MIN(s.salary)) AS salary_diff,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'salary raise is higher than 30000'
        ELSE 'it is not higher'
    END AS raise
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no;
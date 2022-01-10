use employees;

/*
Extract the information about all department managers who were hired 
between the 1st of January 1990 and the 1st of January 1995.
*/
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
-- Select the entire information for all employees whose job title is “Assistant Engineer”. --
SELECT 
    *
FROM
    employees t1
WHERE
    EXISTS( SELECT 
            t2.emp_no
        FROM
            titles t2
        WHERE
            title = 'Assistant Engineer'
                AND t2.emp_no = t1.emp_no)
ORDER BY emp_no;

/*
Starting your code with “DROP TABLE”, 
create a table called “emp_manager” (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; 
manager_no – integer of 11, not null). 
*/
drop table if exists emp_namager;
CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    manager_no INT(11) NOT NULL
);


insert into emp_manager select U.* from(
SELECT 
    A.*
FROM
    (SELECT 
        t1.emp_no AS employee_id,
            MIN(t2.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees t1
    JOIN dept_emp t2 ON t1.emp_no = t2.emp_no
    WHERE
        t1.emp_no <= 10020
    GROUP BY t1.emp_no
    ) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        t1.emp_no AS employee_id,
            MIN(t2.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees t1
    JOIN dept_emp t2 ON t1.emp_no = t2.emp_no
    WHERE
        t1.emp_no > 10020
    GROUP BY t1.emp_no
    LIMIT 20) AS B
    union
    SELECT 
    C.*
FROM
    (SELECT 
        t1.emp_no AS employee_id,
            MIN(t2.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees t1
    JOIN dept_emp t2 ON t1.emp_no = t2.emp_no
    WHERE
        t1.emp_no = 10022
    GROUP BY t1.emp_no
    ORDER BY t1.emp_no) AS C
    union 
    SELECT 
    D.*
FROM
    (SELECT 
        t1.emp_no AS employee_id,
            MIN(t2.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees t1
    JOIN dept_emp t2 ON t1.emp_no = t2.emp_no
    WHERE
        t1.emp_no = 110039
    GROUP BY t1.emp_no
    ORDER BY t1.emp_no) AS D)as U;
  
  
/*
Create a view that will extract the average salary of all managers 
registered in the database. Round this value to the nearest cent.
*/
CREATE OR REPLACE VIEW v_avg_manager_salary AS
    SELECT 
        ROUND(AVG(t1.salary), 2)
    FROM
        salaries t1
            JOIN
        dept_manager t2 ON t1.emp_no = t2.emp_no;
        
        

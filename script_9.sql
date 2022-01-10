use employees;

delimiter $$

create function avg_salary (p_emp_no int) returns decimal (10, 2)
DETERMINISTIC NO SQL READS SQL DATA 
BEGIN
declare v_avg_salary decimal(10, 2);

SELECT 
    AVG(salary)
INTO v_avg_salary FROM
    salaries
WHERE
    salaries.emp_no = p_emp_no;
return v_avg_salary;
END$$ 

delimiter ;


/*
Create a trigger that checks if the hire date of an employee is higher than the current date. 
If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
*/

DELIMITER $$

CREATE TRIGGER trig_hire_date  

BEFORE INSERT ON employees

FOR EACH ROW  

BEGIN  

    IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN     
      SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');     
    END IF;  

END $$  

DELIMITER ;  

   

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;

rollback;
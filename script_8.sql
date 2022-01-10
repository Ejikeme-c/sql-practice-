use employees;

drop procedure if exists avg_salaries;
delimiter $$

-- Create a procedure that will provide the average salary of all employees.

create procedure avg_salaries() 
begin
select avg(salary) from salaries;
end$$

delimiter ;

call avg_salaries();

select * from employees limit 10;

/* 
Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.

Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.

Finally, select the obtained output.
*/
set @v_emp_no = '';
call emp_info('Aruna', 'Journel', @v_emp_no);
select @v_emp_no; 
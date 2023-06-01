select * from  where department_id=(select id  from departments where department_name='sales'); 
select emp_id,emp_name,AVG(salary) from employees where dep_id=(select dept_id from department where department_name='HR') ;

 select emp_id,emp_name,AVG(salary) from employees where dep_id=(select dept_id from department where department_name='Financy') and salary>AVG(salary);
 select AVG(product_name) from products;

 CREATE TRIGGER Updat ON employees
instead of INSERT 
As
begin
Declare @minsal int
Declare @sal int
Declare @thr_val varchar(20)
set @thr_val=5000
begin
	
	select @sal=salary from inserted;
	Begin
	@min_sal=select min(salary) from employees;
	if @sal<@thr_val
	begin
		update employees(salary) set @sal=@min_sal;
	end
	end
 
end

end
--SESSION 2
--transaction Isolation Levels
--session 2 Read uncommited
select @@TRANCOUNT as OpenTrans
begin transaction
update Employee_details set EmployeeName='Raju' where emp_id=4;
waitfor delay '00:00:01';
insert into Employee_details values('Santosh');
waitfor delay '00:00:01';

--session 2 Read commited
begin transaction
update Employee_details set EmployeeName='Shyam' where emp_id=4;
waitfor delay '00:00:03'
commit transaction;

--session 3 repeatable read

begin transaction
update Employee_details set EmployeeName='Shy' where emp_id=4;
commit transaction;
begin transaction --accepted 
insert into Employee_details values('Jones');
commit transaction;

select * from Employee_details;

select @@TRANCOUNT as OpenTrans
commit ;
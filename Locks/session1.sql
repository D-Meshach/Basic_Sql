create database trans_lock_emp
create table Employee_details(emp_id int identity(1,1),EmployeeName varchar(20));
insert into Employee_details values('Ramesh'),('Suresh'),('Raju'),('Shyam'),('John'),('Ravinder'),('Peter');
select * from Employee_details;

select @@TRANCOUNT as OpenTrans
--SESSION 1
--transaction Isolation Levels
--session1 Read uncommited --Return uncommited datas also //writes uncommited data from session 2 to table

set transaction isolation level Read uncommitted
begin transaction
select emp_id,EmployeeName from Employee_details;
waitfor delay '00:00:05';
select emp_id,EmployeeName from Employee_details;
commit transaction;
select * from Employee_details;

--session1 read committed  // only the data is saved when commited from session 2 is executed
set transaction isolation level Read committed
begin transaction
select emp_id,EmployeeName from Employee_details;
waitfor delay '00:00:03';
select emp_id,EmployeeName from Employee_details;
commit transaction;

--session 3 -- repeatable read // wait till the session 1 complete then the other session i.e session2 is executed
-- will accept insert data during transaction but not alter,update,delete;
set transaction isolation level repeatable Read
begin transaction
select emp_id,EmployeeName from Employee_details
waitfor delay '00:00:05';
select emp_id,EmployeeName from Employee_details
commit transaction

select * from Employee_details;

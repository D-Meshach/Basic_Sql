Create table employee_detail(id int identity(1,1) primary key,FirstName varchar(10),LastName varchar(10),Department varchar(10));
create table employee_address(employee_id int primary key,City varchar(10),state varchar(10),District varchar(10),Zip varchar(10),Foreign key(employee_id) references employee_detail(id));
create table salary_detail(emp_id int,Salary_id int,Date_of_payment DateTime,Bank_Name varchar(20),Salary int,Foreign key(emp_id) References employee_detail(id));
select * from employee_detail;
truncate table employee_detail;
drop table employee_address;
drop table employee_detail;
alter table employee_address Alter COLUMN Zip int;
exec sp_columns employee_address;
delete from employee_detail where id=1;
insert into employee_detail values('Rajesh','khanna','IT'),('Rohit','shyam','Finane'),('Anish','Raj','Medical'),('Rohini','choudhary','Finance');
insert into employee_address values(1,'namunagar','Andhra','nnnagar',21);
insert into salary_detail values(1,2001,'01-01-2016','SBI',25000),(2,3000,'01-01-2015','AXIS',30000),(4,4000,'01-01-2015','INDIAN',25000);
insert into salary_detail values(2,3001,'01-02-2015','AXIS',30000),(3,3300,'01-01-2015','YES',30000),(4,4001,'01-02-2015','INDIAN',25000);
insert into salary_detail values(1,2002,'01-02-2016','SBI',25000),(2,3002,'01-03-2015','AXIS',30000),(3,3301,'01-02-2015','YES',30000),(4,4002,'01-03-2015','INDIAN',25000);
exec sp_columns salary_detail;
delete from employee_detail where id=1;
select * from employee_detail;
select * from employee_address;
select * from salary_detail;

SELECT MONTH(CURRENT_TIMESTAMP);

select Count(id) as Counts from employee_detail; 
select AVG(salary) as Average_salary_of_Rajesh from salary_detail where emp_id=2; 
select MAX(salary) as Highest_Salary from salary_detail group by salary;


select FirstName from employee_detail order by len(FirstName);
select AVG(salary),FirstName from salary_detail group by emp_id;


select datediff(year,'12-122-020',getdate());
select upper(FirstName) from employee_detail;
select Top 5 percent * from salary_detail;
select Top 3 with TIES FirstName from employee_detail order by FirstName;
select Distinct Bank_Name,Salary from salary_detail;
select Bank_Name,SUM(Salary) from salary_detail group by Bank_Name;

select to_char('02-12-2022','Day');
select DAY('02-12-2022');
/*Group by used to group multiple to single and must involve select aggregatefunction...order by only used to order or sort in ascending or descending 
if using group by, mention aggregate*/
select sum(Salary) from salary_detail group by Bank_Name order by Bank_Name;
select SUM(salary) as average,Bank_Name from salary_detail order by Bank_Name;
select Bank_Name,Salary from salary_detail group by Salary;-- it is not contained in either an aggregate function or the GROUP BY clause.--
select * from salary_detail order by salary,Bank_Name offset 1 rows Fetch First 5 rows only;

--Date Time

Select CURRENT_TIMESTAMP;
--To retrieve current month
select MONTH(CURRENT_TIMESTAMP);
select Year(CURRENT_TIMESTAMP);
select Current_TimeZone();--for time zone
--Find date after 10 days
select DATEADD(day,7,'04-02-2022');--04->month,02->day,2022->year
select DATEDIFF(day,'2022-04-01','2022-04-05');
select DATEPART(year,'2022-04-05');--> extract year from given date same as SELECT YEAR('2022-04-05');
select GetDate();-- get date time 

-- string functions
select Concat('Hello',' ','world');
select substring('Hello World',2,5);
select len('Hello world');
select REPLACE('Hello World','Hello','Hi');
select AVG(salary) from salary_detail group by Bank_Name order by Bank_Name ;

--


SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;


select Employees.FirstName,Departments.Department from employees inner join Departments on Employee.EmployeeID=Departments.DepartmentID;
select concat(Employees.FirstName,' ',Employee.LastName),Departments.DepartmentName,count(Department.DepartmentName) from employees inner join Departments  on Employee.EmployeeID=Departments.DepartmentID group by Departments.DepartmentName;

select Employees.FirstName,Departments.Department,Min(Employees.HireDate) from employees inner join Departments on Employee.EmployeeID=Departments.DepartmentID group by Employees.HireDate;
  

--joins

select salary_detail.Salary,employee_detail.FirstName from salary_detail right join employee_detail on salary_detail.emp_id=employee_detail.id;
select * from salary_detail;select*from employee_detail;
create table test_employee(emp_id int primary key,FirstName varchar(10),LastName varchar,Department varchar(10));
alter table test_employee alter column LastName varchar(10);
select*from employee_detail;
select * from test_employee;
insert into test_employee values(3,'Anish','Raj','Medical'),(4,'Rajs','chandhu','physics');
insert into test_employee values(5,'Pushparaj','Sharma','IT'),(6,'Jaggu','sahib','Finance');
select em.id as id,sl.FirstName as SalFname,em.FirstName as emFname,sd.Date_of_payment,sd.Bank_Name from employee_detail em inner join test_employee sl on sl.emp_id=em.id inner join salary_detail sd on sd.emp_id=sl.emp_id; ; 
select*from employee_detail;
select * from test_employee;
-- join total paid to the employee
--	use left join for employee_detail left join salary_detail, then retrieve firstname lastname from employee_detail and bankdetail from salary_detail and group to find the total salary paid to each employee 
select em.id,sl.Bank_Name,em.FirstName,em.LastName,SUM(salary)as Total_Payment_as_per_record,Count(em.id) as Counts_of_sal_paid,AVG(sl.Salary) as Average_Salary from employee_detail em left join salary_detail sl on sl.emp_id=em.id group by sl.Bank_Name,em.id,em.FirstName,em.LastName order by em.id; 
-- Finding the average salary greater than 25000

create function salesmake(@salary int)
Returns int AS
Begin
--statement
Return @salary*10;

END;

--scalar function
select dbo.salesmake(salary),Bank_Name as func_use,Bank_Name from salary_detail group by Bank_Name,dbo.salesmake(salary);
Drop function salesmake;
--Table Valued Function



--stored procedure
create procedure selectParticularEmployee(@EmpName varchar(10))
As
Begin
Select em.id as id,em.FirstName as First_Name,em.LastName as Last_Name ,sl.Bank_Name as Bank_Name,SUM(sl.salary) as Total_salary,Count(sl.emp_id) as Total_Counts from employee_detail em left join salary_detail sl on em.id=sl.emp_id where em.FirstName=@EmpName group by em.id,em.FirstName ,em.LastName ,sl.Bank_Name order by id;
END;

EXEC selectParticularEmployee @EmpName='Rajesh';
select * from employee_detail;
select * from employee_address;
select * from salary_detail;


create procedure selectPartOutput(@salary int=25000)
As
Begin
Select em.id as id,em.FirstName as First_Name,em.LastName as Last_Name ,sl.Bank_Name as Bank_Name,SUM(sl.salary) as Total_salary,Count(sl.emp_id) as Total_Counts from employee_detail em left join salary_detail sl on em.id=sl.emp_id where sl.salary=@salary group by em.id,em.FirstName ,em.LastName ,sl.Bank_Name order by id;
End;
DECLARE @count INT;
--Select em.id as id,em.FirstName as First_Name,em.LastName as Last_Name ,sl.Bank_Name as Bank_Name,SUM(sl.salary) as Total_salary,Count(sl.emp_id) as Total_Counts from employee_detail em left join salary_detail sl on em.id=sl.emp_id where em.FirstName=@EmpName group by em.id,em.FirstName ,em.LastName ,sl.Bank_Name order by id;

create view FindEmployeeDetailJoin
AS
--select * from employee_detail;
Select em.id as id,em.FirstName as First_Name,em.LastName as Last_Name ,sl.Bank_Name as Bank_Name,SUM(sl.salary) as Total_salary,Count(sl.emp_id) as Total_Counts from employee_detail em left join salary_detail sl on em.id=sl.emp_id group by em.id,em.FirstName ,em.LastName ,sl.Bank_Name;
--call view
select * from FindEmployeeDetail;
select * from FindEmployeeDetailJoin;
--Drop view view_name
select * from employee_detail;
CREATE INDEX idx_lastname ON employee_detail (LastName); 


create procedure sp.SpecificDate(@date Date,@id)
As
Begin
select em.FirstName,dp.department from Employees em inner join DepartmentID dp on em.DepartmentID=dp.departmentID where HireDate>@date;
End;
create procedure sp.SpecificDate(@startdate Date,@enddate Date,@id int,@specificdate date)
As
Begin
select em.FirstName,dp.department from Employees em inner join DepartmentID dp on em.DepartmentID=dp.departmentID where id=@id and HireDate>@specificDate and HireDate between @startdate and @enddate;
End;


create procedure spCalculateAge(@DOB date)
AS
BEGIN
Declare @Age int
DECLARE @ROLL INT
set @Age=DateDiff(Year,@DOB,GETDATE())
SET @ROLL=23-
case
when(Month(@DOB)>Month(GetDate()))or (MONTH(@DOB)=MONTH(GETDATE())AND DAY(@DOB)>DAY(GETDATE()))
THEN 1
ELSE 0
END
SELECT @AGE
END;
--subqueeries






----
SELECT * FROM employee_detail;
select * from salary_detail;
create procedure spCalculateAge(@DOB date)
AS
BEGIN
Declare @Age int
DECLARE @ROLL INT
set @Age=DateDiff(Year,@DOB,GETDATE())
SET @ROLL=23-
case
when(Month(@DOB)>Month(GetDate()))or (MONTH(@DOB)=MONTH(GETDATE())AND DAY(@DOB)>DAY(GETDATE()))
THEN 1
ELSE 0
END
SELECT @AGE
END;

exec spCalculateAge @DOB='05-26-2023';

--Functions part 2
create function db.calculateAge(@DOB date)
RETURNS INT
AS
BEGIN
return Datediff(Year,@DOB,GetDate())
END

/*
Declare cursor
open cursor for {set of records}
	loop
	{
		Fetch Records from cursor
	}
	Close Cursor
	Deallocate Cursor


*/
SELECT * FROM EMPLOYEE_dETAIL;

--1 initialize variable
DECLARE @NAME_LIST VARCHAR(100)
DECLARE @FNAME VARCHAR(10)
DECLARE @LNAME VARCHAR(20)
SET @NAME_LIST=''
--2 INITIALIZE CURSOR

DECLARE MYCURSOR CURSOR FOR 
SELECT FirstName , LastName from employee_detail
open mycursor 
fetch next from MYCURSOR INTO @FNAME ,  @LNAME 
WHILE @@FETCH_STATUS=0
BEGIN
	SELECT @NAME_LIST=@NAME_LIST+CONCAT(@FNAME,' ',@LNAME)+','
	FETCH NEXT FROM MYCURSOR INTO @FNAME,@LNAME
END

CLOSE MYCURSOR
DEALLOCATE MYCURSOR

SELECT @NAME_LIST AS NAME_LIST

--CURSOR USING THE UPDATE


--TRIGGER
SELECT * FROM EMPLOYEE_DETAIL;
SELECT * FROM SALARY_DETAIL;
SELECT * FROM EMPLOYEE_ADDRESS;
INSERT INTO EMPLOYEE_ADDRESS VALUES(2,'Ch chowk','Gujarat','dhagar',2145);
create table products(ProductName varchar(10),sold int,TotalPiece int);
drop table products;
insert into products values('Tube',1,55);
select * from products;
select Difference(2,1);
--trigger working
DROP TRIGGER IF EXISTS productUpdate
Go
CREATE TRIGGER productUpdate ON products
instead of INSERT 
As
begin
Declare @totp int
Declare @tot2 int
Declare @prod_name varchar(20)
begin
 select @totp=TotalPiece,@tot2=sold,@prod_name=ProductName from inserted;
SET @totp=@totp-@tot2;
insert into products values(@prod_name,@tot2,@totp);
end

end
--trigger insert
select * from Products;
delete from products where ProductName='w';
insert into products(ProductName,sold,TotalPiece) values('watch',30,50);

Alter TRIGGER productUpdate ON products
for INSERT 
As
begin
select FirstName from employee_detail;
END


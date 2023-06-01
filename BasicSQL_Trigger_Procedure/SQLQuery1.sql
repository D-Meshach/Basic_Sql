create database OnlineStore;
create table Customers(customer_id int identity(1,1) primary key,
customer_name varchar(20),
email varchar(20),
phone_number varchar(20),
address varchar(20));

drop table Orders;
drop table customers;

--
create table Orders( order_id int primary key,--identity
customer_id int,
order_date date,
total_amount decimal,
foreign key (customer_id) references Customers(customer_id));
--
create table Products(product_id int,--primary
product_name varchar(20),
price decimal);--cust_id

select * from Customers;
select * from Orders;
select * from Products;

insert into Customers values('Ramesh','rame2@gmail.com','9966587452','Andhra Pradesh'),('Raju','raju@gmail.com','7747474745','Chattisgarh'),('Sonu Nigam','sonu@gmail.com','8897865412','Gujarat'),('Rajesh Khan','rajesh@yahoo.com','7845103698','Madhya Pradesh');
select * from Customers;
delete from Customers where customer_name='Ramesh';

insert into Products values(1,'Bulb',25),(2,'Watch',50.2),(1,'Bulb',30.2),(4,'Rice',50),(5,'Dal',30),(6,'Rice',20),(7,'Wheat',20);
select * from Products;
update products set product_id=1 where product_name='Bulb';
update products set product_id=2 where product_name='Watch';
update products set product_id=3 where product_name='Rice';
update products set product_id=4 where product_name='Dal';
update products set product_id=5 where product_name='wheat';
select Product_Name,sum(price) as Total_Price,count(Product_Name) as quantity_sold from Products group by product_name;
create view productCustomView as select product_id as id,Product_Name,sum(price) as sumPrice 
from Products group by product_name,product_id;
select * from productCustomView;

drop view productCustomView;


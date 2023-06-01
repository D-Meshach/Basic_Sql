select * from Customers;
select * from Products;
select * from Orders;`
alter table products order_id int;
alter table products drop constraint FK__Products__order___48CFD27E;
exec sp_columns Orders;
update products set order_id=1001 where product_id=1;
update products set order_id=1002 where product_id=2 and price=50;
update products set order_id=1003 where product_id=1 and price=30;
update products set order_id=1003 where product_id=3 and price=50;
update products set order_id=1003 where product_id=4;
update products set order_id=1002 where product_id=3 and price = 20;
update products set order_id=1002 where product_id=5;

insert into orders values(1001,2,'2022-12-02',2500),(1002,3,'05-12-2022',1500),(1003,4,'2015-02-11',2000);
insert into orders values(1002,3,'05-12-2022',1500),(1003,4,'2015-02-11',2000);

--Ak complete
create procedure spRetrieveDetail(@order_id int)
As
Begin
select * from orders where order_id=@order_id;
End;

exec spRetrieveDetail @order_id=1001;

--mduka complete
create procedure spInsertCustomer(@customer_name varchar(20),@email varchar(20),@phone_no varchar(20),@address varchar(20))
As
Begin
insert into customers values(@customer_name,@email,@phone_no,@address);
End;

exec spInsertCustomer @customer_name='Nakthu',@email='nk@gmail.com',@phone_no='9988676545',@address='himachal';

insert into orders values(1004,2,'2022-12-13',1000);
select sum(total_amount)as Total_Purchase_amount,customer_id  from orders where customer_id=2 group by customer_id;

--sai total purchase amount
create or alter procedure spTotalAmount(@customer_id int)
As
Begin
select sum(total_amount)as Total_Purchase_amount,customer_id  from orders where customer_id=@customer_id group by customer_id;
End;

exec spTotalAmount @customer_id=2;

--kolluri

select cus.customer_id,cus.customer_name,cus.email,cus.phone_number,sum(total_amount) as Total_purchase_amount from customers cus inner join orders od on cus.customer_id=od.customer_id group by cus.customer_id,cus.customer_name,cus.email,cus.phone_number;

--update email

create or alter procedure spUpdateEmail(@customer_id int,@cus_email varchar(20))
As
Begin
update Customers set email=@cus_email where customer_id=@customer_id;
End;

exec spUpdateEmail @customer_id=2,@cus_email='rajma@gmail.com';

create or alter procedure spDeleteCustomer(@customer_id int)
As
Begin
delete from Customers where customer_id=@customer_id;
End;
select * from customers;
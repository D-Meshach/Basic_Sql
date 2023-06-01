
--simple trans
select * from products;
--Trans
select * from products with(nowait,updlock) where ProductName='Tube';
select * from products with(nowait,updlock) where ProductName='Watch';

UPDATE products with(nowait,updlock) SET    ProductName = 'Book' WHERE ProductName='watch';
SELECT * FROM products
SELECT @@TRANCOUNT AS OpenTransactions
commit; 

Rollback tran;

alter table products add col1 varchar(5);

select * from products;

alter table products drop column col1;

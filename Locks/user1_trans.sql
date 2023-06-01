SET IMPLICIT_TRANSACTIONS ON ;
--simple transaction
begin tran
update products set ProductName='watch' where ProductName='Book';
--
select * from products with (updlock) where ProductName='Tube';
SELECT @@TRANCOUNT AS OpenTransactions
Rollback tran
commit;


--transaction
begin tran
select * from products;
select * from SYS.DM_TRAN_LOCKS;

--update transaction
BEGIN TRAN
UPDATE products with (updlock)
SET    ProductName = 'Book' WHERE ProductName='watch';
SELECT * FROM products
ROLLBACK TRAN 
commit;

begin tran
SELECT * FROM products;


--sys.dm_os_waiting_tasks
select session_id,wait_duration_ms,wait_type,blocking_session_id,resource_description from SYS.dm_os_waiting_tasks;

--sys.dm_exec_requests
select session_id,status,wait_type,wait_time,wait_resource,command from sys.dm_exec_requests;

--sys.dm_tran_locks

select request_session_id,request_mode,request_type,resource_type,resource_description from sys.dm_tran_locks;

alter table products add col1 varchar(12);
alter table products drop column col1;

sp_who2
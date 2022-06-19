---------------------Stored Procedure---------------------------------
--A stored procedure in SQL Server is a set of SQL queries that you can use again and again. 
--You can create your own set of SQL queries and then store it as a procedure. 
--You can execute that stored procedure by just calling it with a single line of code.
create procedure ZimbaProc
as
go

--alter proc
ALTER procedure [dbo].[ZimbaProc]
as
begin
 print 'Hello 2022'
end

drop proc [dbo].[ZimbaProc]

exec [Zimba].[dbo].[ZimbaProc] @UserId = '1', @DeliveryDate = '2022-05-12', @OrderItems=
'
 <Qi>
	<Qe Oi="1" On="343" Pi="1" Oa="Butwal" Upd="2020-01-02"/>
	<Qe Oi="1" On="343" Pi="1" Oa="Pk" Upd="2020-01-02"/>
	<Qe Oi="1" On="343" Pi="1" Oa="Nj" Upd="2020-01-02"/>
 </Qi>
'
------------------Stored procedure sample----------------------------------
USE [Zimba]
GO
/****** Object:  StoredProcedure [dbo].[ZimbaProc]    Script Date: 19/06/2022 22:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[ZimbaProc] 
 @UserId int,
 @OrderItems xml,
 @DeliveryDate datetime,
 @ReDelivery bit = null
as
begin
 set nocount on; --a SET statement that controls the behaviour in SQL Server to shown the number of affected rows in the T-SQL query.
 print 'Welcome to this stored procedure'

 create table #OrderDetails (OrderId int, OrderNumber int, PersonId int, OrderAddress varchar(30), UpdateDate datetime)
 declare @Queues table (Id int,OrderNumber int, PersonId int, OrderAddress varchar(30), Updatedate datetime); --other way to declare table
 --create table #Queues (Id int,OrderNumber int, PersonId int, OrderAddress varchar(30), Updatedate datetime);

 insert into #OrderDetails
 select 
 N.C.value('@Oi', 'int'),
 N.C.value('@On', 'int'),
 N.C.value('@Pi','int'),
 N.C.value('@Oa','varchar(30)'),
 N.C.value('@Upd','datetime')
 from @OrderItems.nodes('Qi/Qe') N(C)

 select * from #OrderDetails
begin
	;with cte as (
	 select OrderId, OrderNumber, os.PersonId, OrderAddress, os.UpdateDate
	 from #OrderDetails os
	 inner join Orders o
	 on o.Id = os.OrderId
	 inner join Person p
	 on p.Id = os.PersonId
	 where not exists (select OrderNumber from OrderDetail) 
	)
	update cte
	set UpdateDate = GETUTCDATE()
	output inserted.OrderId, inserted.OrderNumber, inserted.PersonId, inserted.OrderAddress, inserted.UpdateDate into 
	@Queues(Id, OrderNumber, PersonId, OrderAddress, Updatedate)

	select * from @Queues
end

	insert into OrderDetail (OrderId, OrderNumber, PersonId, OrderAddress, UpdateDate )
	select Id, OrderNumber, PersonId, OrderAddress, UpdateDate
	from @Queues

 --select * from OrderDetail
 --select * from Orders
 --select * from PersonDetail
 --select * from Person
 --insert into Orders values (1,1)
end



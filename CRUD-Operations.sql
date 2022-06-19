----------------------CRUD operation--------------------------------------
--Select
select * from OrderDetail
select top 10 * from Person
select * from dbo.PersonDetail
select * from backup2022

--distinct
select distinct FirstName from PersonDetail

--select into command copies data from one table and inserts it into a new table
select Id, FirstName, Lastname into backup2022 from PersonDetail

--==========================================================================================
--------------------Insert--------------------------------------------
insert into Person values ('Zimba','Awe', '1996-07-12',1, GETUTCDATE(),'Zimba23')
insert into PersonDetail (Id, LastName, FirstName, Age) values (1, 'Zimbu', 'Lasa', 23)
insert into OrderDetail (OrderId, OrderNumber, PersonId, OrderAddress) values (1, 123, 1, 'kathmandu') --If PersonId is not present in Person table it will fail

--Insert into select
insert into PersonDetail
select Id, 'Zu-1'+ LastName, 'Z-'+ FirstName, 23 from Person where Id=1

--========================================================================================
-------------------Update---------------------------------------------
update PersonDetail set FirstName='L-Zimba' where FirstName='Lasa'

--=========================================================================================

------------------Delete-------------------------------------------------------
delete from PersonDetail
delete from PersonDetail where FirstName = 'L-Zimba'

--delete having Foreign key (orderDetail have foreign key of PersonId from Person table)
--deleting row of the OrderDetail will not affect the parent Person table 
delete from OrderDetail where OrderId =1 --(only OrderDetail entry will be deleted)

--delete from the parent table (Person) of the row that exist in the OrderDetail table
delete from Person where Id = 1 --doesn't allow to delete because it has entry in OrderDetail as Foreign key





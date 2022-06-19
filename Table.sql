------------------SQL Constraints ---------------------------
--SQL constraints are used to specify rules for the data in a table.
--Constraints are used to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data in the table. 
--If there is any violation between the constraint and the data action, the action is aborted.
--Constraints can be column level or table level. Column level constraints apply to a column, and table level constraints apply to the whole table.
--The following constraints are commonly used in SQL:
	--NOT NULL - Ensures that a column cannot have a NULL value
	--UNIQUE - Ensures that all values in a column are different
	--PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
	--FOREIGN KEY - Prevents actions that would destroy links between tables
	--CHECK - Ensures that the values in a column satisfies a specific condition
	--DEFAULT - Sets a default value for a column if no value is specified
	--CREATE INDEX - Used to create and retrieve data from the database very quickly

--------Table Creations in default schema (dbo)-----------------
create table Person
(
	Id int Identity(1,1) primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Dob datetime not null,
	Gender bit not null,
	Created datetime2 default getutcdate(), --default contraint with datetime precision datetime2 upto nano second and datetime is milisecond
	Username varchar(50) not null
	unique(Username)
)

---select from table
select * from Person

create table PersonDetail
(
	Id int not null,
    LastName varchar(255) not null,
    FirstName varchar(255) not null,
    Age int check (Age>18),
    constraint PK_Person primary key (Id,LastName) --for naming convensation add PK_ at beginning
)

create table Orders
(
	Id int primary key,
	PersonId int not null
)

create table OrderDetail
(
	OrderId int not null,
	OrderNumber int,
	PersonId int,
	OrderAddress varchar(30)

	constraint FK_PersonOrderId foreign key (PersonId) --for naming convensation add FK_ at beginning
	references Person(Id)
)

create table backup2022
(
	Id int not null,
	FirstName varchar not null,
	LastName varchar not null
)
--------alter table -------------------
alter table Person 
	add
	Country varchar(30) default 'NP',  --default constraint
	Age bit default 0

alter table Zimba.dbo.Person 
	drop column
	Gender 

--To change the data type of a column in a table
alter table Zimba.dbo.Person 
	alter column
	FirstName nvarchar not null

--add constraints
alter table PersonDetail
add constraint PK_person primary key (Id,FirstName,Lastname)

alter table OrderDetail
add constraint FK_person foreign key (Id) references Person(Id)

alter table OrderDetail
add UserId int unique


alter table OrderDetail
add UpdateDate datetime

alter table PersonDetail
add UpdateDate datetime

--delete constraints
alter table PersonDetail
drop constraint PK_Person

alter table OrderDetail
drop constraint FK_PersonOrderId

--------delete table ------------------
drop table Person
drop table PersonDetail
drop table OrderDetail

---Index statement----------
--The CREATE INDEX statement is used to create indexes in tables.
--Indexes are used to retrieve data from the database more quickly than otherwise. 
--The users cannot see the indexes, they are just used to speed up searches/queries.
--Note: Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). 
--So, only create indexes on columns that will be frequently searched against.


----Clustered vs Non-Clustered Indexes------------------
--Clustered index requires less memory for operations.
--A cluster index is a form of tables which consist of column and rows.
--Cluster index exists on the physical level
--A Clustered index is a type of index in which table records are physically reordered to match the index.
--You can create only one clustered index in a table like primary key. Clustered index is as same as dictionary where the data is arranged by alphabetical order. 
--There is a whole table in form of sorted data table can contain only one cluster index
--When clustered need to create: The data or file, that you are moving into secondary memory should be in sequential or sorted order.
							   --There should be a key value, meaning it can not have repeated values. 
--Data retrieval  is faster than non-cluster index
--Table is created with primary key constraints then database engine automatically create clustered index

--example: creating a primary key

--Non Cluster Index
--Non-Clustered index requires more memory for operations.
--A non cluster index is in the form of a report about the tables.
--They are not created on the physical level but at the logical level, It does not sort the data at physical level
--Data update is faster than clustered index
--The data is stored in one place, and index is stored in another place. Since, the data and non-clustered index is stored separately,
--then you can have multiple non-clustered index in a table. 
--A non-clustered index collects the key at one place and records at another place. The index carries pointers to the position of that data. 
--In non-clustered index, index contains the pointer to data. 
--Table is created with UNIQUE constraints then database engine automatically create non-clustered index
--Unique constraints are automatically non-clustered and without unique constraints we can create a non-clustered index

--example:
create nonclustered index NIX_OrderIdIndex on OrderDetail (OrderId asc)
create nonclustered index NIX_Order on OrderDetail (OrderNumber desc)
select * from sys.indexes
exec sp_helpindex 'dbo.OrderDetail'
exec sp_helpindex 'dbo.Person'


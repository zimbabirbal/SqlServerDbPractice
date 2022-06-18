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

create table OrderDetail
(
	OrderId int not null,
	OrderNumber int,
	PersonId int,
	OrderAddress varchar(30)

	primary key (OrderId)
	constraint FK_PersonOrderId foreign key (PersonId) --for naming convensation add FK_ at beginning
	references Person(Id)
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

--delete constraints
alter table PersonDetail
drop constraint PK_Person

alter table OrderDetail
drop constraint FK_PersonOrderId

--------delete table ------------------
drop table Person
drop table PersonDetail

---Index statement----------
--The CREATE INDEX statement is used to create indexes in tables.
--Indexes are used to retrieve data from the database more quickly than otherwise. 
--The users cannot see the indexes, they are just used to speed up searches/queries.
--Note: Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). 
--So, only create indexes on columns that will be frequently searched against.



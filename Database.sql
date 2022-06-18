-------------------------------Database----------------------------------------------
--Databases are a collection of objects like tables, views, stored procedures, functions, etc. In MS SQL Server, two sorts of databases are available.
--1. System databases
--2. User Databases

--1. System Databases :
	--System databases are created automatically once we install the MS SQL Server. Below is a list of system databases –
		--Master
		--Model
		--MSDB
		--Tempdb
--2. User Databases :
	--User databases are created by users (DBAs, and testers who have access to create database). To create a database, the below methods could be used –
		--SQL Server Management Studio.
		--Transact-SQL.
create database TestZimba
go

--drop database
drop database TestZimba
go

--------------Schema-------------------------
--A schema is a collection of database objects like tables, triggers, stored procedures, etc. 
--A schema is connected with a user which is known as the schema owner. Database may have one or more schema.
--SQL Server have some built-in schema, for example: dbo, guest, sys, and INFORMATION_SCHEMA.
--dbo is default schema for a new database, owned by dbo user. While creating a new user with CREATE USER command, user will take dbo as its default schema.

--------------Create schema---------------------------
create schema admin
go
--select * from sys.schemas

--delete schema
drop schema admin
go



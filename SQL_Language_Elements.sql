--------------GO statement--------------------------------
--SQL Server utilities interpret GO as a signal that they should send the current batch of Transact-SQL statements to an instance of SQL Server. 
--The current batch of statements is composed of all statements entered since the last GO, or since the start of the ad hoc session or script 
--if this is the first GO.

--GO signals the end of a batch of Transact-SQL statements to the SQL Server utilities.
--The GO command is frequently used inside T-SQL code to use batches. It is not a T-SQL statement, 
--but it is a command recognized by native SQL Server tools like the SSMS, the SQLCMD, and OSQL
--In the command line, you need to use GO because that way, you know that the T-SQL statement ended and you know that you can execute it.
--For example, this T-SQL query will show the databases. The query requires a GO at the end to inform to sqlcmd that it is the end of the batch. 
--Without the GO, the query will not be executed.

select name from sys.databases
go

--the semicolon is used to separate statements and the GO command is for batches. 
--There are some situations where the semicolon is mandatory like in some CTE scenarios or in Merge scenarios.

--use for creating store proc
create procedure ZimbaProc
as
go

insert into OrderDetail values (1, 234, 1, 'Lalitpur')
go 5  --execute above insert statement 5 times
select * from OrderDetail

--Sample Examples

USE Zimba;  
GO  
DECLARE @MyMsg VARCHAR(50)  
SELECT @MyMsg = 'Hello, World.'  
GO -- @MyMsg is not valid after this GO ends the batch.  
  
-- Yields an error because @MyMsg not declared in this batch.  
PRINT @MyMsg  
GO  
  
SELECT @@VERSION;  
-- Yields an error: Must be EXEC sp_who if not first statement in   
-- batch.  
GO 

--==============================================================================================
--------------------------------Print statement---------------------------------------
--Returns a user-defined message to the client.
print 'Hello world'

--============================================================================================
-------------------------------RaiseError statement------------------------------------
--Generates an error message and initiates error processing for the session. 
--RAISERROR can either reference a user-defined message stored in the sys.messages catalog view or build a message dynamically. 
--The message is returned as a server error message to the calling application or to an associated CATCH block of a TRY...CATCH construct. 
--New applications should use THROW instead.

raiserror ('Please provide appropriate information',1, 1); --(ERRORMESSAGE, ERROR_SEVERITY(), ERROR_STATE())

--============================================================================================
------------------------------Set nocount on-----------------------------------
--SQL Server SET NOCOUNT ON/OFF is a SET statement that controls the behaviour in SQL Server to shown the number of affected 
--rows in the T-SQL query. By default, SET NOCOUNT is set to OFF. When SET NOCOUNT is ON, 
--the message that indicates the number of rows that are affected by the T-SQL statement is not returned as part of the results.

SET NOCOUNT ON;

--==========================================================================================

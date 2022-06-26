declare @rowcount bigint;
declare @batchsize int = 1000;

while @rowcount >0
	begin
		begin tran
			insert into Person (Id, Username, LastName)
			select top (@batchsize) Id, Username, Lastname 
			from Person
			set @rowcount = @@ROWCOUNT;
		commit tran
	end

merge Person as target
using PersonDetail src on src.Id = target.Id
when matched then


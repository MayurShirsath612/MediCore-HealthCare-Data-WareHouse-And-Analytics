/* 

==== CREATING  THE DATABASE AND SCHEMAS ===

script purpose: 
create the central database "DataWarehouse" , drop it if it already exists and reacreate it.
create the three layer (bronze,silver,gold) as schemas.

WARNING ==> ruinning this scripts will result in deletion of the database "DataWarehouse" including the data inside it,
which will result in complete data loss.
run with caution.
ensure backups are available.

*/



use master;
go

-- drop the database if it already exists 
if exists (select 1 from sys.databases where name = 'DataWarehouse')

begin 
  alter database DataWarehouse set single_user with rollback immediate;
  drop database DataWarehouse;
end;
go
 
-- create the database
create database DataWarehouse;
go

use DataWarehouse;
go

-- create the schemas 
create schema bronze;
go

create schema silver;
go

create schema gold;
go




/* 

==== CREATING  THE DATABASE AND SCHEMAS ===

script purpose: 
create the central database "MediCoreDW" , drop it if it already exists and reacreate it.
create the three layer (stg, ods , dw) as schemas.

WARNING ==> ruinning this scripts will result in deletion of the database "MediCoreDW" including the data inside it,
which will result in complete data loss.
run with caution.
ensure backups are available.

*/


use master;
go

-- drop the database if it already exists 
if exists (select 1 from sys.databases where name = 'MediCoreDW')

begin 
  alter database MediCoreDW set single_user with rollback immediate;
  drop database MediCoreDW;
end;
go
 
-- create the database
create database MediCoreDW;
go

use MediCoreDW;
go

-- create the schemas
use MediCoreDW;
Go

IF SCHEMA_ID('stg')   IS NULL EXEC('CREATE SCHEMA stg');
IF SCHEMA_ID('ods')   IS NULL EXEC('CREATE SCHEMA ods');
IF SCHEMA_ID('dw')    IS NULL EXEC('CREATE SCHEMA dw');
IF SCHEMA_ID('audit') IS NULL EXEC('CREATE SCHEMA audit');
GO





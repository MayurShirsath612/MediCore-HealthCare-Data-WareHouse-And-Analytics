/* 
=======================================
DDL script : create bronze layer tables
=======================================

script purpose :
creates tables in "bronze" schema.
drops tables if they already exists.
run to redefine the DDL for bronze layer.


*/

use DataWarehouse

-- source: CRM

  -- cust info table
if object_id('bronze.crm_cust_info' , 'u') is not null
   drop  table bronze.crm_cust_info;

create table bronze.crm_cust_info(
cst_id int,
cst_key	nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr varchar(50),
cst_create_date date
);



-- prd info table
if object_id('bronze.crm_prd_info' , 'u') is not null
   drop table bronze.crm_prd_info;

create table bronze.crm_prd_info(
prd_id int,
prd_key	nvarchar(50),
prd_nm nvarchar(50),
prd_cost int ,
prd_line nvarchar(50),
prd_start_dt datetime,
prd_end_date datetime
);


-- sales details table
if object_id('bronze.crm_sales_details' , 'u') is not null
   drop table bronze.crm_sales_details;

create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int, 	
sls_order_dt int,	
sls_ship_dt int,	
sls_due_dt int,	
sls_sales int,	
sls_quantity int,	
sls_price int
);


-- source : ERP

-- cust_az12
if object_id('bronze.erp_cust_az12' , 'u') is not null
   drop table bronze.erp_cust_az12

create table bronze.erp_cust_az12(
cid nvarchar(50),
bdate date,
gen nvarchar(50)

);



--locA101
if object_id('bronze.erp_loc_a101' , 'u') is not null
   drop table bronze.erp_loc_a101

create table bronze.erp_loc_a101(
cid	 nvarchar(50),
cntry nvarchar(50)

);

--pxCATG1V2
if object_id('bronze.erp_px_cat_g1v2' , 'u') is not null
   drop table bronze.erp_px_cat_g1v2

create table bronze.erp_px_cat_g1v2(
ID	nvarchar(50),
CAT nvarchar(50),
SUBCAT	nvarchar(50),
MAINTENANCE nvarchar(50)
);

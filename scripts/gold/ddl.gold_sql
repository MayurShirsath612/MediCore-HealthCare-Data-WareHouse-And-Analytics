/*
================================================================================
DDL Script: Create Gold Views
================================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
================================================================================
*/

-- ================= Dimension Customer ===============================
create view gold.dim_customers as
select 
  row_number() over(order by ci.cst_id) as customer_key, -- surrogate key
  ci.cst_id as customer_id,
  ci.cst_key as customer_number, 
  ci.cst_firstname as first_name, 
  ci.cst_lastname as last_name, 
  cl.cntry as country,
  ci.cst_marital_status as marital_status, 
  case 
  	when ci.cst_gndr != 'n/a' then ci.cst_gndr -- CRM is the master source system 
  	else coalesce(ca.gen,'n/a')
  end as gender,
  ca.bdate as birthdate,
  ci.cst_create_date as create_date
from  silver.crm_cust_info as ci
left join silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 as cl
on ci.cst_key = cl.cid

-- ======================= Dimension Products ==========================
create view gold.dim_products as 
select 
    row_number() over(order by pn.prd_id) as product_key,
	pn.prd_id as product_id, 
	pn.prd_key as product_number, 
	pn.prd_nm as product_name,
	pn.cat_id as category_id, 
	pc.cat as category,
	pc.subcat as subcategory,
	pc.maintenance as maintenance,
	pn.prd_cost as cost, 
	pn.prd_line as product_line, 
	pn.prd_start_dt as start_date
from 
silver.crm_prd_info as pn
left join silver.erp_px_cat_g1v2 as pc
on pn.cat_id = pc.id
where prd_end_dt is null -- filter out historical data.


-- ======================== Fact Sales ===================================

create view gold.fact_sales as 
select 
  sd.sls_ord_num as order_number,
  cu.customer_key,
  pr.product_key,
  sd.sls_order_dt as order_date, 
  sd.sls_ship_dt as shipping_date, 
  sd.sls_due_dt as due_date, 
  sd.sls_sales as sales, 
  sd.sls_quantity as quantity, 
  sd.sls_price as price
from 
silver.crm_sales_details as sd
left join gold.dim_customers as cu 
on sd.sls_cust_id = cu.customer_id
left join gold.dim_products as pr
on sd.sls_prd_key = pr.product_number;

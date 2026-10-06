create or alter procedure silver.load_silver as
begin
  begin try
        
		declare @start_time datetime , @end_time datetime , @batch_start_time datetime , @batch_end_time datetime;
		
		-- batch time calc start
		set @batch_start_time = getdate();
		print '========================';
		print 'Loading silver Layer....';
		print '========================';


	


  -- ======================= For CRM ===================================================
	    print 'Loading CRM Tables....'

 -- ===========================  silver.crm_cust_info ==================================
	    -- for crm cust info table
	
		set @start_time = getdate();
	
		
		print 'Truncating Table: silver.crm_cust_info'
		truncate  table silver.crm_cust_info

		print 'Inserting Data Into: silver.crm_cust_info'
		insert into silver.crm_cust_info(
        cst_id, 
		cst_key, 
		cst_firstname, 
		cst_lastname, 
		cst_marital_status, 
		cst_gndr, 
		cst_create_date
		)

		select
		cst_id, 
		cst_key, 
		TRIM(cst_firstname), -- Remove unwanted spaces 
		TRIM(cst_lastname), 

		case 
			when upper(trim(cst_marital_status)) = 'S' then 'Single' -- Data Normalization/standardization
			when upper(trim(cst_marital_status)) = 'M' then 'Married'
			else 'n/a'
		end as cst_marital_status, 


		case 
			when upper(trim(cst_gndr)) = 'M' then 'Male' -- Data Normalization/standardization
			when upper(trim(cst_gndr)) = 'F' then 'Female'
			else 'n/a'  -- handle missing values 
		end as cst_gndr, 

		cst_create_date 

		from  -- Remove duplicates
		( 
		select *,   
		row_number() over(partition by cst_id order by cst_create_date  desc ) as flag_last
		from bronze.crm_cust_info  
		) t where flag_last = 1 ; -- select the most recent record per customer.


		set @end_time = getdate();
		print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
		



-- ====================================silver.crm_prd_info ============================
        -- for crm prd info table
		set @start_time = getdate();
		
		
		print 'Truncating Table: silver.crm_prd_info '
		truncate  table silver.crm_prd_info

		print 'Inserting Data Into: silver.crm_prd_info'

		insert into silver.crm_prd_info ( 

		prd_id, 
		cat_id, 
		prd_key, 
		prd_nm, 
		prd_cost, 
		prd_line, 
		prd_start_dt, 
		prd_end_dt
		)

		select 

		prd_id,  
 
		REPLACE( SUBSTRING(prd_key , 1, 5) ,'-' , '_') as cat_id, -- Extract category id from prd_key
		SUBSTRING(prd_key , 7 , len(prd_key) ) as prd_key , -- Extract prd_key from prd_key
		prd_nm, 

		ISNULL(prd_cost,0) as prd_cost, -- handles missing values in cost

		case UPPER(TRIM(prd_line))  -- map prd_line with proper category names
			when 'R' then 'Road'
			when 'S' then 'Other Sales'
			when 'M' then 'Mountain'
			when 'T' then 'Touring'
			else 'n/a'
		end as prd_line,
		cast(prd_start_dt as date) as prd_start_dt,  -- cast start_date as date from date time
		Cast(lead(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as date)as prd_end_dt -- derive end date from start date

		from bronze.crm_prd_info;

		set @end_time = getdate();
		print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
		

		




-- ================================ silver.crm_sales_details ========================= 
        -- for crm sales details table
        set @start_time = getdate();

        
		print 'Truncating Table: silver.crm_sales_details'
		truncate  table silver.crm_sales_details

		print 'Inserting Data Into: silver.crm_sales_details'

		insert into silver.crm_sales_details
		(
		sls_ord_num, 
		sls_prd_key, 
		sls_cust_id, 
		sls_order_dt, 
		sls_ship_dt, 
		sls_due_dt, 
		sls_sales, 
		sls_quantity, 
		sls_price
		)


		select 
		sls_ord_num, 
		sls_prd_key, 
		sls_cust_id, 
		case 
			when sls_order_dt = 0 or len(sls_order_dt) !=8 then null
			else  cast(cast(sls_order_dt as varchar) as date)
		end as sls_order_dt,



		case 
			when sls_ship_dt = 0 or len(sls_ship_dt) !=8 then null
			else  cast(cast(sls_ship_dt as varchar) as date)
		end as sls_ship_dt,

		case 
			when sls_due_dt = 0 or len(sls_due_dt) !=8 then null
			else  cast(cast(sls_due_dt as varchar) as date)
		end as sls_due_dt,

		case 
		when sls_sales is null or  sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price) 
				 then abs(sls_price) * sls_quantity
		   else sls_sales
		end as sls_sales,

		sls_quantity, 


		case 
		when sls_price is null or sls_price != 0 
				 then sls_sales / nullif(sls_quantity,0)
		   else sls_price
		end as sls_price



		from 
		bronze.crm_sales_details

		set @end_time = getdate();
		print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
		


		
 -- ================= FOR ERP tables ==================================================
		print 'Loading ERP Tables....';

--  ================================== silver.erp_cust_az12 ============================
        -- for erp_cust_az12
		set @start_time = getdate();
		
        print 'Truncating Table: silver.erp_cust_az12'
		truncate  table silver.erp_cust_az12

		print 'Inserting Data Into: silver.erp_cust_az12'


		insert into silver.erp_cust_az12(
		cid, 
		bdate, 
		gen

		)


		select 

		-- Remove 'NAS' prefix if present 
		case
		when cid  like '%NAS%' 
			then substring(cid,4,len(cid))
			else cid 
		end as cid,


		-- no invalid dates (bdate greater than today)
		case 
		when bdate > getdate()
			 then null
			 else bdate
		end as bdate,

		-- Normalize gender values and handle unknown cases 
		case 
			when upper(trim(gen)) in ('F', 'FEMALE') then 'Female' 
			when upper(trim(gen)) in ('M', 'MALE') then 'Male'
			else 'n/a'
		end as gen

		from bronze.erp_cust_az12;

		set @end_time = getdate();
		print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
		





--  ============================  silver.erp_loc_a101 ===============================
       	-- for erp_loc_a101
		set @start_time = getdate();
	     
		print 'Truncating Table: silver.erp_loc_a101'
		truncate  table silver.erp_loc_a101

		print 'Inserting Data Into: silver.erp_loc_a101'


		insert into silver.erp_loc_a101
		(cid, cntry)
		select
		replace(cid, '-', '') cid,
		case
			when trim(cntry) = 'de' then 'germany'
			when trim(cntry) in ('us', 'usa') then 'united states'
			when trim(cntry) = '' or cntry is null then 'n/a'
			else trim(cntry)
		end as cntry
		from bronze.erp_loc_a101;

		set @end_time = getdate();
		print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
		


--  ========================  silver.erp_px_cat_g1v2 =====================================
        
		-- for erp_px_cat_g1v2
		set @start_time = getdate();
		
        print 'Truncating Table: silver.erp_px_cat_g1v2'
		truncate  table silver.erp_px_cat_g1v2

		print 'Inserting Data Into: silver.erp_px_cat_g1v2'


		insert into silver.erp_px_cat_g1v2
		(
		id, cat, subcat, maintenance
		)

		select 
		id, cat, subcat, maintenance

		from 
		bronze.erp_px_cat_g1v2;

		set @end_time = getdate();
		print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
		
		


		-- batch time calculation end 
		set @batch_end_time = getdate();
		print 'Loading Duration for silver layer: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
	
	
	
	
	end try
	    
		 
		 
		 begin catch
		  print 'ERROR occured during loading data into silver layer!!';
		  print 'Error:' + error_message() ;
		  print 'Error:' + cast(error_number() as nvarchar) ;
	     end catch


end;

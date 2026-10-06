/* 
=======================================================
Stored Procedure: Load Bronze Layer (source ==> Bronze)
========================================================

script Purpose:
loads data into bronze layer from source(external .csv files).
it uses the method truncate and insert.
uses the "bulk insert" cmd to load the entire data in one go.

example usage:
exec bronze.load_bronze;
*/



create or alter procedure bronze.load_bronze as
begin

begin try  
        
		declare @start_time datetime , @end_time datetime , @batch_start_time datetime , @batch_end_time datetime;
		
		-- batch time calc start
		set @batch_start_time = getdate();
		print '========================';
		print 'Loading Bronze Layer....';
		print '========================';


	


			-- ======================= For CRM ================================
			print 'Loading CRM Tables....'

		
			-- for crm cust info table
			set @start_time = getdate();
			print 'Inserting data into bronze.crm_cust_info....'
		
			truncate table bronze.crm_cust_info;
			bulk insert bronze.crm_cust_info
			from 'C:\Users\mayur\OneDrive\Desktop\DataWareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with (
			   first_row = 2,
			   fieldterminator = ',',
			   tablock
			); 
			set @end_time = getdate();
			print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
			print '-------------------------------------------------------'
		
		
		
		
			-- for crm prd info table 
			set @start_time = getdate();
			print 'Inserting data into bronze.crm_prd_info....'
		
			truncate table bronze.crm_prd_info;

			bulk insert bronze.crm_prd_info
			from 'C:\Users\mayur\OneDrive\Desktop\DataWareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with (
			   first_row = 2,
			   fieldterminator = ',',
			   tablock
			); 
			set @end_time = getdate();
			print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
			print '-------------------------------------------------------'
		

		
		
		
			-- for crm sales details table
			set @start_time = getdate();
			print 'Inserting data into bronze.crm_sales_details....'

			truncate table bronze.crm_sales_details;

			bulk insert bronze.crm_sales_details
			from 'C:\Users\mayur\OneDrive\Desktop\DataWareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with (
			   first_row = 2,
			   fieldterminator = ',',
			   tablock
			); 
			set @end_time = getdate();
			print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
			print '-------------------------------------------------------'
		


		
		
			-- ================= FOR ERP tables ===========================
			print 'Loading ERP Tables....';

		

			-- for erp_cust_az12
			set @start_time = getdate();
			print 'Inserting data into bronze.erp_cust_az12....'
			truncate table bronze.erp_cust_az12;

			bulk insert bronze.erp_cust_az12
			from 'C:\Users\mayur\OneDrive\Desktop\DataWareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			with (
			   first_row = 2,
			   fieldterminator = ',',
			   tablock
			); 
			set @end_time = getdate();
			print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
			print '-------------------------------------------------------'
		

		
			-- for erp_loc_a101
			set @start_time = getdate();
			print 'Inserting data into bronze.erp_loc_a101....'
			truncate table bronze.erp_loc_a101;

			bulk insert bronze.erp_loc_a101
			from 'C:\Users\mayur\OneDrive\Desktop\DataWareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			with (
			   first_row = 2,
			   fieldterminator = ',',
			   tablock
			); 
			set @end_time = getdate();
			print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
			print '-------------------------------------------------------'
		
		
		
		
		
			-- for erp_px_cat_g1v2
			set @start_time = getdate();
			print 'Inserting data into bronze.erp_px_cat_g1v2....'
			truncate table bronze.erp_px_cat_g1v2;

			bulk insert bronze.erp_px_cat_g1v2
			from 'C:\Users\mayur\OneDrive\Desktop\DataWareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			with (
			   first_row = 2,
			   fieldterminator = ',',
			   tablock
			); 
			set @end_time = getdate();
			print 'Loading Duration: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
			print '-------------------------------------------------------'
		
		
		
		
		-- batch time calculation end 
		set @batch_end_time = getdate();
		print 'Loading Duration for bronze layer: ' + cast(datediff(second, @start_time , @end_time) as varchar) + 'secs.'
		print '-------------------------------------------------------'
end try
      
	  
	  begin catch
		  print 'ERROR occured during loading data into bronze layer!!';
		  print 'Error:' + error_message() ;
		  print 'Error:' + cast(error_number() as nvarchar) ;
	  end catch


end;

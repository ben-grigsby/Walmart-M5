/*
==================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==================================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters:
    None.
  This stored procedure does not accept any parameterse or return any values. 

Usage Example:
    EXEC bronze.load_bronze;
==================================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===========================================';

		PRINT '-------------------------------------------';
		PRINT 'Loading Walmart M5 Tables';
		PRINT '-------------------------------------------';

		SET @start_time = GETDATE();
		--Importing the calendar data 
		PRINT '>> Truncating Table: bronze.calendar'
		TRUNCATE TABLE bronze.calendar; --wipes the table clean so we can then load data
	
		PRINT '>> Inserting Data Into: bronze.calendar'
		BULK INSERT bronze.calendar
		FROM 'C:\Users\22beng\Desktop\Walmart_M5\data\calendar.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', --chooses how to differentiate different columns from each other 
			ROWTERMINATOR = '0x0a',
			TABLOCK --improves performance
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds. ' + CAST(DATEDIFF(second, @start_time, @end_time) / 60 AS NVARCHAR) + ' minutes ' + CAST(DATEDIFF(second, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds.';
		PRINT '-------------------------'

		SET @start_time = GETDATE();
		--Importing the sales_train_evaluation data
		PRINT '>> Truncating Table: bronze.sales_train_evaluation'
		TRUNCATE TABLE bronze.sales_train_evaluation;

		PRINT '>> Inserting Data Into: bronze.sales_train_evaluation'
		BULK INSERT bronze.sales_train_evaluation
		FROM 'C:\Users\22beng\Desktop\Walmart_M5\data\sales_evaluation_melted.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds. ' + CAST(DATEDIFF(second, @start_time, @end_time) / 60 AS NVARCHAR) + ' minutes ' + CAST(DATEDIFF(second, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds.';

		PRINT '-------------------------'

		SET @start_time = GETDATE();
		--Importing the sales_train_validation data
		PRINT '>> Truncating Table: bronze.sales_train_validation'
		TRUNCATE TABLE bronze.sales_train_validation

		PRINT '>> Inserting Data Into: bronze.sales_train_validation'
		BULK INSERT bronze.sales_train_validation
		FROM 'C:\Users\22beng\Desktop\Walmart_M5\data\sales_validation_melted.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds. ' + CAST(DATEDIFF(second, @start_time, @end_time) / 60 AS NVARCHAR) + ' minutes ' + CAST(DATEDIFF(second, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds.';
		PRINT '-------------------------';

		SET @start_time = GETDATE();
		--Importing the sell_price data
		PRINT '>> Truncating Table: bronze.sell_price'
		TRUNCATE TABLE bronze.sell_price

		PRINT '>> Inserting Data Into: bronze.sell_price'
		BULK INSERT bronze.sell_price
		FROM 'C:\Users\22beng\Desktop\Walmart_M5\data\sell_prices.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds. ' + CAST(DATEDIFF(second, @start_time, @end_time) / 60 AS NVARCHAR) + ' minutes ' + CAST(DATEDIFF(second, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds.';
		PRINT '-------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '========================================'
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '>> Batch Duration:  ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds. ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) / 60 AS NVARCHAR) + ' minutes ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) % 60 AS NVARCHAR) + ' seconds.';
		PRINT '========================================'
	END TRY
	BEGIN CATCH
		PRINT '=================================='
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=================================='
	END CATCH
END

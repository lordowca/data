/*
Purpose: This stored procedure loads data from CSV files into the bronze layer tables of the data warehouse.
It truncates existing data in each table and performs bulk inserts for CRM (orders, order items, refunds, products)
and WEB (website pageviews, sessions) data sources. The procedure logs the start and end times for each load operation.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
    @BasePath NVARCHAR(500)
AS
BEGIN
    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @sql NVARCHAR(MAX)

    PRINT '===============================================================';
    PRINT 'Starting Bronze Layer Load Process';
    PRINT '===============================================================';

    PRINT '-----------------------------------------------';
    PRINT 'Loading CRM Order Item Refunds';
    PRINT '-----------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating Table: bronze.crm_order_item_refunds';
    TRUNCATE TABLE bronze.crm_order_item_refunds;

    PRINT '>> Inserting Data Into: bronze.crm_order_item_refunds';

    SET @sql = N'
    BULK INSERT bronze.crm_order_item_refunds
    FROM ''' + @BasePath + N'\toy_store\data_sets\crm\order_item_refunds.csv''
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        TABLOCK
        );
    ';
    EXEC sys.sp_executesql @sql

    PRINT ''

    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT ''

    PRINT '-----------------------------------------------';
    PRINT 'Loading CRM Order Items';
    PRINT '-----------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating Table: bronze.crm_order_items';
    TRUNCATE TABLE bronze.crm_order_items;
    PRINT '>> Inserting Data Into: bronze.crm_order_items';

    SET @sql = N'
    BULK INSERT bronze.crm_order_items
    FROM ''' + @BasePath + N'\toy_store\data_sets\crm\order_items.csv''
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        TABLOCK
        );
    ';
    EXEC sys.sp_executesql @sql
    
    PRINT ''
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT ''

    PRINT '-----------------------------------------------';
    PRINT 'Loading CRM Orders';
    PRINT '-----------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating Table: bronze.crm_orders';
    TRUNCATE TABLE bronze.crm_orders;
    PRINT '>> Inserting Data Into: bronze.crm_orders';

    SET @sql = N'
    BULK INSERT bronze.crm_orders
    FROM ''' + @BasePath + N'\toy_store\data_sets\crm\orders.csv''
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        TABLOCK
        );
    ';
    EXEC sys.sp_executesql @sql

    PRINT ''
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT ''

    PRINT '-----------------------------------------------';
    PRINT 'Loading CRM products';
    PRINT '-----------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating Table: bronze.crm_products';
    TRUNCATE TABLE bronze.crm_products;
    PRINT '>> Inserting Data Into: bronze.crm_products';

    SET @sql = N'
    BULK INSERT bronze.crm_products
    FROM ''' + @BasePath + N'\toy_store\data_sets\crm\products.csv''
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        TABLOCK
        );
    ';
    EXEC sys.sp_executesql @sql

    PRINT ''
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT ''

    PRINT '-----------------------------------------------';
    PRINT 'Loading WEB Website Pageviews';
    PRINT '-----------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating Table: bronze.web_website_pageviews';
    TRUNCATE TABLE bronze.web_website_pageviews;
    PRINT '>> Inserting Data Into: bronze.web_website_pageviews';

    SET @sql = N'
    BULK INSERT bronze.web_website_pageviews
    FROM ''' + @BasePath + N'\toy_store\data_sets\web\website_pageviews.csv''
    WITH (
        FIRSTROW = 2,
        FORMAT = ''CSV'',
        ROWTERMINATOR = ''0x0a'',
        TABLOCK
        );
    ';
    EXEC sys.sp_executesql @sql

    PRINT ''
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT ''

    PRINT '-----------------------------------------------';
    PRINT 'Loading WEB Website Sessions';
    PRINT '-----------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating Table: bronze.web_website_sessions';
    TRUNCATE TABLE bronze.web_website_sessions;
    PRINT '>> Inserting Data Into: bronze.web_website_sessions';

    SET @sql = N'
    BULK INSERT bronze.web_website_sessions
    FROM ''' + @BasePath + N'\toy_store\data_sets\web\website_sessions.csv''
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        TABLOCK
        );
    ';
    EXEC sys.sp_executesql @sql

    PRINT ''
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT ''
END
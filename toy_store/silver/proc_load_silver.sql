CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME
    DECLARE @start_time_all DATETIME, @end_time_all DATETIME

    SET @start_time_all = GETDATE();

    PRINT '======================';
    PRINT 'Loading Silver layer';
    PRINT '======================';

    PRINT '----------------------';
    PRINT 'Loading CRM Tables';
    PRINT '----------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating table: silver.crm_order_item_refunds'
    TRUNCATE TABLE silver.crm_order_item_refunds

    PRINT '>> Insert data into crm_order_item_refunds'
    INSERT INTO silver.crm_order_item_refunds
        (
        order_item_refund_id,
        created_at,
        order_item_id,
        order_id,
        refund_amount
        )
    SELECT *
    FROM bronze.crm_order_item_refunds

    SET @end_time = GETDATE();
    PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------'


    SET @start_time = GETDATE();
    PRINT '>> Truncating table: silver.crm_order_items'
    TRUNCATE TABLE silver.crm_order_items

    PRINT '>> Insert data into crm_order_items'
    INSERT INTO silver.crm_order_items
        (
        order_item_id,
        created_at,
        order_id,
        product_id,
        is_primary_item,
        prices_usd,
        cogs_usd
        )
    SELECT 
        order_item_id,
        created_at,
        order_id,
        product_id,
        CASE
            WHEN is_primary_item = 0 THEN 'FALSE'
            WHEN is_primary_item = 1 THEN 'TRUE'
        END AS is_primary_item,
        prices_usd,
        cogs_usd
    FROM bronze.crm_order_items

    SET @end_time = GETDATE();
    PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------'


    SET @start_time = GETDATE();
    PRINT '>> Truncating table: silver.crm_orders'
    TRUNCATE TABLE silver.crm_orders

    PRINT '>> Insert data into crm_orders'
    INSERT INTO silver.crm_orders
        (
        order_id,
        created_at,
        website_session_id,
        user_id,
        primary_product_id,
        item_purchased,
        price_usd,
        cogs_usd
        )
    SELECT *
    FROM bronze.crm_orders

    SET @end_time = GETDATE();
    PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------'

    SET @start_time = GETDATE();
    PRINT '>> Truncating table: silver.crm_products'
    TRUNCATE TABLE silver.crm_products

    PRINT '>> Insert data into crm_products'
    INSERT INTO silver.crm_products
        (
        product_id,
        created_at,
        product_name
        )
    SELECT *
    FROM bronze.crm_products

    SET @end_time = GETDATE();
    PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------'

    PRINT '----------------------';
    PRINT 'Loading WEB Tables';
    PRINT '----------------------';

    SET @start_time = GETDATE();
    PRINT '>> Truncating table: silver.web_website_pageviews'
    TRUNCATE TABLE silver.web_website_pageviews

    PRINT '>> Insert data into web_website_pageviews'
    INSERT INTO silver.web_website_pageviews
        (
        website_pageview_id,
        created_at,
        website_session_id,
        pageview_url
        )
    SELECT *
    FROM bronze.web_website_pageviews

    SET @end_time = GETDATE();
    PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------'

    SET @start_time = GETDATE();
    PRINT '>> Truncating table: silver.web_website_sessions'
    TRUNCATE TABLE silver.web_website_sessions

    PRINT '>> Insert data into web_website_sessions'
    INSERT INTO silver.web_website_sessions
        (
        website_session_id,
        created_at,
        user_id,
        is_repeat_session,
        utm_source,
        utm_campaign,
        utm_content,
        device_type,
        http_referer
        )
    SELECT
        website_session_id,
        created_at,
        user_id,
        CASE
            WHEN is_repeat_session = 0 THEN 'FALSE'
            WHEN is_repeat_session = 1 THEN 'TRUE'
        END AS is_repeat_session,
        CASE
            WHEN utm_source = 'null' THEN 'no source'
            ELSE utm_source
        END AS utm_source,
        CASE
            WHEN utm_campaign = 'null' THEN 'no campaign'
            ELSE utm_campaign
        END AS utm_campaign,
        CASE
            WHEN utm_content = 'null' THEN 'without advertising campaigns'
            WHEN utm_content = 'social_ad_1' THEN 'social media advertising campaign 1'
            WHEN utm_content = 'social_ad_2' THEN 'social media advertising campaign 2'
            WHEN utm_content = 'b_ad_1' THEN 'bsearch media advertising campaign 1'
            WHEN utm_content = 'b_ad_2' THEN 'bsearch media advertising campaign 2'
            WHEN utm_content = 'g_ad_1' THEN 'gsearch media advertising campaign 1'
            WHEN utm_content = 'g_ad_2' THEN 'gsearch media advertising campaign 2'
            ELSE utm_content
        END AS utm_content,
        device_type,
        CASE
            WHEN http_referer = 'null' THEN 'directly'
            ELSE http_referer
        END AS http_referer

    FROM bronze.web_website_sessions

    SET @end_time = GETDATE();
    PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------'


    SET @end_time_all = GETDATE();

    PRINT '*******************************';
    PRINT '>> Load silver layer duration: ' + CAST(DATEDIFF(second, @start_time_all, @end_time_all) AS NVARCHAR) + ' seconds';
    PRINT '*******************************';
END
/*
DDL script for creating bronze layer tables for CRM and web data in the toy store database.

WARNING: This script drops existing tables before creating new ones. Ensure you have backups if needed.

Tables created: crm_order_item_refunds, crm_order_items, crm_orders, crm_products, web_website_pageviews, web_website_sessions.
*/

IF OBJECT_ID('bronze.crm_order_item_refunds', 'U') IS NOT NULL
DROP TABLE bronze.crm_order_item_refunds;
GO

CREATE TABLE bronze.crm_order_item_refunds(
    order_item_refund_id INT,
    created_at DATETIME,
    order_item_id INT,
    order_id INT,
    refund_amount DECIMAL(10,2)
)
GO

IF OBJECT_ID('bronze.crm_order_items', 'U') IS NOT NULL
DROP TABLE bronze.crm_order_items;
GO

CREATE TABLE bronze.crm_order_items(
    order_item_id INT,
    created_at DATETIME,
    order_id INT,
    product_id INT,
    is_primary_item INT,
    prices_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2)
)
GO

IF OBJECT_ID('bronze.crm_orders', 'U') IS NOT NULL
DROP TABLE bronze.crm_orders;
GO

CREATE TABLE bronze.crm_orders(
    order_id INT,
    created_at DATETIME,
    website_session_id INT,
    user_id INT,
    primary_product_id INT,
    item_purchased INT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2)
)
GO

IF OBJECT_ID('bronze.crm_products', 'U') IS NOT NULL
DROP TABLE bronze.crm_products;
GO

CREATE TABLE bronze.crm_products(
    product_id INT,
    created_at DATETIME,
    product_name VARCHAR(255)
)
GO

IF OBJECT_ID('bronze.web_website_pageviews', 'U') IS NOT NULL
DROP TABLE bronze.web_website_pageviews;
GO

CREATE TABLE bronze.web_website_pageviews(
    website_pageview_id INT,
    created_at DATETIME,
    website_session_id INT,
    pageview_url VARCHAR(255)
)
GO

IF OBJECT_ID('bronze.web_website_sessions', 'U') IS NOT NULL
DROP TABLE bronze.web_website_sessions;
GO

CREATE TABLE bronze.web_website_sessions(
    website_session_id INT,
    created_at DATETIME,
    user_id INT,
    is_repeat_session INT,
    utm_source VARCHAR(255),
    utm_campaign VARCHAR(255),
    utm_content VARCHAR(255),
    device_type VARCHAR(255),
    http_referer VARCHAR(255)
)


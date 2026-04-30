-- Check for duplicate or NULL values in the primary key (PK)
-- The expected result of the queries should return zero records. 
SELECT
    order_id,
    COUNT(*)
FROM silver.crm_orders
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL

SELECT
    order_item_id,
    COUNT(*)
FROM silver.crm_order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1 OR order_item_id IS NULL

SELECT
    order_item_refund_id,
    COUNT(*)
FROM silver.crm_order_item_refunds
GROUP BY order_item_refund_id
HAVING COUNT(*) > 1 OR order_item_refund_id IS NULL

SELECT
    website_pageview_id,
    COUNT(*)
FROM silver.web_website_pageviews
GROUP BY website_pageview_id
HAVING COUNT(*) > 1 OR website_pageview_id IS NULL

SELECT
    website_session_id,
    COUNT(*)
FROM silver.web_website_sessions
GROUP BY website_session_id
HAVING COUNT(*) > 1 OR website_session_id IS NULL

-- checking that the data transformations in the tables have been carried out correctly
--  expected result: unique values with no nulls
SELECT DISTINCT is_primary_item FROM silver.crm_order_items
SELECT DISTINCT is_repeat_session FROM silver.web_website_sessions
SELECT DISTINCT utm_source FROM silver.web_website_sessions
SELECT DISTINCT utm_campaign FROM silver.web_website_sessions
SELECT DISTINCT utm_content FROM silver.web_website_sessions
SELECT DISTINCT http_referer FROM silver.web_website_sessions

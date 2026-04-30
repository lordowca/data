SELECT TOP 20
    *
FROM bronze.crm_orders;
SELECT TOP 20
    *
FROM bronze.crm_order_items;
SELECT TOP 20
    *
FROM bronze.crm_products;
SELECT TOP 20
    *
FROM bronze.crm_order_item_refunds
SELECT TOP 20
    *
FROM bronze.web_website_pageviews
SELECT TOP 20
    *
FROM bronze.web_website_sessions

SELECT COUNT(*)
FROM bronze.crm_order_items
SELECT COUNT(*)
FROM bronze.crm_orders

-- Check for duplicate or NULL values in the primary key (PK)
SELECT
    order_id,
    COUNT(*)
FROM bronze.crm_orders
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL

SELECT
    order_item_id,
    COUNT(*)
FROM bronze.crm_order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1 OR order_item_id IS NULL

SELECT
    order_item_refund_id,
    COUNT(*)
FROM bronze.crm_order_item_refunds
GROUP BY order_item_refund_id
HAVING COUNT(*) > 1 OR order_item_refund_id IS NULL

SELECT
    website_pageview_id,
    COUNT(*)
FROM bronze.web_website_pageviews
GROUP BY website_pageview_id
HAVING COUNT(*) > 1 OR website_pageview_id IS NULL

SELECT
    website_session_id,
    COUNT(*)
FROM bronze.web_website_sessions
GROUP BY website_session_id
HAVING COUNT(*) > 1 OR website_session_id IS NULL

--Verification of the relationship between crm_orders and crm_order_items tables in terms of the number of orders
SELECT
    order_id,
    COUNT(*)
FROM bronze.crm_order_items
GROUP BY order_id
ORDER BY COUNT(*) DESC

SELECT *
FROM bronze.crm_orders
WHERE order_id = 10056;
SELECT *
FROM bronze.crm_order_items
WHERE order_id = 10056;


SELECT DISTINCT utm_source
FROM bronze.web_website_sessions
SELECT utm_source, count(*)
FROM bronze.web_website_sessions
GROUP BY utm_source
SELECT *
FROM bronze.web_website_sessions
WHERE utm_source ='NULL'

SELECT user_id, count(*)
FROM bronze.web_website_sessions
GROUP BY user_id
ORDER BY count(*) DESC
SELECT *
FROM bronze.web_website_sessions
WHERE user_id = 231272

SELECT DISTINCT utm_campaign
FROM bronze.web_website_sessions
SELECT utm_campaign, count(*)
FROM bronze.web_website_sessions
GROUP BY utm_campaign
SELECT *
FROM bronze.web_website_sessions
WHERE utm_campaign ='NULL'

SELECT DISTINCT utm_content
FROM bronze.web_website_sessions
SELECT utm_content, count(*)
FROM bronze.web_website_sessions
GROUP BY utm_content
SELECT *
FROM bronze.web_website_sessions
WHERE utm_content ='NULL'

SELECT DISTINCT device_type
FROM bronze.web_website_sessions
SELECT device_type, count(*)
FROM bronze.web_website_sessions
GROUP BY device_type
SELECT *
FROM bronze.web_website_sessions
WHERE device_type ='NULL'

SELECT DISTINCT utm_content
FROM bronze.web_website_sessions
SELECT utm_content, http_referer, count(*)
FROM bronze.web_website_sessions
GROUP BY utm_content, http_referer
SELECT *
FROM bronze.web_website_sessions
WHERE utm_content ='NULL'

SELECT DISTINCT http_referer
FROM bronze.web_website_sessions
SELECT http_referer, count(*)
FROM bronze.web_website_sessions
GROUP BY http_referer
SELECT *
FROM bronze.web_website_sessions
WHERE http_referer ='NULL'

SELECT DISTINCT pageview_url
FROM bronze.web_website_pageviews
SELECT pageview_url, count(*)
FROM bronze.web_website_pageviews
GROUP BY pageview_url
SELECT *
FROM bronze.web_website_pageviews
WHERE pageview_url ='NULL'

SELECT
    t.http_referer,
    COUNT(*)
FROM (

    SELECT
        utm_content,
        http_referer
    FROM bronze.web_website_sessions
    WHERE utm_content = 'Null' and http_referer != 'Null'
) as t
GROUP BY t.http_referer


SELECT TOP 10
    *
FROM silver.web_website_sessions
SELECT TOP 10
    *
FROM silver.web_website_pageviews

SELECT *
FROM silver.web_website_sessions
WHERE utm_source ='NULL'

SELECT *
FROM silver.web_website_sessions
WHERE utm_campaign ='NULL'

SELECT *
FROM silver.web_website_sessions
WHERE http_referer ='NULL'

SELECT TOP 20 *
FROM silver.web_website_sessions
WHERE http_referer ='NULL'

SELECT utm_content, http_referer, count(*)
FROM silver.web_website_sessions
GROUP BY utm_content, http_referer
SELECT TOP 2
    *
FROM silver.web_website_pageviews

SELECT TOP 2
    *
FROM silver.web_website_sessions

SELECT TOP 10
    *
FROM gold.fact_website_pageview

SELECT
    user_id,
    COUNT(*) AS page_view
FROM
    gold.fact_website_pageview
GROUP BY user_id
ORDER BY COUNT(*) DESC

SELECT
    *
FROM gold.fact_website_pageview
WHERE user_id = 273501

SELECT TOP 20
    *
FROM gold.fact_orders
SELECT TOP 20
    *
FROM gold.fact_order_items

SELECT TOP 20
    *
FROM gold.fact_order_item_refunds
WHERE order_id = 9324

SELECT 
    order_id,
    COUNT(*)
FROM gold.fact_order_item_refunds
GROUP BY order_id
ORDER BY COUNT(*) DESC

SELECT * FROM gold.agg_orders
WHERE order_id = 7300

SELECT TOP 20
    *
FROM silver.crm_order_items 
WHERE order_id = 7300

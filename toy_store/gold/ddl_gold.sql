IF OBJECT_ID('gold.fact_website_pageview', 'V') IS NOT NULL
    DROP VIEW gold.fact_website_pageview
GO

CREATE VIEW gold.fact_website_pageview
AS
    SELECT
        wp.website_pageview_id,
        wp.created_at AS pageview_create_date,
        wp.website_session_id,
        wp.pageview_url,
        ws.user_id,
        ws.is_repeat_session,
        ws.utm_content,
        ws.utm_source,
        ws.utm_campaign,
        ws.device_type,
        ws.http_referer
    FROM silver.web_website_pageviews AS wp
        LEFT JOIN silver.web_website_sessions AS ws
        ON wp.website_session_id = ws.website_session_id

GO

IF OBJECT_ID('gold.dim_sessions', 'V') IS NOT NULL
    DROP VIEW gold.dim_sessions
GO

CREATE VIEW gold.dim_sessions
AS
    SELECT *
    FROM silver.web_website_sessions

GO

IF OBJECT_ID('gold.fact_orders', 'V') IS NOT NULL
    DROP VIEW gold.fact_orders
GO

CREATE VIEW gold.fact_orders
AS
    SELECT
        co.order_id,
        co.created_at AS create_date,
        co.user_id,
        co.item_purchased,
        co.price_usd AS order_value,
        co.cogs_usd AS cost_of_goods_sold,
        ws.is_repeat_session,
        ws.utm_content,
        ws.utm_source,
        ws.utm_campaign,
        ws.device_type,
        ws.http_referer
    FROM
        silver.crm_orders AS co
        LEFT JOIN
        silver.web_website_sessions AS ws
        ON co.website_session_id = ws.website_session_id

GO
IF OBJECT_ID('gold.fact_order_items', 'V') IS NOT NULL
    DROP VIEW gold.fact_order_items

GO
CREATE VIEW gold.fact_order_items
AS
    SELECT
        oi.order_item_id,
        oi.created_at AS created_date,
        oi.order_id,
        oi.is_primary_item,
        oi.prices_usd,
        oi.cogs_usd AS cost_of_goods_sold,
        p.product_name
    FROM silver.crm_order_items AS oi
        LEFT JOIN silver.crm_products AS p
        ON oi.product_id = p.product_id

GO

IF OBJECT_ID('gold.fact_order_item_refunds', 'V') IS NOT NULL
    DROP VIEW gold.fact_order_item_refunds
GO

CREATE VIEW gold.fact_order_item_refunds
AS
    SELECT
        oir.order_item_refund_id,
        oir.created_at AS create_date,
        oir.order_item_id,
        oir.order_id,
        oir.refund_amount,
        p.product_name
    FROM silver.crm_order_item_refunds AS oir
        LEFT JOIN silver.crm_order_items AS oi
        ON oir.order_item_id = oi.order_item_id
        LEFT JOIN silver.crm_products AS p
        ON oi.product_id = p.product_id
GO

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products
GO

CREATE VIEW gold.dim_products
AS
    SELECT *
    FROM silver.crm_products
GO

IF OBJECT_ID('gold.agg_orders', 'V') IS NOT NULL
    DROP VIEW gold.agg_orders
GO

CREATE VIEW gold.agg_orders
AS
                        SELECT
            'Total orders' AS measure_typ,
            count(*) AS measure_value
        FROM gold.fact_orders
    UNION ALL
        SELECT 'Total items purchased', SUM(item_purchased)
        FROM gold.fact_orders
    UNION ALL
        SELECT 'Revenue', SUM(order_value)
        FROM gold.fact_orders
    UNION ALL
        SELECT 'Total cost of goods', SUM(cost_of_goods_sold)
        FROM gold.fact_orders
    UNION ALL
        SELECT 'Total refund items', COUNT(*)
        FROM gold.fact_order_item_refunds
GO
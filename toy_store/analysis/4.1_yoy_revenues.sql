WITH
    -- sales data after excluding returns
    CTE_sales_data
    AS
    (
        SELECT
            YEAR(o.create_date) AS year,
            DATENAME(month, o.create_date) AS month,
            o.order_value,
            o.item_purchased
        FROM gold.fact_orders AS o
            LEFT JOIN gold.fact_order_item_refunds AS oir
            ON o.order_id = oir.order_id
        WHERE oir.order_item_refund_id is NULL
    )

-- revenue YOY

SELECT
    year,
    SUM(order_value) AS total_revenue,
    CAST(
        ROUND(
            (SUM(order_value) - LAG(SUM(order_value)) OVER(ORDER BY year))
            / LAG(SUM(order_value)) OVER(ORDER BY year) * 100,
            0)
        AS INT            
    ) AS yoy_growth_procent
FROM CTE_sales_data
GROUP BY year
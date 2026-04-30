WITH
    -- sales data after excluding returns
    CTE_sales_data
    AS
    (
        SELECT
            YEAR(o.create_date) AS year,
            MONTH(o.create_date) AS month_numb,
            DATENAME(month, o.create_date) AS month,
            o.order_value,
            o.item_purchased
        FROM gold.fact_orders AS o
            LEFT JOIN gold.fact_order_item_refunds AS oir
            ON o.order_id = oir.order_id
        WHERE oir.order_item_refund_id is NULL
    )

SELECT
    [year],
    CAST(ROUND(SUM(order_value) / COUNt(*), 2) AS float) AS rpo,
    CAST(ROUND( 
            ((SUM(order_value) / COUNt(*)) - LAG(SUM(order_value) / COUNt(*)) OVER (ORDER BY year) )
                / LAG(SUM(order_value) / COUNt(*)) OVER (ORDER BY year) * 100
                , 2) 
        AS float) AS rpo_growth
FROM CTE_sales_data
GROUP BY [year]

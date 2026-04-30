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
    SUM(order_value) AS Q1_orders_value,
    SUM(order_value)  - LAG(SUM(order_value)) OVER (ORDER BY [year]) AS difference_quarter
FROM CTE_sales_data
WHERE
([year] = 2014 OR [year] = 2015) and month_numb < 4
GROUP BY [year]
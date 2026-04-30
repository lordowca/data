WITH CTE_sessions_in_year AS (
    SELECT 
        DATETRUNC(year, created_at) AS session_year,
        COUNT(*) AS sessions_in_year
    FROM gold.dim_sessions
        GROUP BY DATETRUNC(year, created_at)
),
CTE_orders_in_year AS(
    SELECT 
        DATETRUNC(year, create_date) AS order_year,
        COUNT(*) AS orders_in_year
    FROM gold.fact_orders
    GROUP BY DATETRUNC(year, create_date)

)
SELECT 
    YEAR(cte_sy.session_year) AS year,
    ROUND(CAST(cte_oy.orders_in_year AS Float) / cte_sy.sessions_in_year *100, 1)  AS conversion_rate_procent
FROM CTE_sessions_in_year AS cte_sy
LEFT JOIN CTE_orders_in_year AS cte_oy
ON cte_sy.session_year = cte_oy.order_year
ORDER BY cte_sy.session_year


-- first session
SELECT TOP 1 created_at FROM gold.dim_sessions ORDER BY created_at
-- last session
SELECT TOP 1 created_at FROM gold.dim_sessions ORDER BY created_at DESC

-- conversion rate all dates
SELECT 
(
    SELECT measure_value FROM gold.agg_orders WHERE measure_typ = 'Total orders'
) / COUNT(website_session_id) *100 AS ddd
 FROM gold.dim_sessions



WITH CTE_sessions_by_utm AS (
    SELECT
        utm_content AS campaign_description,
        utm_campaign AS campaign_parameter,
        FORMAT(MIN(created_at), 'yyyy-MM-dd') AS campaign_start,
        FORMAT(Max(created_at), 'yyyy-MM-dd') AS campaign_end,
        COUNT(*) AS session_from_channel
    FROM gold.dim_sessions
    GROUP BY 
        utm_content,
        utm_campaign
),
 CTE_orders_by_utm AS (
    SELECT 
        utm_content,
        COUNT(*) AS orders_from_campaign
    FROM gold.fact_orders
    GROUP BY
        utm_content
)

SELECT 
    cte_s.campaign_description,
    cte_s.campaign_parameter,
    cte_s.campaign_start,
    cte_s.campaign_end,
    cte_s.session_from_channel,
    cte_o.orders_from_campaign,
    ROUND(CAST(cte_o.orders_from_campaign AS float) / cte_s.session_from_channel * 100 , 2) AS conversion_rate_procent
FROM  CTE_sessions_by_utm AS cte_s
LEFT JOIN CTE_orders_by_utm AS cte_o
ON cte_s.campaign_description = cte_o.utm_content
ORDER BY orders_from_campaign DESC



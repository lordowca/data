SELECT
    product_name,
    COUNT(*) AS total_seal
FROM gold.fact_order_items
GROUP BY product_name
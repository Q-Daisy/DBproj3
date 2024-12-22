-- 查询1
EXPLAIN ANALYZE
SELECT f.date_, f.city_name, d.product_name, d.product_type
FROM proj3.fact_sales_apr1 f
JOIN proj3.dim_product d ON f.product_id = d.product_id
WHERE f.date_  = '2022-04-10'
ORDER BY f.unit_selling_price DESC
LIMIT 1000;

-- 查询2
EXPLAIN ANALYZE
SELECT d.product_id, SUM(f.procured_quantity) AS total_sales
FROM fact_sales_apr1 f
JOIN dim_product_2 d ON f.product_id = d.product_id
GROUP BY d.product_id
HAVING SUM(f.procured_quantity) > 20
ORDER BY total_sales DESC;






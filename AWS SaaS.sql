-- 1 What is the total revenue and total profit of the company?
SELECT
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit
FROM fact_sales;

-- 2 How does revenue and profit trend over time (year-wise)?
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit
FROM fact_sales
GROUP BY YEAR(order_date)
ORDER BY order_year;


-- 3 Which products generate the highest revenue?
SELECT
    p.product_name,
    SUM(f.sales) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- 4 Which products generate the highest profit?
SELECT
    p.product_name,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit DESC;


-- 5 Which products have the highest and lowest profit margins?
SELECT
    p.product_name,
    SUM(f.sales) AS total_revenue,
    SUM(f.profit) AS total_profit,
    ROUND(SUM(f.profit) / NULLIF(SUM(f.sales),0) * 100, 2) AS profit_margin_pct
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY profit_margin_pct DESC;


-- 6 Who are the top customers by revenue? 
SELECT
    c.customer_name,
    SUM(f.sales) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;


-- 7 Who are the top customers by profit?
SELECT
    c.customer_name,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_profit DESC;


-- 8 How many unique customers do we have?
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM dim_customers;



-- 9 Which customers place the most orders?
SELECT
    c.customer_name,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;


-- 10 Which industries generate the highest revenue?
SELECT
    c.industry,
    SUM(f.sales) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.industry
ORDER BY total_revenue DESC;


-- 11 Which industries are the most profitable?
SELECT
    c.industry,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.industry
ORDER BY total_profit DESC;


-- 12 Is SMB or Enterprise more profitable?
SELECT
    c.segment,
    SUM(f.sales) AS total_revenue,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_profit DESC;


-- 13 Which countries generate the highest sales?
SELECT
    c.country,
    SUM(f.sales) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;


-- 14 Which regions generate the highest profit?
SELECT
    c.region,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_profit DESC;


-- 15 Do higher discounts lead to lower profit?
SELECT
    f.discount,
    COUNT(*) AS total_orders,
    SUM(f.sales) AS total_revenue,
    SUM(f.profit) AS total_profit,
    AVG(f.profit) AS avg_profit
FROM fact_sales f
GROUP BY f.discount
ORDER BY f.discount;



-- 16 Which products are most frequently sold at a loss?
SELECT
    p.product_name,
    COUNT(*) AS loss_orders,
    SUM(f.profit) AS total_loss
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
WHERE f.profit < 0
GROUP BY p.product_name
ORDER BY loss_orders DESC;


-- 17 Which customers generate the highest losses?
SELECT
    c.customer_name,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING total_profit < 0
ORDER BY total_profit;


-- 18 Which products and industries show the strongest growth over time?
SELECT
    YEAR(f.order_date) AS order_year,
    p.product_name,
    c.industry,
    SUM(f.sales) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY YEAR(f.order_date), p.product_name, c.industry
ORDER BY order_year, total_revenue DESC;

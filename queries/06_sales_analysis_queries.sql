USE grocery_sales;


-- How much revenue in billion (after discount) do we earn each month?

SELECT
  DATE_FORMAT(SalesDate, '%Y-%m') AS month,
  CONCAT(ROUND(SUM(net_sales) / 1000000000, 5), ' B') AS net_revenue
FROM v_sales_enriched
GROUP BY DATE_FORMAT(SalesDate, '%Y-%m')
ORDER BY net_revenue DESC;

-- Which product categories generate the highest net revenue each month (after discount)?

SELECT
  DATE_FORMAT(v.SalesDate, '%Y-%m') AS month,
  c.CategoryName,
  CONCAT(ROUND(SUM(v.net_sales) / 1000000, 2),'M') AS net_revenue
FROM v_sales_enriched v
JOIN categories c
  ON v.CategoryID = c.CategoryID
GROUP BY
  DATE_FORMAT(v.SalesDate, '%Y-%m'),
  c.CategoryName
ORDER BY
  month,
  net_revenue DESC;

-- Which products generate the highest net revenue(in million) after discounts?

SELECT
  v.ProductID,
  v.ProductName,
  SUM(v.Quantity) AS Total_Units_Sold,
  CONCAT(ROUND(SUM(v.net_sales) / 1000000, 2),'M') AS Net_Revenue
  
FROM v_sales_enriched v
GROUP BY
  v.ProductID,
  v.ProductName
ORDER BY
  Net_Revenue DESC
LIMIT 10;

-- Which products generate the least net revenue?
SELECT
  v.ProductID,
  v.ProductName,
  SUM(v.Quantity) AS Total_Units_Sold,
  ROUND(SUM(v.net_sales), 2) AS Net_Revenue
  
FROM v_sales_enriched v
GROUP BY
  v.ProductID,
  v.ProductName
HAVING SUM(v.Quantity) > 0
ORDER BY
  Net_Revenue ASC
LIMIT 10;  



-- Core KPIs (net revenue, transactions, total customers, units sold)


SELECT
  CONCAT(ROUND(SUM(net_sales) / 1000000000, 2),'B') AS net_revenue_billion,
  CONCAT(ROUND(COUNT(DISTINCT TransactionNumber)/1000000,2),'M') AS total_transactions,
  COUNT(DISTINCT CustomerID) AS total_customers,
  CONCAT(ROUND(SUM(Quantity)/1000000,2),'M') AS total_units_sold
FROM sales_enriched;




-- Average basket size (units per transaction)


SELECT
  ROUND(AVG(units_in_order), 2) AS avg_units_per_transaction
FROM (
  SELECT
    TransactionNumber,
    SUM(Quantity) AS units_in_order
  FROM sales_enriched
  GROUP BY TransactionNumber
) t;



-- How many repeat customers do we have?

WITH customer_orders AS (
  SELECT
    CustomerID,
    COUNT(DISTINCT TransactionNumber) AS orders
  FROM sales_enriched
  GROUP BY CustomerID
)
SELECT
  CASE
    WHEN orders = 1 THEN 'One-time'
    ELSE 'Repeat'
  END AS customer_type,
  COUNT(*) AS customers
FROM customer_orders
GROUP BY customer_type;
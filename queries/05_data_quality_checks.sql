USE grocery_sales;

-- 0) Row counts (quick sanity)
-- Row counts confirm imports happened and tables are not empty.

SELECT 'categories' AS table_name, COUNT(*) AS row_count FROM categories
UNION ALL
SELECT 'countries', COUNT(*) FROM countries
UNION ALL
SELECT 'cities', COUNT(*) FROM cities
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'sales_enriched', COUNT(*) FROM sales_enriched;



-- 1) Primary key uniqueness (should return 0 rows)
-- Primary keys must be unique. Duplicates usually mean bad import.

SELECT 'categories' AS table_name, CategoryID, COUNT(*) AS cnt
FROM categories
GROUP BY CategoryID
HAVING COUNT(*) > 1;

SELECT 'countries' AS table_name, CountryID, COUNT(*) AS cnt
FROM countries
GROUP BY CountryID
HAVING COUNT(*) > 1;

SELECT 'cities' AS table_name, CityID, COUNT(*) AS cnt
FROM cities
GROUP BY CityID
HAVING COUNT(*) > 1;

SELECT 'customers' AS table_name, CustomerID, COUNT(*) AS cnt
FROM customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT 'employees' AS table_name, EmployeeID, COUNT(*) AS cnt
FROM employees
GROUP BY EmployeeID
HAVING COUNT(*) > 1;

SELECT 'products' AS table_name, ProductID, COUNT(*) AS cnt
FROM products
GROUP BY ProductID
HAVING COUNT(*) > 1;

SELECT 'sales' AS table_name, SalesID, COUNT(*) AS cnt
FROM sales
GROUP BY SalesID
HAVING COUNT(*) > 1;



-- 2) Null checks on key columns (should be 0)
-- Nulls in key columns break joins and analytics.

SELECT
  SUM(CASE WHEN SalesID IS NULL THEN 1 ELSE 0 END) AS null_salesid,
  SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS null_productid,
  SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customerid,
  SUM(CASE WHEN SalesPersonID IS NULL THEN 1 ELSE 0 END) AS null_salespersonid,
  SUM(CASE WHEN TransactionNumber IS NULL THEN 1 ELSE 0 END) AS null_transactionnumber,
  SUM(CASE WHEN SalesDate IS NULL THEN 1 ELSE 0 END) AS null_salesdate
FROM sales;



-- 3) Foreign key integrity (orphan checks)
-- These should return 0 rows
-- Orphans cause missing data in geography / employee / product analysis.


-- Sales referencing missing products
SELECT COUNT(*) AS orphan_sales_product
FROM sales s
LEFT JOIN products p ON s.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- Sales referencing missing customers
SELECT COUNT(*) AS orphan_sales_customer
FROM sales s
LEFT JOIN customers c ON s.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- Sales referencing missing employees (salesperson)
SELECT COUNT(*) AS orphan_sales_employee
FROM sales s
LEFT JOIN employees e ON s.SalesPersonID = e.EmployeeID
WHERE e.EmployeeID IS NULL;

-- Customers referencing missing cities
SELECT COUNT(*) AS orphan_customer_city
FROM customers cu
LEFT JOIN cities ci ON cu.CityID = ci.CityID
WHERE ci.CityID IS NULL;

-- Cities referencing missing countries
SELECT COUNT(*) AS orphan_city_country
FROM cities ci
LEFT JOIN countries co ON ci.CountryID = co.CountryID
WHERE co.CountryID IS NULL;



-- 4) Value sanity checks (should be 0 or reasonable)
-- Prevents nonsensical values that distort revenue calculations.


-- Quantity should be positive
SELECT COUNT(*) AS bad_quantity_rows
FROM sales
WHERE Quantity <= 0;

-- Discount should be within 0 and 1 (0% to 100%)
SELECT
  MIN(Discount) AS min_discount,
  MAX(Discount) AS max_discount
FROM sales;

-- Discount distribution (helps confirm it’s 0, 0.10, 0.20 like you saw)
SELECT Discount, COUNT(*) AS rows_count
FROM sales
GROUP BY Discount
ORDER BY Discount;



-- 5) Date sanity checks
-- Confirms dataset time range and prevents incorrect time-series results.

SELECT
  MIN(SalesDate) AS min_sales_date,
  MAX(SalesDate) AS max_sales_date
FROM sales;

-- Check for future dates (should be 0)
SELECT COUNT(*) AS future_dates
FROM sales
WHERE SalesDate > NOW();



-- 6) Enriched revenue sanity checks (sales_enriched)

-- Net sales should not be negative (unless discount > 100% or bad price)
-- Confirms your derived calculations are internally consistent.

SELECT COUNT(*) AS negative_net_sales_rows
FROM sales_enriched
WHERE net_sales < 0;

-- Unit price should be positive
SELECT COUNT(*) AS non_positive_price_rows
FROM sales_enriched
WHERE unit_price <= 0;

-- Quick check: net_sales = gross_sales - discount_amount (should match)
SELECT COUNT(*) AS mismatch_rows
FROM sales_enriched
WHERE ABS((gross_sales - discount_amount) - net_sales) > 0.0001;



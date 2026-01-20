USE grocery_sales;

CREATE OR REPLACE VIEW v_sales_enriched AS
SELECT
  s.SalesID,
  s.TransactionNumber,
  s.SalesDate,
  s.SalesPersonID,
  s.CustomerID,
  s.ProductID,
  s.Quantity,
  s.Discount,

  p.ProductName,
  p.Price AS unit_price,
  p.CategoryID,

  (s.Quantity * p.Price) AS gross_sales,
  (s.Quantity * p.Price) * s.Discount AS discount_amount,
  (s.Quantity * p.Price) * (1 - s.Discount) AS net_sales

FROM sales s
JOIN products p
  ON s.ProductID = p.ProductID;

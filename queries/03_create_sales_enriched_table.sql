USE grocery_sales;

DROP TABLE IF EXISTS sales_enriched;

CREATE TABLE sales_enriched AS
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
  ON p.ProductID = s.ProductID;


CREATE INDEX idx_se_txn ON sales_enriched(TransactionNumber);
CREATE INDEX idx_se_customer ON sales_enriched(CustomerID);
CREATE INDEX idx_se_product ON sales_enriched(ProductID);
CREATE INDEX idx_se_salesperson ON sales_enriched(SalesPersonID);
CREATE INDEX idx_se_salesdate ON sales_enriched(SalesDate);
CREATE INDEX idx_se_category ON sales_enriched(CategoryID);
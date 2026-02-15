# Database Schema – Grocery Sales Analytics

This database follows a relational star-style structure centered on sales transactions.

---

## Core Fact Table

### sales
Contains all transactional purchase records.

Key columns:
- SalesID (Primary Key)
- SalesPersonID (FK → employees)
- CustomerID (FK → customers)
- ProductID (FK → products)
- Quantity
- Discount
- SalesDate
- TransactionNumber

---

## Dimension Tables

### products
- ProductID (PK)
- ProductName
- Price
- CategoryID (FK → categories)

### categories
- CategoryID (PK)
- CategoryName

### customers
- CustomerID (PK)
- FirstName
- LastName
- CityID (FK → cities)

### employees
- EmployeeID (PK)
- FirstName
- LastName
- CityID (FK → cities)

### cities
- CityID (PK)
- CityName
- CountryID (FK → countries)

### countries
- CountryID (PK)
- CountryName
- CountryCode

---

## Analytics Layer

### v_sales_enriched (view)
Calculates net_sales after discount and joins key descriptive attributes.

### sales_enriched (materialized table)
Optimized analytical table used for all KPI and business queries.

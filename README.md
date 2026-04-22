# Grocery Sales SQL Analysis

SQL-based business analytics project using a large-scale Grocery Sales dataset (MySQL).

---

## Project Overview

This project analyzes a high-volume transactional grocery database containing:

- **6.69 million** sales transactions  
- **98,759 customers**  
- **452 products**  
- **23 sales employees**  
- Multi-city geographic coverage  

The goal is to turn raw relational data into business insights using SQL (joins, aggregations, CTEs), data quality checks, and performance-optimized analytics tables.

---

## Results Snapshot (KPIs)

| KPI | Value |
|---|---|
| Total Net Revenue | ~$4.29 Billion |
| Total Transactions | 6.69 Million |
| Total Customers | 98,759 |
| Total Units Sold | ~87 Million |
| Average Basket Size | ~13 Units |

➡ Full business write-up: **[insights.md](./insights.md)**

---

## Dataset & Schema

The database contains 7 core tables:

- `sales`
- `products`
- `categories`
- `customers`
- `employees`
- `cities`
- `countries`

To support analytics at scale, the project creates:

- `v_sales_enriched` (view for net sales calculations)
- `sales_enriched` (materialized table for faster analysis on 6.6M rows)

## SQL Workflow (Run Order)

### 1) Database & Table Creation
- **[01_create_database.sql](queries/01_create_database.sql)**
- **[02_create_tables.sql](queries/02_create_tables.sql)**

### 2) Analytics Layer
- **[04_create_view_sales_enriched.sql](queries/04_create_view_sales_enriched.sql)**
- **[03_create_sales_enriched_table.sql](queries/03_create_sales_enriched_table.sql)**

### 3) Data Validation
- **[05_data_quality_checks.sql](queries/05_data_quality_checks.sql)**

### 4) Business Analysis
- **[06_sales_analysis_queries.sql](queries/06_sales_analysis_queries.sql)**

---

## Business Questions Answered

- How does **monthly net revenue** change over time?
- Which **categories** generate the highest net revenue each month?
- What are the **top and bottom products** by net revenue?
- What are the core **KPIs** (revenue, transactions, customers, units sold)?
- What is the **average basket size** (units per transaction)?
- Are customers mostly **repeat buyers**?
- Who are the **VIP customers** by net spend?
- Which **salespeople** generate the most net revenue?
- Which **cities** generate the highest net revenue?

---

## Performance Notes

The `sales` table contains ~6.6M rows. To avoid slow joins and MySQL timeouts during aggregation, this project uses a **materialized** analytics table (`sales_enriched`) to improve query performance.

---

## Power BI Dashboard

This project also includes a Power BI dashboard built on top of the SQL analysis.

The dashboard contains 5 interactive pages:
- Executive Summary
- Revenue & Trends Analysis
- Customer Analytics & Behavior
- Performance Analysis – Sales Team & Geography
- Product Intelligence & Category Analysis

➡ Full dashboard documentation: [DASHBOARD.md](./DASHBOARD.md)

---

## Skills Demonstrated

- SQL joins and relational data modeling  
- Data quality validation and integrity checks  
- KPI design and business metric calculation  
- Analytical views and materialized tables  
- Query optimization for large datasets  
- Business insight generation using SQL  
- Dashboard development in Power BI  
- Business reporting and data storytelling 

---

## Repository Structure

```txt
grocery-sales-sql-analysis/
├── README.md
├── insights.md
├── DASHBOARD.md
├── .gitignore
├── data/
│   └── README.md
├── queries/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_create_sales_enriched_table.sql
│   ├── 04_create_view_sales_enriched.sql
│   ├── 05_data_quality_checks.sql
│   └── 06_sales_analysis_queries.sql
├── dashboard/
│   └── screenshots/
│       ├── 1_executive_summary.png
│       ├── 2_revenue_trends.png
│       ├── 3_customer_analytics.png
│       ├── 4_performance_analysis.png
│       └── 5_product_category_analysis.png
└── schema/
    └── README.md


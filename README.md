# AWS_SaaS_sql_revenue_analysis

##  Project Overview
This project analyzes an AWS SaaS Sales dataset to understand how a SaaS business generates revenue, profit, and customer value. The goal is to simulate how a Business Analyst, Product Analyst, or Revenue Operations team would analyze a SaaS business using SQL.

Dataset Source (Kaggle):  
https://www.kaggle.com/datasets/nnthanh101/aws-saas-sales/data  

---

##  Dataset Description
The original dataset contains transactional SaaS sales data including:
- Orders, dates, revenue, profit, and discounts  
- Customer information (industry, segment, geography)  
- Product and license details  

Originally, all information was stored in a single flat table. To make the analysis more realistic and scalable, the dataset was restructured into a star-schema model with multiple tables.

---

##  Data Modeling (Star Schema Design)

The original dataset was split into three tables:

### 1. fact_sales (Transaction Table)
Stores what happened in each sale:
- order_id  
- order_date  
- customer_id  
- product_id  
- sales  
- quantity  
- discount  
- profit  

### 2. dim_customers (Customer Dimension)
Stores who the customer is:
- customer_id  
- customer_name  
- contact_name  
- industry  
- segment (SMB / Enterprise)  
- country  
- region  
- subregion  
- city  

### 3. dim_products (Product Dimension)
Stores what the company sells:
- product_id  
- product_name  
- license_type  

This design enables efficient join-based analysis similar to real SaaS data warehouses (Snowflake, BigQuery, Redshift).

---

##  Tools & Skills Used
- SQL (Joins, Group By, Aggregations, Filtering, Date Functions)
- Data Modeling (Fact & Dimension Tables)
- Business & Revenue Analysis
- Product and Customer Performance Analysis

---

##  Why This Project Matters
This project demonstrates the ability to:
- Work with real-world SaaS sales data  
- Design a professional data model  
- Perform join-based SQL analysis  
- Translate raw data into business insights  

This mirrors the type of analysis performed by Business Analysts, Product Analysts, and Revenue Operations teams in SaaS companies.

---

##  Data Source
AWS SaaS Sales Dataset from Kaggle:  
https://www.kaggle.com/datasets/nnthanh101/aws-saas-sales/data

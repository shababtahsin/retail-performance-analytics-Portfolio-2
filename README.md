# 📊 Sample Superstore — Retail Performance Analytics

![SQL Server](https://img.shields.io/badge/SQL%20Server-SSMS-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

## Project Overview

This project analyses the **Sample Superstore** retail dataset to understand where sales are coming from, which areas are profitable, where losses are occurring, and how discounting relates to profitability.

The dataset contains **9,994 retail records** covering sales, profit, quantity, discount, customer segment, geography, product category and shipping method.

I used **SQL Server** for data validation, exploratory analysis, segmentation and reusable reporting logic, then built a **Power BI report** to present the main findings.

The main business problem was simple:

> **High sales do not always mean strong profitability.**

The analysis therefore focuses on finding the regions, categories, sub-categories and discount levels where revenue is being generated without enough profit.

---

## 🎯 Business Questions

The project was built around several practical questions:

- Which regions generate the most sales and profit?
- Which categories and sub-categories perform best?
- Where is the business losing money?
- How does discounting relate to profitability?
- Which customer segments generate the most activity and value?
- Which states and cities contribute most to performance?
- Which shipping methods are used most often?
- Where do high sales hide weak margins?

---

## 📊 Dataset

**Source:** Sample Superstore public retail dataset

| Metric | Value |
|---|---:|
| Records | **9,994** |
| Columns | **13** |
| Total Sales | **$2.30M** |
| Total Profit | **$286.40K** |
| Overall Profit Margin | **12.47%** |
| Units Sold | **37,873** |
| Loss-Making Records | **1,871** |
| Loss Record Rate | **18.72%** |

### Source Columns

- Ship Mode
- Segment
- Country
- City
- State
- Postal Code
- Region
- Category
- Sub-Category
- Sales
- Quantity
- Discount
- Profit

---

## 🧹 Data Validation & Cleaning

Before analysing the dataset, I checked the source for data-quality problems.

The main checks included:

- checking all 13 columns for missing values
- reviewing categorical values for consistency
- inspecting possible duplicate records
- validating numeric fields such as sales, profit and discount
- using `TRIM()`, `REPLACE()`, `CAST()` and other SQL functions during cleaning exercises
- using `NULLIF()` in calculations to protect against divide-by-zero errors

### Duplicate Handling

The dataset does not contain a reliable transaction or order ID.

Some rows share the same values across fields such as city, state, category, sales and profit, but this is **not enough evidence to prove that they are duplicate transactions**.

For that reason, the final portfolio findings use the full **9,994-row source population** rather than removing records based on an incomplete duplicate key.

This avoids accidentally deleting legitimate sales records.

---

## ⏱️ Note About Dates

The original dataset used in this project does **not contain order or shipping dates**.

Synthetic `Order_Date` and `Ship_Date` fields were created in SQL for practice with:

- date functions
- monthly aggregation
- quarterly aggregation
- `LAG()` and `LEAD()`
- moving between previous and next periods
- time-intelligence concepts

These generated dates are **not real historical transaction dates**.

For that reason, monthly trends, YTD calculations, MoM growth and shipping-duration calculations are treated as **technical exercises rather than business findings**.

The main conclusions in this README are based only on the original sales, profit, discount, geography, product and customer data.

---

## 🔍 Exploratory Data Analysis

### Sales Analysis

The SQL analysis covered:

- total sales
- total profit
- quantity sold
- average sales per record
- sales by region
- sales by category
- sales by segment
- sales by shipping method
- top and bottom states
- sub-category contribution
- sales rankings
- percentage contribution
- running totals

Window functions were used to rank performance and calculate contribution without losing row-level context.

---

### Profitability Analysis

The profitability analysis focused on:

- total profit
- overall margin
- loss-making records
- worst individual losses
- profit by region
- profit by category
- profit by sub-category
- profit margin by business segment
- discount bands
- product groups generating high revenue but weak profit

The central theme was to separate **revenue performance from actual profitability**.

---

### Customer Segment Analysis

The three customer segments were compared:

- Consumer
- Corporate
- Home Office

The analysis looked at:

- number of records
- sales
- profit
- quantity
- average sales value
- discount levels
- margin

Consumer generated the highest overall sales volume, while **Home Office recorded the highest average sales value per record**.

---

## 🧮 SQL Techniques Used

The project includes practical use of:

- `GROUP BY`
- `HAVING`
- `CASE`
- joins
- subqueries
- CTEs
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `LAG()`
- `LEAD()`
- `NTILE()`
- `PERCENTILE_CONT`
- `SUM() OVER()`
- running totals
- percentage-of-total calculations
- `PIVOT`
- `NULLIF()`
- `CAST()`
- string functions
- date functions
- views
- stored procedures
- nonclustered indexes

These techniques were used to answer analytical questions rather than simply demonstrate SQL syntax.

---

## 🗄️ Reusable SQL Objects

### Views

| View | Purpose |
|---|---|
| `vw_master_eda` | Detailed analytical view combining geography, customer, product and performance measures |
| `vw_region_performance` | Region-level sales, profit, discount and margin summary |
| `vw_subcat_profitability` | Sub-category sales, profit, discount and profitability summary |

### Stored Procedures

| Procedure | Parameters | Purpose |
|---|---|---|
| `usp_sales_by_region` | `@Region` | Returns detailed performance for a selected region |
| `usp_category_segment_analysis` | `@Category`, `@Segment`, `@TotalProfit OUTPUT` | Analyses a selected category and customer segment |

### Indexes

The project also tests nonclustered indexes on commonly filtered columns:

```sql
idx_region
idx_category
idx_region_category
idx_state
idx_segment
```

These were included to practise query-performance concepts and indexing strategy.

---

# 💡 Key Findings

## 🟢 1. West Was the Strongest Region

West generated approximately:

- **$725.46K sales**
- **$108.42K profit**

This made it the strongest region for both sales and profit.

However, regional sales alone do not explain profitability, so margin and discount behaviour were also considered.

---

## 🟠 2. Central Generated Revenue but Weaker Profitability

Central produced approximately:

- **$501.24K sales**
- **$39.71K profit**

This is substantially less profit than West and East despite generating a meaningful amount of revenue.

The result shows why sales should not be used as the only measure of regional performance.

---

## 🔴 3. Furniture Generated High Sales but Very Little Profit

Furniture produced approximately:

- **$742.00K sales**
- **$18.45K profit**

That represents a profit margin of only around **2.5%**.

Furniture therefore generated substantial revenue but retained relatively little profit compared with the other categories.

---

## 🚨 4. Tables, Bookcases and Supplies Were Loss-Making

Three sub-categories produced negative total profit:

| Sub-Category | Approx. Profit |
|---|---:|
| Tables | **-$17.63K** |
| Bookcases | **-$3.40K** |
| Supplies | **-$1.22K** |

Tables were the largest loss-making sub-category.

These areas would be reasonable candidates for further investigation into pricing, discount levels, cost structure and product mix.

---

## 💸 5. Higher Discounts Were Associated With Lower Profitability

Profitability deteriorated substantially as discount levels increased.

| Discount Band | Approx. Profit | Margin |
|---|---:|---:|
| No Discount | **$317.93K** | **29.45%** |
| 1–20% | **$100.14K** | **12.00%** |
| 21–40% | **-$35.51K** | **-15.33%** |
| 41–60% | **-$28.93K** | **-40.74%** |
| >60% | **-$70.54K** | **-122.62%** |

The dataset therefore shows a strong **association between deeper discounts and poorer profitability**.

This does not prove that discounting alone caused the losses, because factors such as product mix and regional behaviour may also contribute.

However, discounting is clearly an area worth reviewing.

---

## 💻 6. Technology Was the Strongest Category

Technology generated approximately:

- **$836.15K sales**
- **$145.45K profit**
- **17.4% profit margin**

It produced both the highest sales and the highest profit of the three main categories.

This contrasts strongly with Furniture, which generated substantial sales but a much weaker margin.

---

## 👥 7. Customer Segments Behaved Differently

Consumer was the largest customer segment:

| Segment | Approx. Sales | Approx. Profit | Avg Sales Value |
|---|---:|---:|---:|
| Consumer | **$1.16M** | **$134.12K** | **$223.73** |
| Corporate | **$706.15K** | **$91.98K** | **$233.82** |
| Home Office | **$429.65K** | **$60.30K** | **$240.97** |

Consumer generated the highest overall sales and transaction volume.

However, **Home Office had the highest average sales value per record**, followed by Corporate.

This shows that the largest customer segment is not necessarily the segment with the highest individual transaction value.

---

## 🚚 8. Standard Class Dominated Shipping

Standard Class appeared in **5,968 of the 9,994 records**, representing approximately **59.7%** of the dataset.

It was therefore by far the most commonly used shipping method.

Because the source dataset contains no real shipping dates, the project does not draw operational conclusions about shipping speed.

---

# 🎯 Main Business Takeaway

The clearest conclusion from the project is:

> **High sales can hide weak profitability.**

West performed strongly on both sales and profit, while Technology produced the strongest category-level performance.

However, Furniture generated approximately **$742K in sales while producing only $18K in profit**, and several sub-categories were loss-making.

Discount analysis also showed that profitability became progressively weaker as discount levels increased.

The main areas worth reviewing are therefore:

1. **Furniture profitability**
2. **Tables, Bookcases and Supplies**
3. **high-discount transactions**
4. **regional differences in margin**
5. **customer segments with different volume and value patterns**

---

# 📈 Power BI Report

The Power BI report turns the SQL analysis into an interactive reporting layer.

The report contains four main analytical pages plus a drill-through page.

---

## 1. Executive Summary

![Executive Summary](screenshots/01.dashboard_executive_summary)

The executive page presents the main KPIs and provides a high-level view of retail performance.

It includes measures such as:

- total sales
- total profit
- profit margin
- sales by category
- regional performance
- customer activity
- loss-making records

---

## 2. Sales Analysis

![Sales Analysis](screenshots/02.dashboard_sales.png)

The Sales Analysis page compares revenue and profit across different parts of the business.

It includes analysis by:

- region
- category
- sub-category
- customer segment

The page makes it easier to identify areas where high sales do not translate into equally strong profit.

---

## 3. Geographic Analysis

![Geographic Analysis](screenshots/03.geographic_analysis.png)

The geographic page compares retail performance across US states and cities.

It includes:

- state-level sales
- state-level profit
- top-performing locations
- city-level contribution

---

## 4. Profit Analysis

![Profit Analysis](screenshots/04.Profit_analysis.png)

The Profit Analysis page focuses on:

- profit by sub-category
- profit by region
- category profitability
- discounts
- loss-making areas

Filters allow results to be explored by region, category, segment and discount level.

---

## 5. Drill-Through Detail

![Drill-Through Detail](screenshots/05.drill_through_detail.png)

The drill-through page allows a selected region to be examined in more detail.

This helps move from a high-level KPI into the underlying regional performance.

---

## Power BI Data Model

![Power BI Data Model](screenshots/06_powerbi_data_model.png.png)

The Power BI model organises the data and measures used across the report so that filtering and calculations remain consistent between pages.

---

## 📐 Power BI Measures

The report includes measures for areas such as:

```text
Total Sales
Total Profit
Total Orders
Total Quantity
Profit Margin %
Avg Order Value
Avg Discount %
Loss Orders
Profitable Orders
Loss Order %
Total Loss Amount
Revenue After Discount
Profit Per Unit
Consumer Profit
High Discount Loss
Sales % of All Regions
Sales Ignoring Region Filter
```

Additional time-intelligence measures were created using the synthetic date fields for technical practice, but they are not used as evidence for the main business conclusions.

---

# 📁 Repository Structure

```text
retail-performance-analytics-Portfolio-2/
│
├── README.md
├── INDEX.sql
├── LICENSE
├── .gitignore.txt
│
├── data/
│   └── SampleSuperstore.csv
│
├── sql/
│   └── retail_performance_analysis.sql
│
├── powerbi/
│   └── retail_dashboard.pbix
│
└── screenshots/
    ├── 01.dashboard_executive_summary
    ├── 02.dashboard_sales.png
    ├── 03.geographic_analysis.png
    ├── 04.Profit_analysis.png
    ├── 05.drill_through_detail.png
    └── 06_powerbi_data_model.png.png
```

---

# 🛠️ Tools

| Tool | Use |
|---|---|
| **SQL Server / SSMS** | Data validation, EDA and analytical queries |
| **T-SQL** | Aggregations, CTEs, windows, subqueries, views, procedures and indexes |
| **Power BI Desktop** | Data model, DAX measures and dashboard development |
| **DAX** | KPI and reporting calculations |

---

# 🧠 Skills Demonstrated

This project demonstrates practical use of:

**SQL Analysis**  
`GROUP BY` · CTEs · Subqueries · Joins · Window Functions · PIVOT · Stored Procedures · Views · Indexes

**Business Analysis**  
Sales Analysis · Profitability Analysis · Discount Analysis · Segmentation · Geographic Analysis · KPI Design

**Power BI**  
Data Modelling · DAX · Slicers · Drill-Through · Bookmarks · Interactive Reporting

---

# 📌 Overall Conclusion

The project found that the business generated approximately **$2.30M in sales and $286K in profit**, but performance varied substantially underneath those headline numbers.

The strongest areas were **West and Technology**, while Furniture produced high revenue with a very weak margin.

Tables, Bookcases and Supplies were loss-making, and deeper discount bands were associated with increasingly poor profitability.

The main lesson from the project is that a retail business should not evaluate performance using revenue alone.

**Sales, profit, margin, discounting and product mix need to be analysed together to understand where the business is actually creating value.**

---

## 👤 Author

**Shah Tahsin**  
Business Data Analyst | SQL · Power BI · Python

[GitHub](https://github.com/shababtahsin)


# 📊 Sample Superstore — Retail Performance Analytics

![SQL Server](https://img.shields.io/badge/SQL%20Server-SSMS-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![T-SQL](https://img.shields.io/badge/SQL-T--SQL-orange)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

## 📌 Project Overview

This project analyses retail sales, profitability, discounts, customer segments, and geographic performance using **SQL Server and Power BI**.

The original Sample Superstore dataset contains **9,994 sales records** across 13 columns.

SQL Server was used for data validation, cleaning, exploratory analysis, calculations, and reusable reporting views. Power BI was used to develop interactive dashboards and present business findings.

### 🎯 Business Problem

> **High sales do not always mean strong profitability.**

The objective was to identify products, regions, customer segments, and discount levels generating revenue without sufficient profit.

---

## 🎯 Business Objectives

| Business Question | Analytical Objective |
|---|---|
| Which regions perform best? | Compare regional sales, profit, and margins |
| Which products generate the most value? | Analyse categories and sub-categories |
| Where is the business losing money? | Identify loss-making products and transactions |
| How do discounts relate to profitability? | Compare discounts, profit, and margins |
| Which customer segments perform best? | Compare Consumer, Corporate, and Home Office |
| Where is revenue concentrated? | Analyse states, cities, and regions |
| How are products delivered? | Analyse shipping method distribution |
| Does higher revenue mean higher profit? | Compare sales against profitability |

---

## 📊 Dataset Overview

**Source:** Sample Superstore public retail dataset

### Verified Original Dataset

| Metric | Value |
|---|---:|
| Total Records | **9,994** |
| Total Columns | **13** |
| Total Sales | **$2,297,200.86** |
| Total Profit | **$286,397.02** |
| Profit Margin | **12.47%** |
| Units Sold | **37,873** |
| Loss-Making Records | **1,871** |
| Loss Record Rate | **18.72%** |

### Dataset Columns

| Column | Description |
|---|---|
| Ship Mode | Method used to deliver products |
| Segment | Customer classification |
| Country | Country of sale |
| City | Customer location |
| State | State of sale |
| Postal Code | Geographic postal identifier |
| Region | Sales region |
| Category | Main product category |
| Sub-Category | Detailed product classification |
| Sales | Revenue generated |
| Quantity | Units sold |
| Discount | Discount percentage |
| Profit | Profit or loss generated |

### Dataset and Dashboard Reconciliation

The uploaded CSV and Excel files contain the same 9,994 source records.

The existing Power BI screenshots show a smaller reporting population:

| Metric | Original Dataset | Power BI Screenshot |
|---|---:|---:|
| Records / Displayed Orders | 9,994 | 9,746 |
| Total Sales | $2.30M | $2.27M |
| Total Profit | $286.40K | $283.51K |
| Loss-Making Records | 1,871 | 1,845 |

The screenshots therefore reflect a different reporting population from the original source dataset.

The exact transformation responsible for this difference has not been established. SQL findings below use the complete source dataset, while dashboard descriptions retain the displayed Power BI values.

**Important:** The source dataset does not contain a unique Order ID. Record counts should not automatically be treated as distinct customer orders.

---

# 🧹 Data Validation and Cleaning

SQL Server was used to inspect the original dataset before performing analysis.

### Data Quality Checks

- **Missing Values:** Checked all 13 columns for missing or NULL values.
- **Duplicate Records:** Investigated rows containing identical combinations of source attributes.
- **Data Types:** Validated numeric and text fields before calculations.
- **Categorical Values:** Reviewed regions, categories, segments, and shipping methods for consistency.
- **Numeric Validation:** Examined sales, quantity, discounts, and profit for unexpected values.
- **Text Cleaning:** Practised `TRIM()`, `REPLACE()`, and related functions.
- **Calculation Safety:** Used `NULLIF()` to prevent division-by-zero errors.

### Duplicate Handling

The dataset does not include a reliable unique transaction identifier.

Although some rows share identical values, matching records cannot automatically be classified as duplicate transactions.

Therefore, the original **9,994 records were preserved** for the final source-level analysis.

This avoids deleting potentially legitimate transactions.

---

## ⏱️ Date and Time Analysis

The original dataset contains no Order Date or Ship Date columns.

Synthetic dates were created for technical exercises involving:

- `YEAR()`, `MONTH()`, and `DAY()`
- `DATEADD()` and `DATEDIFF()`
- Monthly and quarterly aggregation
- `LAG()` and `LEAD()`
- Running totals
- Year-to-Date calculations
- Month-over-Month comparisons

**Important:** These dates are artificially generated.

Therefore, monthly sales, monthly profit, YTD, MoM, and shipping-duration results demonstrate SQL and Power BI techniques rather than actual historical business performance.

---

# 🔍 SQL Exploratory Data Analysis

## 1. Sales Analysis

Examined overall revenue performance and identified the main sources of sales.

**Analysis included:**

- Total sales and transaction volume
- Sales by region
- Sales by category and sub-category
- Sales by customer segment
- Sales by shipping method
- Top and bottom states
- Product sales rankings
- Percentage contribution
- Running totals

**Business Purpose:** Identify which products, customers, and regions generate the most revenue.

---

## 2. Profitability Analysis

Examined whether strong sales translated into actual profit.

**Analysis included:**

- Total profit and profit margin
- Loss-making records
- Regional profitability
- Category and sub-category profit
- Customer segment margins
- High-revenue, low-profit products
- Discount bands
- Products generating negative profit

**Business Purpose:** Identify profitable areas, financial losses, and opportunities for margin improvement.

---

## 3. Customer Segment Analysis

Compared the three customer groups:

- Consumer
- Corporate
- Home Office

**Measures included:**

- Total sales
- Total profit
- Number of records
- Quantity sold
- Average sales per record
- Average discount
- Profit margin

**Finding:** Consumer generated the highest overall revenue, while Home Office had the highest average sales value per record.

---

# 🧮 SQL Techniques Demonstrated

| SQL Technique | Analytical Application |
|---|---|
| `GROUP BY`, `HAVING` | Aggregation and filtered group analysis |
| `CASE` | Conditional business classifications |
| Joins | Combining related datasets |
| Subqueries | Nested analytical calculations |
| CTEs | Structuring multi-stage queries |
| `ROW_NUMBER()` | Ranking and selecting records |
| `RANK()`, `DENSE_RANK()` | Performance rankings |
| `LAG()`, `LEAD()` | Previous and next period comparisons |
| `NTILE()` | Dividing records into analytical groups |
| `PERCENTILE_CONT` | Distribution and percentile analysis |
| `SUM() OVER()` | Window aggregations |
| Running Totals | Cumulative performance |
| `PIVOT` | Cross-tabular reporting |
| `NULLIF()` | Safe calculations |
| `CAST()`, `TRIM()`, `REPLACE()` | Data preparation |
| Date Functions | Time-based technical exercises |
| Views | Reusable analytical datasets |
| Stored Procedures | Parameterised analysis |
| Indexes | Query-performance optimisation exercises |

---

# 🗄️ Reusable SQL Objects

## SQL Views

| View | Purpose |
|---|---|
| `vw_master_eda` | Combines detailed geographic, customer, product, and performance information |
| `vw_region_performance` | Summarises regional sales, profit, discounts, and margins |
| `vw_subcat_profitability` | Summarises sub-category revenue, profit, discounts, and profit status |

## Stored Procedures

| Procedure | Purpose |
|---|---|
| `usp_sales_by_region` | Returns performance for a selected region |
| `usp_category_segment_analysis` | Analyses a selected category and customer segment |

## Nonclustered Indexes

The project includes indexing exercises on frequently filtered fields:

- `idx_region`
- `idx_category`
- `idx_region_category`
- `idx_state`
- `idx_segment`

These objects demonstrate reusable SQL reporting logic and basic database performance optimisation.

---

# 💡 Key Business Findings

## 1. 🟢 West Was the Strongest Region

| Region | Sales | Profit | Margin |
|---|---:|---:|---:|
| West | $725.46K | $108.42K | 14.94% |
| East | $678.78K | $91.52K | 13.48% |
| Central | $501.24K | $39.71K | 7.92% |
| South | $391.72K | $46.75K | 11.93% |

**Finding:** West generated the highest sales and profit, while Central had the weakest profit margin.

**Business Implication:** Regional performance should be assessed through profitability, not revenue alone.

---

## 2. 🔴 Furniture Generated High Sales but Weak Profit

| Category | Sales | Profit | Margin |
|---|---:|---:|---:|
| Technology | $836.15K | $145.45K | 17.40% |
| Furniture | $742.00K | $18.45K | 2.49% |
| Office Supplies | $719.05K | $122.49K | 17.04% |

Furniture generated substantial revenue but retained very little profit.

**Business Implication:** Review furniture pricing, discount policies, product mix, and cost structure.

---

## 3. 🚨 Three Sub-Categories Were Loss-Making

| Sub-Category | Sales | Profit | Margin |
|---|---:|---:|---:|
| Tables | $206.97K | -$17.73K | -8.56% |
| Bookcases | $114.88K | -$3.47K | -3.02% |
| Supplies | $46.67K | -$1.19K | -2.55% |

Tables were the largest loss-making sub-category despite generating more than $200K in sales.

**Business Implication:** Investigate pricing, discounting, and product costs before expanding sales in these categories.

---

## 4. 💸 Higher Discounts Were Associated With Lower Profitability

| Discount Band | Profit | Profit Margin |
|---|---:|---:|
| No Discount | $320.99K | 29.50% |
| 1–20% | $100.79K | 11.91% |
| 21–40% | -$35.82K | -15.30% |
| 41–60% | -$28.94K | -40.74% |
| Above 60% | -$70.61K | -122.63% |

Higher discount bands consistently showed weaker profitability.

Transactions discounted above 60% generated approximately **$70.61K in net losses**.

**Business Implication:** Introduce a discount review process and test whether lower discount levels improve margins.

**Analytical Limitation:** The relationship is observational. Product mix, regional differences, and other factors may also influence profitability. The analysis does not establish that discounts alone caused the losses.

---

## 5. 💻 Technology Was the Strongest Category

Technology generated:

- **$836.15K sales**
- **$145.45K profit**
- **17.40% profit margin**

It led all three categories in both sales and profit.

**Business Implication:** Identify successful pricing and product strategies within Technology that may be applicable elsewhere.

---

## 6. 👥 Customer Segments Showed Different Performance

| Segment | Sales | Profit | Average Sales per Record |
|---|---:|---:|---:|
| Consumer | $1.16M | $134.12K | $223.73 |
| Corporate | $706.15K | $91.98K | $233.82 |
| Home Office | $429.65K | $60.30K | $240.97 |

Consumer generated the most revenue and the largest number of records.

Home Office had the highest average sales value per record.

**Business Implication:** Customer segments should be evaluated by transaction volume, average value, and profitability together.

---

## 7. 🚚 Standard Class Dominated Shipping

Standard Class appeared in **5,968 records**, accounting for approximately **59.7% of all records**.

**Business Implication:** Standard Class is the most frequently used shipping option.

Shipping speed and delivery efficiency cannot be assessed reliably from the original dataset because actual shipping dates were unavailable.

---

# 📈 Power BI Dashboard Analysis

The Power BI report contains **five analytical pages and a data model**.

The dashboards turn the SQL analysis into interactive reports for reviewing business performance, identifying financial problems, and investigating individual products and locations.

---

## 📊 1. Executive Summary

![Executive Summary](screenshots/01.dashboard_executive_summary)

### Purpose

Provides management with a high-level overview of revenue, profit, transactions, and regional performance.

### Dashboard Visuals

**1. KPI Cards**

The dashboard displays:

- **Total Sales:** $2.27M
- **Total Profit:** $283.51K
- **Profit Margin:** Approximately 12%
- **Displayed Total Orders:** 9,746
- **Loss Orders:** 1,845
- **Average Order Value:** $233.34
- **Sales YTD:** $578.16K

These indicators summarise overall business performance and highlight the number of loss-making records.

**2. Sales by Category — Donut Chart**

Compares revenue contribution across the three main categories:

- Technology: $830.78K — 36.53%
- Furniture: $732.82K — 32.22%
- Office Supplies: $710.55K — 31.24%

Technology generates the largest share of revenue, although the three categories contribute relatively similar amounts.

**3. Profit by Region — Horizontal Bar Chart**

Ranks regional profitability:

- West: approximately $106K
- East: approximately $91K
- South: approximately $47K
- Central: approximately $40K

West produces the most profit, while Central contributes considerably less.

**4. Monthly Sales — Line Chart**

Displays monthly revenue using the synthetic date fields.

July records approximately $220K, while February records approximately $156K.

The visual demonstrates monthly comparison and time-based DAX calculations, rather than actual historical seasonality.

### 💡 Business Insight

**Revenue and profit do not increase equally across every category and region.** Management should investigate areas generating substantial sales but relatively weak profits.

---

## 📈 2. Sales Analysis

![Sales Analysis](screenshots/02.dashboard_sales.png)

### Purpose

Identifies where revenue originates and compares sales performance with profitability across regions, products, and customer segments.

### Dashboard Visuals

**1. Sales and Profit by Region — Clustered Column Chart**

Compares sales and profit for West, East, Central, and South.

West leads in both measures, while Central generates more sales than South but less profit.

This reveals differences in how efficiently each region converts sales into profit.

**2. Sales by Sub-Category — Horizontal Bar Chart**

Ranks individual product groups by revenue.

Phones and Chairs generate the highest sales, followed by Storage, Tables, and Binders.

The chart identifies major revenue drivers and highlights products requiring further profitability analysis.

**3. Sales by Region and Customer Segment — 100% Stacked Bar Chart**

Compares the percentage of revenue contributed by each customer segment.

Across all four regions:

- Consumer contributes approximately 50%.
- Corporate contributes approximately 30–31%.
- Home Office contributes approximately 18–19%.

The similar distribution suggests that customer segment composition is relatively consistent between regions.

**4. Monthly Sales by Year — Multi-Line Chart**

Compares monthly sales across the synthetic years 2020–2023.

This demonstrates multi-year trend visualisation and time-based reporting.

**5. Sales vs Profit by Sub-Category — Scatter Plot**

Plots Total Sales on the horizontal axis and Total Profit on the vertical axis.

The chart identifies different commercial performance patterns:

- **Phones and Copiers:** Strong revenue with healthy profits.
- **Chairs:** High sales but comparatively weaker profit.
- **Tables:** Significant revenue combined with negative profit.
- **Paper and other smaller categories:** Lower revenue with positive profit contributions.

Tables stand out as a major concern because substantial revenue is associated with financial losses.

### 💡 Business Insight

**The best-selling products are not necessarily the most profitable.** The scatter plot helps identify product groups where revenue growth may not translate into business value.

---

## 🌎 3. Geographic Analysis

![Geographic Analysis](screenshots/03.geographic_analysis.png)

### Purpose

Examines how sales and profit vary across US states, cities, and regions.

### Geographic Analysis

**1. State-Level Sales**

Compares revenue generated across individual states.

This helps identify major geographic markets and areas contributing smaller amounts of revenue.

**2. State-Level Profit**

Compares profitability between states.

This allows analysts to identify locations where strong sales may be accompanied by weak or negative profit.

**3. Top-Performing Locations**

Ranks locations according to their contribution to overall business performance.

This supports geographic prioritisation and market comparisons.

**4. City-Level Contribution**

Provides more detailed geographic analysis by examining individual cities.

This helps identify whether sales and profit are concentrated in a small number of locations.

### 💡 Business Insight

**Strong geographic sales do not guarantee strong geographic profitability.** Comparing state and city performance can help identify markets requiring pricing, product mix, or operational reviews.

---

## 💰 4. Profit Analysis

![Profit Analysis](screenshots/04.Profit_analysis.png)

### Purpose

Investigates product profitability, regional differences, discount levels, and loss-making areas.

### Dashboard Visuals

**1. Interactive Slicers**

The dashboard supports filtering by:

- Region
- Product Category
- Customer Segment
- Order Year
- Discount Bucket

Discount buckets include No Discount, Low, Medium, High, and Extreme.

These controls allow users to investigate profitability under different business conditions.

**2. Profit by Sub-Category — Horizontal Bar Chart**

Ranks product groups by profit.

Copiers, Phones, and Accessories are among the strongest contributors.

Tables, Bookcases, and Supplies are loss-making in the complete source dataset.

This identifies which product groups create or reduce profitability.

**3. Profit by Region and Category — Clustered Column Chart**

Compares Furniture, Office Supplies, and Technology profitability across regions.

Technology and Office Supplies contribute strongly in several regions.

Central's Furniture category shows approximately $3K in losses in the displayed report.

This helps identify the categories responsible for regional profit differences.

**4. Sub-Category Profitability — Detailed Table**

Displays:

- Sub-Category
- Total Sales
- Profit Margin %
- Average Discount %

The table allows direct comparison between revenue, profitability, and discount behaviour.

For example, the displayed report shows Tables generating approximately $205K in sales with a negative profit margin of around 8% and an average discount of approximately 26%.

This makes Tables a clear candidate for further pricing and cost analysis.

**5. Monthly Profit by Year — Multi-Line Chart**

Compares monthly profitability across synthetic years.

It demonstrates multi-year profit analysis and time-intelligence reporting.

**6. Interactive Bookmark Buttons**

Three visible buttons provide predefined reporting views:

- All Regions
- West Region
- Loss Orders

These simplify navigation between different analytical scenarios.

### 💡 Business Insight

**Furniture and high-discount products require further investigation.** Comparing revenue, margin, and discounts helps identify where profitability may be improved.

---

## 🔎 5. Drill-Through Detail

![Drill-Through Detail](screenshots/05.drill_through_detail.png)

### Purpose

Allows users to move from summary-level reporting into detailed geographic and product performance.

### Dashboard Visuals

**1. KPI Cards**

The displayed drill-through context shows:

- **Total Sales:** $669.35K
- **Total Profit:** $90.83K
- **Profit Margin:** Approximately 14%

These figures summarise the selected reporting context.

**2. Detailed Performance Table**

Displays:

- State
- Category
- Sub-Category
- Total Sales
- Total Profit
- Profit Margin %
- Average Discount %

This allows detailed investigation of product performance within individual locations.

For example, the displayed Connecticut Furniture–Tables row contains approximately:

- Sales: $252.36
- Profit: -$19.61
- Profit Margin: -8%
- Average Discount: 30%

This provides a practical example of a loss-making product group within a specific state.

**3. Sales by Sub-Category — Horizontal Bar Chart**

Ranks sub-categories within the selected reporting context.

Phones, Chairs, Storage, and Machines are among the leading revenue contributors in the screenshot.

The chart helps identify which products drive sales within a selected area.

**4. Drill-Through Functionality**

Users can investigate a selected region in greater detail while retaining the relevant filter context.

This connects high-level reporting with more detailed business analysis.

### 💡 Business Insight

**Drill-through reporting helps locate the products and geographic areas behind performance problems.** It makes the dashboard more useful for investigation and decision-making.

---

# 🗄️ Power BI Data Model

![Power BI Data Model](screenshots/06_powerbi_data_model.png.png)

### Model Overview

The Power BI model integrates the retail transaction dataset with reusable SQL analytical views.

Four tables are visible in the model.

| Table / View | Purpose |
|---|---|
| `SampleSuperstore` | Main transaction-level sales and profit dataset |
| `vw_master_eda` | Detailed analytical information and calculated fields |
| `vw_region_performance` | Regional performance summary |
| `vw_subcat_profitability` | Sub-category profitability summary |



## 📊 Power BI Report Conclusion

The five-page Power BI report transforms retail data into interactive business insights, showing where revenue is generated, which products are profitable, and where financial losses occur.

### 🔍 Key Findings

- **Executive Summary:** Reports $2.27M in sales, $283.51K in profit, and approximately 12% profit margin.
- **Sales Analysis:** Identifies Technology as the leading revenue category and reveals high-selling products with weak profitability.
- **Geographic Analysis:** Compares regional, state, and city performance to identify strong and underperforming markets.
- **Profit Analysis:** Highlights loss-making sub-categories, particularly Tables, and the relationship between higher discounts and weaker margins.
- **Drill-Through Analysis:** Enables detailed investigation of product and geographic performance behind the headline KPIs.
- **Data Model:** Combines SQL analytical views, relationships, and DAX measures to support interactive reporting.

### 🎯 Business Value & Recommendations

| Finding | Business Recommendation |
|---|---|
| Furniture generates high sales but weak profits | Review product pricing, costs, and margins |
| Tables are loss-making | Investigate discounts and product profitability |
| Higher discounts are associated with lower margins | Evaluate discount limits and approval policies |
| Central shows weaker regional profitability | Investigate product mix and regional pricing |
| Technology generates strong profits | Identify successful strategies worth expanding |
| Profitability varies geographically | Prioritise detailed regional and state-level analysis |

### 🚀 Final Takeaway

> **High revenue does not guarantee strong profitability. Sustainable growth requires businesses to understand where they make money, where they lose money, and why.**

By combining **SQL Server, DAX, and Power BI**, this project demonstrates how retail data can be transformed into actionable insights to support better pricing, product management, regional performance, and commercial decision-making.
### 1. SampleSuperstore

Contains the original retail information and supporting reporting fields.

Includes:

- Geography
- Customer segment
- Product category
- Sales and profit
- Discount and quantity
- Synthetic date fields

**Purpose:** Provides detailed data for measures, filters, and report visuals.

### 2. vw_master_eda

Provides reusable analytical fields prepared through SQL.

Visible fields include:

- Average discount
- Average sales value
- Average shipping days
- Loss orders
- Geographic information
- Category information
- Date components

**Purpose:** Supports detailed exploratory reporting and reusable calculations.

### 3. vw_region_performance

Contains regional performance measures, including:

- Total sales
- Total profit
- Total orders
- Average discount
- Profit margin

**Purpose:** Supports regional comparisons without repeatedly rebuilding the same aggregations.

### 4. vw_subcat_profitability

Contains product profitability measures, including:

- Category
- Sub-Category
- Total sales
- Total profit
- Profit margin
- Average discount
- Profit status

**Purpose:** Supports product rankings, profitability comparisons, and discount analysis.

### Relationships

The model contains one-to-many relationships between analytical views and transaction-level information.

These relationships support filtering and calculations across report visuals.

The current implementation combines transaction data with SQL reporting views rather than using a conventional dimensional star schema.

A future production implementation could separate reusable dimensions such as Geography, Product, and Date from the central sales fact table.

### 💡 Technical Insight

**SQL Server prepares reusable analytical information, while Power BI provides the data model, DAX calculations, filters, and interactive reporting.**

---

# 📐 DAX Measures

The Power BI report includes measures covering sales, profitability, transactions, discounts, and regional contribution.

| Measure | Purpose |
|---|---|
| Total Sales | Calculates total revenue |
| Total Profit | Calculates total profit |
| Total Orders | Counts records using the model's reporting definition |
| Total Quantity | Calculates units sold |
| Profit Margin % | Measures profit relative to revenue |
| Avg Order Value | Calculates average revenue per displayed order |
| Avg Discount % | Calculates average discount |
| Loss Orders | Counts loss-making records |
| Profitable Orders | Counts profitable records |
| Loss Order % | Measures the proportion of loss-making records |
| Total Loss Amount | Calculates losses from negative-profit records |
| Revenue After Discount | Provides discount-adjusted revenue analysis |
| Profit Per Unit | Measures profit per item sold |
| Consumer Profit | Calculates profit from Consumer customers |
| High Discount Loss | Analyses losses associated with high discounts |
| Sales % of All Regions | Calculates regional sales contribution |
| Sales Ignoring Region Filter | Provides comparison against unfiltered regional sales |

Additional measures demonstrate time intelligence using the synthetic date fields.

**Note:** Synthetic-date calculations are technical exercises rather than verified historical performance measures.

---

# 🎯 Business Recommendations

Based on the verified source data, the following areas deserve management attention.

| Priority | Area | Recommended Action |
|---|---|---|
| 1 | Furniture Profitability | Review pricing, costs, and product mix |
| 2 | Tables | Investigate the largest loss-making sub-category |
| 3 | Discount Policy | Evaluate margins before approving deeper discounts |
| 4 | Central Region | Investigate weak profitability and category performance |
| 5 | Bookcases and Supplies | Review recurring loss-making product groups |
| 6 | Technology | Study profitable product and pricing strategies |
| 7 | Customer Segments | Compare transaction value, margins, and volume |

### Potential Improvement Opportunity

High-discount transactions are an important area for further investigation.

A controlled discount-cap scenario could be modelled to estimate potential margin improvements.

However, any estimated financial recovery would be **scenario-based**, not a realised saving, and would require assumptions about customer demand, pricing, and sales volume.

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

# 🛠️ Tools and Technologies

| Tool | Application |
|---|---|
| SQL Server | Data storage, validation, and analysis |
| SSMS | SQL query development and execution |
| T-SQL | Aggregations, CTEs, window functions, views, and procedures |
| Power BI Desktop | Dashboard development and reporting |
| Power Query | Data preparation and transformation |
| DAX | KPI calculations and analytical measures |
| GitHub | Source code, documentation, and portfolio presentation |

---

# 🧠 Skills Demonstrated

### SQL and Database Development

`Data Validation` · `Data Cleaning` · `GROUP BY` · `CTEs` · `Subqueries` · `Window Functions` · `PIVOT` · `Views` · `Stored Procedures` · `Indexes`

### Data and Business Analysis

`Exploratory Data Analysis` · `Sales Analysis` · `Profitability Analysis` · `Discount Analysis` · `Customer Segmentation` · `Geographic Analysis` · `Business Recommendations`

### Power BI and Reporting

`Data Modelling` · `DAX` · `KPI Development` · `Interactive Dashboards` · `Slicers` · `Bookmarks` · `Drill-Through` · `Scatter Plots` · `Data Visualisation`

---

# 📌 Overall Conclusion

The original Sample Superstore dataset generated approximately **$2.30M in revenue and $286.40K in profit**, with an overall profit margin of **12.47%**.

However, the analysis revealed important differences beneath these headline figures.

- **West** generated the highest regional sales and profit.
- **Technology** was the strongest category for both revenue and profitability.
- **Furniture** generated approximately $742K in sales but only $18.45K in profit.
- **Tables, Bookcases, and Supplies** generated net losses.
- **Higher discount levels** were associated with significantly weaker margins.
- **Consumer** was the largest customer segment, while Home Office had the highest average sales per record.

The Power BI dashboards translate these findings into interactive reports, allowing users to explore regional performance, product profitability, geographic differences, and individual reporting details.

### Final Business Takeaway

> **Revenue growth is valuable only when it supports sustainable profitability.**

Retail businesses should evaluate sales, profit margins, discounts, product mix, and geographic performance together before making commercial decisions.

This project demonstrates an end-to-end analytical workflow using **SQL Server, T-SQL, DAX, and Power BI** to turn retail data into actionable business information.

---

## 👤 Author

**Shah Tahsin**  
Business Data Analyst | SQL · Power BI · Python

[GitHub Portfolio](https://github.com/shababtahsin)  
[LinkedIn](https://www.linkedin.com/in/shah-tahsin/)

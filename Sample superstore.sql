 SELECT 'Hello, SQL World!'
 AS my_first_message;


 SELECT 
	'John' as first_name,
	'Smith' as last_name,
	28 as Age,
	75000.00 as salary;


	-- Lesson 3 
	Create Table employees (
	employee_id INT,
	first_name varchar(50), 
	last_name varchar(50), 
	age INT, 
	salary Decimal(10,2)

	);

	Insert Into employees(employee_id, first_name, last_name , age, salary)
	Values 
	(1, 'John', 'Smith', 28, 75000.00),
	(2, 'Sarah', 'Johnson', 34, 92000.00),
	(3, 'Mike', 'Davis', 45, 11000.00);
	
	Select * 
	FROM employees;


	Update employees
	SET salary = 110000.00
	WHERE employee_id = 3; 

	SELECT * FROM employees;




-- Create database
 CREATE DATABASE superstore_db;
 USE superstore_db;
 --DROP DATABASE superstore_db;



-- Confirm loaded dataset
SELECT TOP 10 * FROM [Sample superstore].dbo.SampleSuperstore;


-- SHow only tech sales 
SELECT Category, Sub_Category, Sales, Profit 
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Category= 'Technology'
ORDER BY Sales DESC;

-- FInd loss making orders
SELECT Category, Sub_Category, Sales, Profit 
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Profit < 0
ORDER BY Profit ASC; 
 
--Top 10 highest sales in the West 
SELECT TOP 10 
	City, State,Category, Sales, Profit
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Region= 'West'
ORDER BY Sales DESC;
 

 --Query 1 Overall SUmmary
 SELECT 
	COUNT (*) AS total_orders,
	SUM(sales) AS total_sales, 
	SUM(profit) AS total_profit, 
	AVG(sales) AS avg_sales, 
	MIN(sales) AS min_sales, 
	MAX(sales) AS max_sales
FROM [Sample superstore].dbo.SampleSuperstore;

-- Query 2 : By Region 

SELECT 
	region, 
	SUM(Sales) AS total_sales, 
	SUM(profit) AS total_profit
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region
ORDER BY total_sales DESC;

-- Query 3 By Category
SELECT 
Category,
COUNT(*) AS total_orders, 
SUM(Sales) AS total_sales,
SUM (Profit) AS total_profit, 
AVG(Discount) AS avg_discount

FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category
ORDER BY total_profit DESC;

 /*West is the top region for both sales and profit
Central has high sales but weak profit — likely heavy discounting
Furniture has $742k in sales but only $18k profit — almost nothing left after costs
Technology is the most profitable category by far */

--7 Having- filtering gruped results

--States with total sales over 50000 
Select 
	State,
	SUM(Sales) AS total_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY State
HAVING  SUM(Sales) > 5000
ORDER BY total_sales DESC;

-- Subcategories running at a loss

SELECT 
	sub_category,
	SUM(Profit) AS total_profit
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Sub_Category
HAVING SUM(profit)<0
ORDER BY total_profit ASC;


/* Excellent results! Key insights
California dominates at $457k — almost 2x New York
Tables, Bookcases and Supplies are all loss-making — 
the entire Furniture sub-categories are bleeding money */

--8 DATA CLEANING : FINDING AND FIXING DIRTY DATA 

-- Check null valuies in every column 

SELECT
	SUM(CASE WHEN ship_mode IS NULL THEN 1 ELSE 0 END)AS null_ship_mode, 
	SUM(CASE WHEN segment IS NULL THEN 1 ELSE 0 END)AS null_segment,
	SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city,
	SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS null_sales, 
	SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM [Sample superstore].dbo.SampleSuperstore;


-- CHECK FOR DUPLICATE ROWS
SELECT 
	City, State, Category, Sales, Profit, 
COUNT(*) AS occurrences 
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY City, State, Category, Sales, Profit
HAVING COUNT(*) >1
ORDER BY occurrences DESC;

--CHECK distinct values in text columns 
SELECT *
FROM   [Sample superstore].dbo.SampleSuperstore;
SELECT DISTINCT ship_mode FROM [Sample superstore].dbo.SampleSuperstore;
SELECT DISTINCT segment FROM [Sample superstore].dbo.SampleSuperstore;
SELECT DISTINCT region FROM   [Sample superstore].dbo.SampleSuperstore;

-- 9 FIXING NULL PROFIT 
-- See the null row
SELECT *
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Profit is NULL;

-- Fix it by setting it to 0 
UPDATE [Sample superstore].dbo.SampleSuperstore
SET Profit = 0 
WHERE Profit IS NULL;

-- Confirm its gone

SELECT  SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM [Sample superstore].dbo.SampleSuperstore;

SELECT *
FROM   [Sample superstore].dbo.SampleSuperstore;

--Step 1 PReview duplicates with row numbers 

SELECT * ,
ROW_NUMBER()OVER(
PARTITION BY City, State,Category, Sales,Profit
ORDER BY (SELECT NULL)
)
AS row_num
FROM   [Sample superstore].dbo.SampleSuperstore;


--Step 2 Delete Duplicates
WITH cte AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY City, State, Category, Sales, Profit 
ORDER BY (SELECT NULL) 
) AS row_num
FROM   [Sample superstore].dbo.SampleSuperstore 
)
DELETE FROM cte
WHERE row_num> 1;

--Step 3 confirm 
SELECT COUNT (*) 
AS total_rows 
FROM  [Sample superstore].dbo.SampleSuperstore;

SELECT *
FROM  [Sample superstore].dbo.SampleSuperstore;


--String functions for cleaning text 
--STep 1 TRIM, UPPER, LOWER, LEN
SELECT DISTINCT 
	TRIM(Ship_Mode) AS ship_mode,
	TRIM(Segment) AS segment,
	TRIM(City) AS city, 
	TRIM(State) AS state,
	TRIM(Region) AS region, 
	TRIM(Category) AS category, 
	TRIM(Sub_Category) AS sub_category
	FROM [Sample superstore].dbo.SampleSuperstore;

	-- Query 2 Replace All Ship_Mode values 

	SELECT DISTINCT
    Ship_Mode                            AS original,
    REPLACE(REPLACE(REPLACE(REPLACE(
        TRIM(Ship_Mode),
        'Second Class',  '2nd Class'),
        'First Class',   '1st Class'),
        'Standard Class','Std Class'),
        'Same Day',      'Same Day')
    AS cleaned_ship_mode
FROM [Sample superstore].dbo.SampleSuperstore;

--Query 3 
SELECT DISTINCT
CONCAT( TRIM (City), ',',TRIM(State))AS full_location,
Region, 
LEN(TRIM(City)) AS city_name_length
FROM [Sample superstore].dbo.SampleSuperstore
ORDER BY full_location ASC;

/*Query 1 — TRIM every text column. In real data, extra
spaces are invisible but they break everything. 
"Los Angeles" and "Los Angeles " look the same but SQL treats 
them as completely different values — your GROUP BY breaks, 
your joins fail, your Power BI filters split into duplicates.
Query 2 — REPLACE standardises inconsistent naming. 
In real datasets the same thing gets entered 10 different ways by different people. 
You clean it all into one consistent value so your analysis
doesn't split one category into multiple.
Query 3 — CONCAT builds a new combined column and LEN checks character counts. 
You're creating a full location 
field useful for Power BI maps, while LEN catches hidden corruption — 
a city name with 1 or 2 characters is clearly wrong data. 
Sorting alphabetically lets you visually audit everything at once. 🚀 */


-- 13 Number Functions for cleaning and transforming numeric data
--Cleaning the losses 
SELECT 
City, 
Category, 
Sales, 
ROUND(Sales, 2) AS sales_rounded, 
Profit, 
Round(Profit,2) AS profit_rounded, 
ABS (ROUND(Profit,2)) AS loss_magnitude
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Profit< 0 
ORDER by Profit ASC;

--Query 2 Cst data types 
SELECT 
	Category ,
	Sales, 
	CAST(Sales AS INT) AS sales_as_int,
	CAST(Discount AS DECIMAL(5,2)) AS discount_clean,
	CAST (Profit AS DECIMAL (10,2)) AS profit_clean

	FROM [Sample superstore].dbo.SampleSuperstore;

--Profit margin % Per order 
SELECT 
City,
State,
Category,
Sub_Category,
ROUND( Sales, 2) AS sales,
ROUND(Profit,2) AS profit,
ROUND((Profit/NULLIF(Sales,0)) * 100,2) AS profit_margin_pct

FROM [Sample superstore].dbo.SampleSuperstore
ORDER BY profit_margin_pct ASC;


--14 CTES 
--QUery 1 Bsic CTE category summary

WITH category_summary AS (
SELECT 
Category,
ROUND(SUM(Sales),2) AS total_sales,
ROUND(SUM(Profit),2) AS total_profit,
ROUND(AVG(Sales),2) AS avg_sales,
COUNT(*) AS total_orders

FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category
)
SELECT * 
FROM category_summary
ORDER BY total_profit DESC;

--Query 2 Chained CTE states above average sales 
-- Query 2: chained CTEs — states above average sales
WITH state_sales AS (
    SELECT
        State,
        Region,
        ROUND(SUM(Sales), 2)   AS total_sales,
        ROUND(SUM(Profit), 2)  AS total_profit
    FROM [Sample superstore].dbo.SampleSuperstore
    GROUP BY State, Region
),
avg_sales AS (
    SELECT ROUND(AVG(total_sales), 2) AS avg_state_sales
    FROM state_sales
)
SELECT
    s.State,
    s.Region,
    s.total_sales,
    s.total_profit,
    a.avg_state_sales
FROM state_sales s
CROSS JOIN avg_sales a
WHERE s.total_sales > a.avg_state_sales
ORDER BY s.total_sales DESC;


-- Window functions -Rank , Dense_rank, row_number, runnning totals
--Query 1 Rank sub-categories by profit 

WITH sub_cat_profit AS (
SELECT 
Category,
Sub_Category,
ROUND(SUM(Profit),2) AS total_profit,
ROUND(SUM(Sales),2) AS total_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category,Sub_Category
)

SELECT 
Category,
Sub_Category,
total_sales,
total_profit,
RANK() OVER( PARTITION BY Category ORDER BY total_profit DESC) AS profit_rank,
DENSE_RANK() OVER(PARTITION BY Category ORDER BY total_profit DESC) AS dense_rank
FROM sub_cat_profit
ORDER BY Category, profit_rank;

--Subquery 2 RUNNING TOTAL SALES BY REGION 

WITH region_sales AS(
SELECT 
Region, 
STATE,
ROUND(SUM(Sales),2) AS state_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region, State

)
Select 
Region, 
State,
state_sales,
SUM(state_sales) OVER(
PARTITION BY Region
ORDER BY state_sales DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total
FROM region_sales
ORDER BY Region, state_sales DESC;

-- % Contribution of each sub catergory to total_sales
WITH sub_sales AS ( 
SELECT 
Category,
Sub_Category,
ROUND(SUM(Sales),2) AS total_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category, Sub_Category
)
Select 
Category, 
Sub_Category, 
total_sales,
ROUND(
total_sales * 100.0 /SUM(total_sales) OVER(),2) AS pct_of_total_sales
FROM sub_sales 
ORDER BY pct_of_total_sales DESC;

--SUBQUERIES 
--Query1 Subquery in WHERE 
SELECT 
City,
State,
Category,
ROUND(Sales,2) AS sales,
ROUND(Profit,2) AS profit
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Sales > (
SELECT AVG(Sales)
FROM [Sample superstore].dbo.SampleSuperstore
)
ORDER BY Sales DESC;

-- Query 2 Subquery in Select 
SELECT 
Category,
Sub_Category,
ROUND(Sales,2) as sales,
ROUND(( 
	SELECT AVG(s2.Sales)
	FROM [Sample superstore].dbo.SampleSuperstore s2
	WHERE s2.Category = s1.Category
	),2) AS category_avg_sales
FROM [Sample superstore].dbo.SampleSuperstore s1  
ORDER BY Category, Sales DESC;

--Query 3 SubQuery in FROM 
SELECT TOP 5 
	state_summary.State,
	state_summary.Region,
	state_summary.total_sales,
	state_summary.total_profit, 
	state_summary.profit_margin
	FROM(
		SELECT 
		State,
		Region,
		ROUND(SUM(Sales),2) AS total_sales,
		ROUND(SUM(Profit),2) AS total_profit,
		ROUND(SUM(Profit)/NULLIF (SUM(Sales),0) *100,2) AS profit_margin
FROM [Sample superstore].dbo.SampleSuperstore 
GROUP BY State,Region
) AS state_summary
ORDER BY total_profit DESC;


--JOINS 
--SETUP  create region targets table 
CREATE Table region_targets(
REGION	VARCHAR(50),
sales_target DECIMAL (12,2)
);

INSERT INTO region_targets (REGION,sales_target)
VALUES 
('West',	800000.00),
('East',	700000.00),
('Central',	600000.00),
('South',	500000.00),
('North',	400000.00);


--Query 1 INNER JOIN- matched regions only
WITH actual_sales AS(
SELECT 
	Region,
	ROUND(SUM(Sales),2) AS actual_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region
)

SELECT 
a.Region,
a.actual_sales,
t.sales_target, 
ROUND (a.actual_sales - t.sales_target,2) AS variance,
	CASE 
		WHEN a.actual_sales >= t.sales_target THEN 'Target Met '
		ELSE 'Below Target'
	END AS status
FROM actual_sales a
INNER JOIN region_targets t 
ON a.Region = t.REGION
ORDER BY variance DESC;



 -- QUery 2 LEFT join --all actual sales

 WITH actual_sales AS (
 SELECT 
	Region, 
	ROUND(SUM(Sales),2) AS actual_sales
	FROM [Sample superstore].dbo.SampleSuperstore
	GROUP BY Region
	)
SELECT
	a.Region,
	a.actual_sales,
	t.sales_target
FROM actual_sales a
LEFT JOIN region_targets t 
	ON a.Region = t.REGION
ORDER BY a.actual_sales DESC;

-- FULL OUTER JOIN -- Everything from both tables 

WITH actual_sales AS (
SELECT 
	Region,
	ROUND(SUM(Sales),2) AS actual_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region
)
SELECT 
	COALESCE (a.Region, t.Region) AS Region,
	a.actual_sales,
	t.sales_target
FROM actual_sales a
FULL OUTER JOIN region_targets t 
ON a.Region = t.Region
ORDER BY a.actual_sales DESC;


-- VIEWS saved queries as virtual tables
CREATE VIEW vw_region_performance AS 
SELECT 
Region,
COUNT(*) AS total_orders, 
ROUND(SUM(Sales),2) AS total_sales,
ROUND(SUM(Profit),2) AS total_profitm,
ROUND(AVG(Discount),2) AS avg_discount,
ROUND(SUM(Profit)/NULLIF(SUM(Sales),0)*100,2) AS profit_margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region;

--VIEW 2 sub-category profitability 
CREATE VIEW vw_subcat_profitability AS 
SELECT 
	Category,
	Sub_Category,
	COUNT(*) AS total_orders,
	ROUND(SUM(Sales),2) AS total_sales,
	ROUND(SUM(Profit),2) AS total_profit,
	ROUND(AVG(Discount),2) AS avg_discount,
	ROUND(SUM(Profit)/NULLIF(SUM(Sales),0)*100,2) AS profit_margin_pct,
	CASE 
		WHEN SUM(Profit) > 0 THEN 'Profitable'
		WHEN SUM(Profit)<0 THEN 'Loss'
		ELSE 'Break Even'
	END AS profit_status
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category, Sub_Category;


--Query both views
SELECT *
FROM vw_region_performance
ORDER BY profit_margin_pct DESC;

SELECT * FROM vw_subcat_profitability
WHERE profit_status ='Loss'
ORDER BY total_profit ASC;


-- STored procedure 
-- Basic stored procedure --regional performance report 

--Parameterised Procedure --Filter by any region
 CREATE PROCEDURE usp_sales_by_region
	@Region Varchar(50)

AS 
BEGIN
	Select 
	State,
		City,
		Category,
		Sub_Category,
		COUNT(*) AS total_orders,
		ROUND(SUM(Sales),2) AS total_orders, 
		ROUND(SUM(Profit),2) AS total_profit,
		ROUND(SUM(Profit)/NULLIF(SUM(Sales),0)*100,2) AS profit_margin_pct	
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Region = @Region
GROUP BY State, CIty , Category, Sub_Category
ORDER BY total_profit DESC;
END;

-- Execute for each region
EXEC usp_sales_by_region @Region = 'West';
EXEC usp_sales_by_region @Region = 'East';
EXEC usp_sales_by_region @Region = 'Central';
EXEC usp_sales_by_region @Region = 'South';
 

 --PRojecedure with multiple parameters + output categroy and segment filter 
 CREATE Procedure usp_category_segment_analysis
 @Category Varchar(50),
 @Segment Varchar(50),
 @TotalProfit Decimal(12,2)Output
 AS
 BEGIN
 SELECT 
	Sub_Category,
	Ship_Mode,
	COUNT(*) AS total_orders,
	ROUND(SUM(Sales),2) AS total_sales,
	ROUND(SUM(Profit),2) AS total_profit,
	ROUND(AVG(Discount),2) AS avg_discount,
	ROUND(SUM(Profit)/NULLIF(SUM(Sales),0)*100,2) AS profit_margin_pct
 FROM [Sample superstore].dbo.SampleSuperstore
WHERE Category= @Category
AND Segment = @Segment
GROUP BY Sub_Category,Ship_Mode
ORDER BY total_profit DESC;

SELECT @TotalProfit = ROUND(SUM(Profit),2)
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Category = @Category AND Segment =@Segment;
END;

DECLARE @profit DECIMAL(12,2);
EXEC usp_category_segment_analysis
@Category = 'Technology',
@Segment = 'Consumer',
@TotalProfit = @profit OUTPUT;
SELECT @profit AS total_profit_returned;


-- INDEXES --make Queries fast 

--Query 1 Check query performance before indexing 

--Turn on performance stats 
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

--RUN a query that filters by region - no index yet 

SELECT 
Region,
State,
Category,
ROUND(SUM(Sales),2) AS total_sales, 
ROUND(SUM(Profit),2) AS total_profit

FROM [Sample superstore].dbo.SampleSuperstore
WHERE Region = 'West'
GROUP BY Region,State,Category
ORDER BY total_profit DESC;

--Step 2 Create indexes 
-- drop existing indexes
DROP INDEX idx_region          ON [Sample superstore].dbo.SampleSuperstore;
DROP INDEX idx_category        ON [Sample superstore].dbo.SampleSuperstore;
DROP INDEX idx_region_category ON [Sample superstore].dbo.SampleSuperstore;
DROP INDEX idx_state           ON [Sample superstore].dbo.SampleSuperstore;
DROP INDEX idx_segment         ON [Sample superstore].dbo.SampleSuperstore;

 
CREATE NONCLUSTERED INDEX idx_region
ON [Sample superstore].dbo.SampleSuperstore (Region);

CREATE NONCLUSTERED INDEX idx_category
ON [Sample superstore].dbo.SampleSuperstore (Category);

CREATE NONCLUSTERED INDEX idx_region_category
ON [Sample superstore].dbo.SampleSuperstore (Region, Category);

CREATE NONCLUSTERED INDEX idx_state
ON [Sample superstore].dbo.SampleSuperstore (State );

CREATE NONCLUSTERED INDEX idx_segment
ON [Sample superstore].dbo.SampleSuperstore (Segment);


--Step 3 Rerun same same query + view all indexes

SELECT
    Region,
    State,
    Category,
    ROUND(SUM(Sales), 2)   AS total_sales,
    ROUND(SUM(Profit), 2)  AS total_profit
FROM [Sample superstore].dbo.SampleSuperstore
WHERE Region = 'West'
GROUP BY Region, State, Category
ORDER BY total_profit DESC;

SELECT
    i.name          AS index_name,
    i.type_desc     AS index_type,
    c.name          AS column_name
FROM sys.indexes i
JOIN sys.index_columns ic
    ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id
JOIN sys.columns c
    ON ic.object_id = c.object_id
    AND ic.column_id = c.column_id
WHERE i.object_id = OBJECT_ID('SampleSuperstore')
ORDER BY i.name;


-- 21 Date Functions 

-- SETUP - add date columns 

ALTER TABLE [Sample superstore].dbo.SampleSuperstore
ADD Order_Date DATE,
    Ship_Date  DATE;

UPDATE [Sample superstore].dbo.SampleSuperstore
SET
    Order_Date = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1461), '2020-01-01'),
    Ship_Date  = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1461) + 3, '2020-01-01');

SELECT TOP 5 Order_Date, Ship_Date, Region, Sales
FROM [Sample superstore].dbo.SampleSuperstore;

-- QUery 1 : extract date parts 
SELECT
	Order_Date, 
	YEAR(Order_Date) AS order_year,
	MONTH(Order_Date) AS order_month,
	DAY (Order_Date) AS order_day,
	DATENAME(MONTH, Order_Date)             AS month_name,
    DATENAME(WEEKDAY, Order_Date)           AS day_of_week,
    DATEPART(QUARTER, Order_Date)           AS quarter,
    DATEPART(WEEK, Order_Date)              AS week_number
FROM [Sample superstore].dbo.SampleSuperstore
ORDER BY Order_Date ASC; 

-- Monthly sales trend

SELECT 
	YEAR (Order_Date) AS order_year,
	MONTH(Order_Date) AS order_month,
	DATENAME (Month,Order_date) AS month_name,
	COUNT(*) AS total_orders,
	ROUND(SUM(Sales),2) AS total_sales, 
	ROUND(SUM(Profit),2) AS total_profit,
	ROUND(AVG(Sales),2) As avg_order_value
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY 
	YEAR(Order_Date),
	MONTH(Order_Date),
	DATENAME(Month,Order_Date)
ORDER BY order_year,order_month;

--Query 3 Shipping dasy by ship mode
SELECT 
	Ship_Mode,
	COUNT(*) AS total_orders,
	ROUND(AVG(DATEDIFF(DAY, ORDER_Date,Ship_Date)),1) AS avg_ship_days,
	MIN(DATEDIFF(DAY,ORDER_DATE,Ship_DATE)) AS min_ship_days,
	MAX(DATEDIFF(DAY,Order_Date, Ship_Date)) AS max_ship_days,
	ROUND(Sum(Sales),2) AS total_sales,
	ROUND(Sum(Profit),2) AS total_profit
 

FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Ship_Mode
ORDER BY avg_ship_days ASC;

--Query 4 Quarterly sales by region
-- Query 4: quarterly sales by region
SELECT
    YEAR(Order_Date)                                     AS order_year,
    'Q' + CAST(DATEPART(QUARTER, Order_Date) AS VARCHAR) AS quarter,
    Region,
    COUNT(*)                                             AS total_orders,
    ROUND(SUM(Sales), 2)                                 AS total_sales,
    ROUND(SUM(Profit), 2)                                AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY
    YEAR(Order_Date),
    DATEPART(QUARTER, Order_Date),
    Region
ORDER BY order_year, quarter, Region;



--Pivot tables
--Pivot -- total sales per category across all regions 
 -- Query 1: sales by category across all regions
WITH pivot_result AS (
    SELECT Category, Central, East, South, West
    FROM (
        SELECT Category, Region, Sales
        FROM [Sample superstore].dbo.SampleSuperstore
    ) AS source_data
    PIVOT (
        SUM(Sales)
        FOR Region IN ([Central], [East], [South], [West])
    ) AS pivot_table
)
SELECT
    Category,
    ROUND(Central, 2) AS Central,
    ROUND(East, 2)    AS East,
    ROUND(South, 2)   AS South,
    ROUND(West, 2)    AS West
FROM pivot_result
ORDER BY Category;

-- Query 2: profit by region across all segments
WITH pivot_result AS (
    SELECT Region, Consumer, Corporate, [Home Office]
    FROM (
        SELECT Region, Segment, Profit
        FROM [Sample superstore].dbo.SampleSuperstore
    ) AS source_data
    PIVOT (
        SUM(Profit)
        FOR Segment IN ([Consumer], [Corporate], [Home Office])
    ) AS pivot_table
)
SELECT
    Region,
    ROUND(Consumer, 2)      AS Consumer,
    ROUND(Corporate, 2)     AS Corporate,
    ROUND([Home Office], 2) AS Home_Office
FROM pivot_result
ORDER BY Region;

-- Query 3: quarterly sales by region
WITH pivot_result AS (
    SELECT Region, [Q1], [Q2], [Q3], [Q4]
    FROM (
        SELECT
            Region,
            'Q' + CAST(DATEPART(QUARTER, Order_Date) AS VARCHAR) AS quarter,
            Sales
        FROM [Sample superstore].dbo.SampleSuperstore
    ) AS source_data
    PIVOT (
        SUM(Sales)
        FOR quarter IN ([Q1], [Q2], [Q3], [Q4])
    ) AS pivot_table
)
SELECT
    Region,
    ROUND([Q1], 2) AS Q1,
    ROUND([Q2], 2) AS Q2,
    ROUND([Q3], 2) AS Q3,
    ROUND([Q4], 2) AS Q4
FROM pivot_result
ORDER BY Region;

--ADVANCED WINDOW FUNCTIONS

-- Query 1: LAG and LEAD — month over month sales growth
WITH monthly_sales AS (
    SELECT
        YEAR(Order_Date)        AS order_year,
        MONTH(Order_Date)       AS order_month,
        ROUND(SUM(Sales), 2)    AS total_sales,
        ROUND(SUM(Profit), 2)   AS total_profit
    FROM [Sample superstore].dbo.SampleSuperstore
    GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)
SELECT
    order_year,
    order_month,
    total_sales,
    LAG(total_sales)  OVER (ORDER BY order_year, order_month) AS prev_month_sales,
    LEAD(total_sales) OVER (ORDER BY order_year, order_month) AS next_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY order_year, order_month))
        / NULLIF(LAG(total_sales) OVER (ORDER BY order_year, order_month), 0)
        * 100, 2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY order_year, order_month;

-- Query 2: NTILE — performance buckets
WITH sales_buckets AS (
    SELECT
        Region,
        Category,
        Sub_Category,
        ROUND(Sales, 2)  AS sales,
        ROUND(Profit, 2) AS profit,
        NTILE(4) OVER (ORDER BY Sales DESC) AS sales_quartile
    FROM [Sample superstore].dbo.SampleSuperstore
)
SELECT
    Region,
    Category,
    Sub_Category,
    sales,
    profit,
    sales_quartile,
    CASE sales_quartile
        WHEN 1 THEN 'Top 25%'
        WHEN 2 THEN 'Upper Mid 25%'
        WHEN 3 THEN 'Lower Mid 25%'
        WHEN 4 THEN 'Bottom 25%'
    END AS performance_tier
FROM sales_buckets
ORDER BY sales_quartile, sales DESC;

-- Query 3: PERCENTILE_CONT — profit percentiles per category
SELECT DISTINCT
    Category,
    ROUND(
        PERCENTILE_CONT(0.25)
        WITHIN GROUP (ORDER BY Profit)
        OVER (PARTITION BY Category), 2
    ) AS p25_profit,
    ROUND(
        PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY Profit)
        OVER (PARTITION BY Category), 2
    ) AS median_profit,
    ROUND(
        PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY Profit)
        OVER (PARTITION BY Category), 2
    ) AS p75_profit,
    ROUND(AVG(Profit) OVER (PARTITION BY Category), 2) AS avg_profit
FROM [Sample superstore].dbo.SampleSuperstore
ORDER BY Category;

-- EDA FULL SALES ANalysis 

-- Query 1: overall KPIs
SELECT
    COUNT(*)                                                     AS total_orders,
    SUM(Quantity)                                                AS total_units_sold,
    ROUND(SUM(Sales), 2)                                         AS total_revenue,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(Sales), 2)                                         AS avg_order_value,
    ROUND(AVG(Discount) * 100, 2)                                AS avg_discount_pct,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS overall_profit_margin_pct,
    ROUND(MIN(Sales), 2)                                         AS min_order_value,
    ROUND(MAX(Sales), 2)                                         AS max_order_value
FROM [Sample superstore].dbo.SampleSuperstore;


-- Query 2a: by region
SELECT Region,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER(), 2)       AS pct_of_total
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region ORDER BY total_sales DESC;

-- Query 2c: by segment
SELECT Segment,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER(), 2)       AS pct_of_total
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Segment ORDER BY total_sales DESC;


-- Query 2d: by ship mode
SELECT Ship_Mode,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER(), 2)       AS pct_of_total
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Ship_Mode ORDER BY total_sales DESC;

-- Query 3a: top 10 states
SELECT TOP 10
    State, Region,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS profit_margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY State, Region
ORDER BY total_sales DESC;

--Bottom 10 states
SELECT TOP 10
STATE,Region, 
COUNT(*) AS orders,
ROUND(SUM(Sales),2) AS total_sales, 
ROUND(SUM(Profit),2) AS total_profit,
ROUND(SUM(Profit)/ NULLIF (Sum(Sales),0)*100,2)AS profit_margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY State,Region
ORDER BY total_sales ASC;


-- Query 4 Sub - category deep dive 

-- Query 4: sub-category deep dive
WITH subcat_sales AS (
    SELECT
        Category, Sub_Category,
        COUNT(*)                                                 AS orders,
        SUM(Quantity)                                            AS units_sold,
        ROUND(SUM(Sales), 2)                                     AS total_sales,
        ROUND(SUM(Profit), 2)                                    AS total_profit,
        ROUND(AVG(Discount) * 100, 2)                            AS avg_discount_pct,
        ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)     AS profit_margin_pct
    FROM [Sample superstore].dbo.SampleSuperstore
    GROUP BY Category, Sub_Category
)
SELECT
    Category, Sub_Category, orders, units_sold,
    total_sales, total_profit, avg_discount_pct, profit_margin_pct,
    RANK() OVER (ORDER BY total_sales DESC)                      AS sales_rank,
    ROUND(total_sales * 100.0 / SUM(total_sales) OVER(), 2)     AS pct_of_total,
    ROUND(SUM(total_sales) OVER (
        ORDER BY total_sales DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2)                                                        AS running_total_sales
FROM subcat_sales
ORDER BY sales_rank;

--Profit KPI 

-- Query 1 : Profit KPI 

-- Query 1: profit KPIs
SELECT
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(Profit), 2)                                        AS avg_profit_per_order,
    ROUND(MIN(Profit), 2)                                        AS worst_loss,
    ROUND(MAX(Profit), 2)                                        AS best_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS overall_margin_pct,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)                 AS loss_orders,
    SUM(CASE WHEN Profit = 0 THEN 1 ELSE 0 END)                 AS break_even_orders,
    SUM(CASE WHEN Profit > 0 THEN 1 ELSE 0 END)                 AS profitable_orders,
    ROUND(
        SUM(CASE WHEN Profit < 0 THEN 1.0 ELSE 0 END) /
        NULLIF(COUNT(*), 0) * 100, 2
    )                                                            AS loss_order_pct
FROM [Sample superstore].dbo.SampleSuperstore;


-- Query 2a: profit by region + category
SELECT
    Region, Category,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS margin_pct,
    CASE
        WHEN SUM(Profit) < 0 THEN 'LOSS'
        WHEN SUM(Profit) = 0 THEN 'BREAK EVEN'
        ELSE 'PROFIT'
    END                                                          AS status
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region, Category
ORDER BY total_profit ASC;


-- Query 2b: loss-making sub-categories with full detail
SELECT
    Category, Sub_Category, Region,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(Discount) * 100, 2)                                AS avg_discount_pct,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category, Sub_Category, Region
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;



-- Query 3: discount impact on profit
SELECT
    CASE
        WHEN Discount = 0                       THEN 'No Discount'
        WHEN Discount > 0   AND Discount <= 0.2 THEN 'Low (1-20%)'
        WHEN Discount > 0.2 AND Discount <= 0.4 THEN 'Medium (21-40%)'
        WHEN Discount > 0.4 AND Discount <= 0.6 THEN 'High (41-60%)'
        WHEN Discount > 0.6                     THEN 'Extreme (>60%)'
    END                                                          AS discount_bucket,
    COUNT(*)                                                     AS orders,
    ROUND(AVG(Sales), 2)                                         AS avg_sales,
    ROUND(AVG(Profit), 2)                                        AS avg_profit,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY
    CASE
        WHEN Discount = 0                       THEN 'No Discount'
        WHEN Discount > 0   AND Discount <= 0.2 THEN 'Low (1-20%)'
        WHEN Discount > 0.2 AND Discount <= 0.4 THEN 'Medium (21-40%)'
        WHEN Discount > 0.4 AND Discount <= 0.6 THEN 'High (41-60%)'
        WHEN Discount > 0.6                     THEN 'Extreme (>60%)'
    END
ORDER BY avg_profit DESC;




-- Query 4: monthly profit trend with MoM growth
;WITH monthly_profit AS (
    SELECT
        YEAR(Order_Date)             AS order_year,
        MONTH(Order_Date)            AS order_month,
        DATENAME(MONTH, Order_Date)  AS month_name,
        ROUND(SUM(Profit), 2)        AS total_profit,
        ROUND(SUM(Sales), 2)         AS total_sales
    FROM [Sample superstore].dbo.SampleSuperstore
    GROUP BY YEAR(Order_Date), MONTH(Order_Date), DATENAME(MONTH, Order_Date)
)
SELECT
    order_year, order_month, month_name,
    total_sales, total_profit,
    ROUND(total_profit / NULLIF(total_sales, 0) * 100, 2)        AS margin_pct,
    LAG(total_profit) OVER (ORDER BY order_year, order_month)    AS prev_month_profit,
    ROUND(
        (total_profit - LAG(total_profit) OVER (ORDER BY order_year, order_month))
        / NULLIF(ABS(LAG(total_profit) OVER (ORDER BY order_year, order_month)), 0)
        * 100, 2
    )                                                            AS mom_profit_growth_pct
FROM monthly_profit
ORDER BY order_year, order_month;


-- EDA: Customer Segment & Shipping Analysis! 🚀
-- Query 1: full segment profiling
SELECT
    Segment,
    COUNT(*)                                                     AS total_orders,
    SUM(Quantity)                                                AS total_units,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(Sales), 2)                                         AS avg_order_value,
    ROUND(AVG(Discount) * 100, 2)                                AS avg_discount_pct,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS profit_margin_pct,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER(), 2)       AS pct_of_total_sales,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)                 AS loss_orders
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Segment
ORDER BY total_profit DESC;

-- Query 2: segment x category x region cross analysis
SELECT
    Segment, Category, Region,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(Discount) * 100, 2)                                AS avg_discount_pct,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS margin_pct,
    CASE
        WHEN SUM(Profit) < 0 THEN 'LOSS'
        WHEN SUM(Profit) = 0 THEN 'BREAK EVEN'
        ELSE 'PROFIT'
    END                                                          AS status
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Segment, Category, Region
ORDER BY total_profit ASC;

-- Query 3: full shipping mode analysis
SELECT
    Ship_Mode,
    COUNT(*)                                                     AS total_orders,
    SUM(Quantity)                                                AS total_units,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(Sales), 2)                                         AS avg_order_value,
    ROUND(AVG(Discount) * 100, 2)                                AS avg_discount_pct,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)         AS margin_pct,
    ROUND(AVG(DATEDIFF(DAY, Order_Date, Ship_Date)), 1)          AS avg_ship_days,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER(), 2)       AS pct_of_total_sales
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Ship_Mode
ORDER BY total_profit DESC;

-- Query 4: shipping preference by segment and region
SELECT
    Segment, Region, Ship_Mode,
    COUNT(*)                                                     AS orders,
    ROUND(SUM(Sales), 2)                                         AS total_sales,
    ROUND(SUM(Profit), 2)                                        AS total_profit,
    ROUND(AVG(DATEDIFF(DAY, Order_Date, Ship_Date)), 1)          AS avg_ship_days,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Segment, Region),
    2)                                                           AS pct_of_segment_region
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Segment, Region, Ship_Mode
ORDER BY Segment, Region, orders DESC;


--Final Production Master Query — complete business EDA

-- Create master view
CREATE VIEW vw_master_eda AS
WITH base AS (
    SELECT
        Region, State, City, Segment, Category, Sub_Category, Ship_Mode,
        YEAR(Order_Date)                                         AS order_year,
        'Q' + CAST(DATEPART(QUARTER, Order_Date) AS VARCHAR)    AS quarter,
        MONTH(Order_Date)                                        AS order_month,
        DATENAME(MONTH, Order_Date)                              AS month_name,
        COUNT(*)                                                 AS total_orders,
        SUM(Quantity)                                            AS total_units,
        ROUND(SUM(Sales), 2)                                     AS total_sales,
        ROUND(SUM(Profit), 2)                                    AS total_profit,
        ROUND(AVG(Sales), 2)                                     AS avg_order_value,
        ROUND(AVG(Discount) * 100, 2)                            AS avg_discount_pct,
        ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)     AS profit_margin_pct,
        ROUND(AVG(DATEDIFF(DAY, Order_Date, Ship_Date)), 1)      AS avg_ship_days,
        SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)             AS loss_orders,
        CASE
            WHEN SUM(Profit) > 0 THEN 'Profitable'
            WHEN SUM(Profit) < 0 THEN 'Loss'
            ELSE 'Break Even'
        END                                                      AS profit_status
    FROM [Sample superstore].dbo.SampleSuperstore
    GROUP BY
        Region, State, City, Segment, Category, Sub_Category, Ship_Mode,
        YEAR(Order_Date), DATEPART(QUARTER, Order_Date),
        MONTH(Order_Date), DATENAME(MONTH, Order_Date)
)
SELECT
    *,
    RANK() OVER (ORDER BY total_sales DESC)                      AS sales_rank,
    RANK() OVER (ORDER BY total_profit DESC)                     AS profit_rank,
    ROUND(total_sales * 100.0 / SUM(total_sales) OVER(), 2)     AS pct_of_total_sales,
    ROUND(total_profit * 100.0 / NULLIF(SUM(total_profit) OVER(), 0), 2) AS pct_of_total_profit
FROM base;

-- Test queries
SELECT * FROM vw_master_eda ORDER BY profit_rank;

SELECT TOP 10 * FROM vw_master_eda ORDER BY total_profit DESC;

SELECT * FROM vw_master_eda WHERE profit_status = 'Loss' ORDER BY total_profit ASC;

SELECT
    Region,
    SUM(total_orders) AS orders,
    SUM(total_sales)  AS sales,
    SUM(total_profit) AS profit
FROM vw_master_eda
GROUP BY Region
ORDER BY profit DESC;




CREATE VIEW vw_region_performance AS
SELECT
    Region,
    COUNT(*)                                             AS total_orders,
    ROUND(SUM(Sales), 2)                                 AS total_sales,
    ROUND(SUM(Profit), 2)                                AS total_profit,
    ROUND(AVG(Discount), 2)                              AS avg_discount,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Region;

CREATE VIEW vw_subcat_profitability AS
SELECT
    Category,
    Sub_Category,
    COUNT(*)                                             AS total_orders,
    ROUND(SUM(Sales), 2)                                 AS total_sales,
    ROUND(SUM(Profit), 2)                                AS total_profit,
    ROUND(AVG(Discount), 2)                              AS avg_discount,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct,
    CASE
        WHEN SUM(Profit) > 0 THEN 'Profitable'
        WHEN SUM(Profit) < 0 THEN 'Loss'
        ELSE 'Break Even'
    END                                                  AS profit_status
FROM [Sample superstore].dbo.SampleSuperstore
GROUP BY Category, Sub_Category;


SELECT * FROM vw_region_performance;
SELECT * FROM vw_subcat_profitability;
SELECT * FROM vw_master_eda;
SELECT TOP 10 * FROM SampleSuperstore;
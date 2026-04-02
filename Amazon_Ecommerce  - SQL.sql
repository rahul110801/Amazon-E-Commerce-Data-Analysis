USE ecommerce ;
-- AMAZON ECOMMERCE ANALYSIS
--  OBJECTIVE QUESTIONS --

-- Q 14: Identify the top 5 most valuable customers using a composite score that combines three key metrics: 
-- 	a.	Total Revenue (50% weight): The total amount of money spent by the customer.
-- 	b.	Order Frequency (30% weight): The number of orders placed by the customer, indicating their loyalty and engagement.
-- 	c.	Average Order Value (20% weight): The average value of each order placed by the customer, reflecting the typical transaction size.

WITH customer_metrics AS (
    SELECT 
        cust.CustomerID,
        SUM(ord.SalePrice) AS revenue_sum,
        COUNT(ord.OrderID) AS order_count,
        AVG(ord.SalePrice) AS avg_order_value
    FROM Customers AS cust
    INNER JOIN Orderss AS ord
        ON cust.CustomerID = ord.CustomerID
    GROUP BY cust.CustomerID
)
SELECT 
    CustomerID,
    revenue_sum AS TotalRevenue,
    order_count AS OrderFrequency,
    avg_order_value AS AverageOrderValue,
    (revenue_sum * 0.5 
     + order_count * 0.3 
     + avg_order_value * 0.2) AS CompositeScore
FROM customer_metrics
ORDER BY CompositeScore DESC
LIMIT 5;


-- Q 15: Calculate the month-over-month growth rate in total revenue across the entire dataset.
 
WITH monthly_sales_summary AS (
    SELECT 
        YEAR(OrderDate) AS sales_year,
        MONTH(OrderDate) AS sales_month,
        SUM(SalePrice) AS monthly_revenue
    FROM Orderss
    GROUP BY sales_year, sales_month
)
SELECT 
    sales_year AS Year,
    sales_month AS Month,
    monthly_revenue AS TotalRevenue,
    (
        (monthly_revenue 
         - LAG(monthly_revenue) OVER (ORDER BY sales_year, sales_month))
        / LAG(monthly_revenue) OVER (ORDER BY sales_year, sales_month)
    ) * 100 AS MoMGrowthRate
FROM monthly_sales_summary
ORDER BY sales_year, sales_month;


-- Q 16:	Calculate the rolling 3-month average revenue for each product category.

WITH category_monthly_sales AS (
    SELECT
        YEAR(OrderDate) AS sales_year,
        MONTH(OrderDate) AS sales_month,
        ProductCategory,
        SUM(SalePrice) AS monthly_revenue
    FROM Orderss
    GROUP BY sales_year, sales_month, ProductCategory
)
SELECT
    sales_year AS Year,
    sales_month AS Month,
    ProductCategory,
    AVG(monthly_revenue) OVER (
        PARTITION BY ProductCategory
        ORDER BY sales_year, sales_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Rolling3MonthAvgRevenue
FROM category_monthly_sales
ORDER BY sales_year, sales_month;



-- Q 17: Update the orders table to apply a 15% discount on the `Sale Price` for orders placed by customers who have made at least 10 orders.

UPDATE orderss
SET SalePrice = SalePrice * 0.85
WHERE CustomerID IN (
    SELECT CustomerID
    FROM orderss
    GROUP BY CustomerID
    HAVING COUNT(OrderID) >= 10
);

-- Q 18: Calculate the average number of days between consecutive orders for customers who have placed at least five orders.

WITH ordered_customer_purchases AS (
    SELECT
        o.CustomerID,
        o.OrderID,
        o.OrderDate,
        LEAD(o.OrderDate) OVER (
            PARTITION BY o.CustomerID
            ORDER BY o.OrderDate
        ) AS following_order_date
    FROM Orderss o
)
SELECT
    CustomerID,
    AVG(
        DATEDIFF(following_order_date, OrderDate)
    ) AS AvgDaysBetweenOrders
FROM ordered_customer_purchases
WHERE following_order_date IS NOT NULL
GROUP BY CustomerID
HAVING COUNT(*) >= 5;




-- Q 19: Identify customers who have generated revenue that is more than 30% higher than the average revenue per customer.

WITH customer_revenue_summary AS (
    SELECT
        CustomerID,
        SUM(SalePrice) AS customer_total_revenue
    FROM Orderss
    GROUP BY CustomerID
),
overall_avg_revenue AS (
    SELECT
        AVG(SalePrice) AS overall_avg_sale
    FROM Orderss
)
SELECT
    cr.CustomerID,
    cr.customer_total_revenue AS TotalRevenue
FROM customer_revenue_summary cr
JOIN overall_avg_revenue oar
    ON cr.customer_total_revenue > oar.overall_avg_sale * 1.30;


-- Q 20: Determine the top 3 product categories that have shown the highest increase in sales over the past year compared to the previous year. 

WITH yearly_category_sales AS (
    SELECT
        ProductCategory,
        YEAR(OrderDate) AS sales_year,
        SUM(SalePrice) AS year_total_sales
    FROM Orderss
    WHERE YEAR(OrderDate) IN (2019, 2020)
    GROUP BY ProductCategory, sales_year
)
SELECT
    curr.ProductCategory,
    curr.year_total_sales AS CurrentYearSales,
    prev.year_total_sales AS PreviousYearSales,
    (curr.year_total_sales - prev.year_total_sales) AS SalesIncrease
FROM yearly_category_sales curr
JOIN yearly_category_sales prev
    ON curr.ProductCategory = prev.ProductCategory
   AND curr.sales_year = 2020
   AND prev.sales_year = 2019
ORDER BY SalesIncrease DESC
LIMIT 3;




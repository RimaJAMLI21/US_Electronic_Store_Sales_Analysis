-- US ELECTRONIC SALES ANALYSIS --

select * from sales;

/** Question 1: What was the best month for sales? How much was earned that month? **/

select Month,sum(Sales) as Revenues_per_month
from sales
group by Month
order by Revenues_per_month desc;

 /**Question 2: What city has the highest sales?**/

 select top 5 City ,sum(Sales) as Revenues_per_city
 from sales 
 group by City
 order by Revenues_per_city desc ;

 /** Question 3: What time should we display advertisements to maximize the likelihood of customers buying products?**/
 --Based on net sales--
 select Hour,sum(Sales) as Revenues_per_Hour
 from sales 
 group by Hour
 order by Revenues_per_Hour desc ;
 --Based on number of orders
 SELECT 
    Hour,
    COUNT(*) AS OrderCount
FROM 
    sales
GROUP BY 
    Hour
ORDER BY 
    OrderCount DESC;
 --Based on Quantity sold
  SELECT 
    Hour,
    sum(Quantity_Ordered) AS Quantity_sold
FROM 
    sales
GROUP BY 
    Hour
ORDER BY 
    Quantity_sold DESC;

 /** Question 4: What products are most often sold together?**/

-- Create the Sold_together table
CREATE TABLE Sold_together (
    Order_ID INT PRIMARY KEY,
    product_combination NVARCHAR(MAX)
);

-- Insert data into the Sold_together table
INSERT INTO Sold_together (Order_ID, product_combination)
SELECT DISTINCT
    s1.Order_ID,
    STRING_AGG(s2.Product, ',') AS product_combination
FROM
    sales s1
JOIN
    sales s2 ON s1.Order_ID = s2.Order_ID AND s1.Product <> s2.Product
GROUP BY
    s1.Order_ID;

--solution--

WITH SplitProducts AS (
    SELECT
        Order_ID,
        value AS Product
    FROM
        Sold_together
    CROSS APPLY
        STRING_SPLIT(product_combination, ',')
),
ProductCombinations AS (
    SELECT
        Order_ID,
        STRING_AGG(Product, ',') WITHIN GROUP (ORDER BY Product) AS ProductCombination
    FROM
        SplitProducts
    GROUP BY
        Order_ID
)
SELECT
    ProductCombination,
    COUNT(*) AS OccurrenceCount
FROM
    ProductCombinations
GROUP BY
    ProductCombination
ORDER BY
    OccurrenceCount DESC

/**Question 5: What product sold the most? Why do you think it sold the most?**/

select top 5 Product, sum(Quantity_Ordered) as product_sold_most
from sales
group by Product
order by product_sold_most desc


/**Question 6 : What are the top products that represents highest revenues? **/

select top 5 Product, sum(Sales) as product_sold_most_by_Revenues
from sales
group by Product
order by product_sold_most_by_Revenues desc










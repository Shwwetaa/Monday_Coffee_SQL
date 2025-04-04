select * from sales;
select * from city;
select * from products;
select * from customers;

--Q.1 Coffee Consumers Count
--How many people in each city are estimated to consume coffee, given that 25% of the population does?

select city_name, (population * 0.25) as Coffee_Consumers, city_rank
from city
order by 2 desc

-- Q.2
-- Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

select SUM(total) as Total_Revenue
	from sales
where Extract(year from sale_date) = 2023 AND
Extract(quarter from sale_date) = 4

--Q.3
-- Sales Count for Each Product
-- How many units of each coffee product have been sold?

select p.product_name, count(s.sale_id) as total_order
from products as p
left join sales as s
on s.product_id= p.product_id
group by 1
order by 2 desc

-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?

SELECT ci.city_name,
	SUM(s.total) as total_revenue,
	COUNT(DISTINCT s.customer_id) as total_cust,
	ROUND(SUM(s.total)::numeric/COUNT(DISTINCT s.customer_id)::numeric,2) as avg_sale_pr_cust
	
FROM sales as s
JOIN customers as c
ON s.customer_id = c.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
GROUP BY 1
ORDER BY 2 DESC

-- Q.5
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?

SELECT  ci.city_name, COUNT(DISTINCT c.customer_id) as unique_cust
FROM city as ci
LEFT JOIN
customers as c ON c.city_id = ci.city_id
JOIN sales as s ON s.customer_id = c.customer_id
WHERE 
	s.product_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)
GROUP BY 1









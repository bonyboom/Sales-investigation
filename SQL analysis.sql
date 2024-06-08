 -- TASK1: Dtermine the most popular products
 -- This analysis will help us to understand in wich products costumers focuses in
SELECT 
	product_name, 
	SUM(unit_sold) AS total_quantity,
	product_category
FROM sales
GROUP BY product_name, product_category
ORDER BY total_quantity DESC 
LIMIT 6 
/* RESULT: We've determined that the most preferred products are in the Clothing category, 
but is this the most profitable category? */


-- Determine total revenue and sales quantity.
SELECT 
	product_category,
	ROUND(CAST(SUM(total_revenue) AS DECIMAL), 2) as total_revenue,
	SUM(unit_sold) as sold_units
FROM sales
GROUP BY product_category
ORDER BY total_revenue DESC 
/* RESULT: We can observe that the sale of clothing does not show the highest revenue.
This table is a clear example that the largest number of s
ales does't mean that there will be the largest profit */


/* Let's find out how much income we received from each category, 
provided that we receive 25% from each sale? */
 SELECT 
	product_category,
	ROUND(CAST(profit AS DECIMAL), 2) as profit
FROM (SELECT 
		product_category,
		(SUM(total_revenue) * 0.25) as profit
		FROM sales
		GROUP by product_category)
ORDER BY profit DESC 
-- RESULT: We see that we have the biggest profit from the sale of electronics


-- TASK 3: What payment method is used most often
/* This investigation will help us create a special offer 
or loyalty program for customers who most often use certain payment methods */
 SELECT 
	payment_method, 
	COUNT(*) AS payment_count
FROM sales
GROUP BY payment_method
ORDER BY payment_count DESC 
/* RESULT: Now we may see, that "Credit Card" is the most preferable payment method. 
In this case we can think about loyalty programs for this sector. 
By the way we may also advise some offers for paying by Debit Card for incr. 
the value for this payment method as well. */

-- TASK 4: Let's investigate the regions who buy our staff 
WITH t1 AS (
SELECT
	region,
    SUM(total_revenue) AS total_revenue,
    SUM(unit_sold) AS unit_sold
FROM sales
GROUP BY region),
	t2 AS (
SELECT
    region,
    total_revenue,
    unit_sold,
    (total_revenue * 1.0 / unit_sold) AS average
FROM t1)
SELECT
	region,
	total_revenue,
	average,
    unit_sold
FROM t2
ORDER BY total_revenue DESC;
/* Now we see the main segment of our customers, 
based on this information we can develop marketing campaigns based 
on the cultural or others characteristics of a particular region */
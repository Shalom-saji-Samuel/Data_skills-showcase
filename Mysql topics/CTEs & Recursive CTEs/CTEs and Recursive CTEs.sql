-- How to use this code : first you would need mysql's latest version , then run in local host or any server.
-- 						  Download the sakila database , and connect it to your mysql , then copy paste these querries
-- 						  then you can see these querries .

-- Task 1: Find the top 5 customers by number of rentals using a CTE.
WITH top_customer_by_rentals as (
	SELECT customer_id , 
		   COUNT(rental_id) as total_rentals
	FROM rental
    GROUP BY customer_id 
    ORDER BY total_rentals DESC 
    LIMIT 5 )
SELECT * FROM top_customer_by_rentals;

-- Task 2: Create a CTE that calculates the total revenue per film category, then use it to return the top 3 categories.
WITH total_rev_film as(
	SELECT SUM(p.amount) as revenue,
		   c.name
	FROM payment p 
    JOIN rental r on p.rental_id = r.rental_id
    JOIN inventory i on r.inventory_id = i.inventory_id
    JOIN film f on i.film_id = f.film_id
    JOIN film_category fc on f.film_id = fc.film_id
	JOIN category c on fc.category_id = c.category_id 
    GROUP BY c.name
    ORDER BY revenue DESC)
SELECT * FROM total_rev_film LIMIT 3;
-- Returns :
-- revenue  name 
-- 5314.21	Sports
-- 4756.98	Sci-Fi
-- 4656.30	Animation
-- Hence the code works

-- Task 3: Use a recursive CTE to generate numbers 1–12 and join with payment table to show monthly revenue trends.
WITH RECURSIVE months as (
	SELECT 1 month_number
    UNION ALL
    SELECT month_number + 1 
    FROM months 
    WHERE month_number < 12),
monthly_revenue as (
	SELECT MONTH(payment_date) as payment_month,
		   SUM(amount) as revenue 
	FROM payment
    GROUP BY payment_month)
SELECT m.month_number , 
	   coalesce(m_r.revenue) as Total_revenue
FROM months m
LEFT JOIN monthly_revenue m_r 
ON m.month_number = m_r.payment_month
ORDER BY m.month_number ;


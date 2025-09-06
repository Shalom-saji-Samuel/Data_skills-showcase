-- Task 1 :Customer Insights ;
-- Find customers who spent above the average total spending of all customers.

SELECT SUM(amount) as total,
	   customer_id
FROM payment 
GROUP BY customer_id
HAVING total > (
	select avg(total_paid) 
    from (select sum(amount) as total_paid
		  from payment
          group by customer_id) as avg_of_total )
ORDER BY total desc
LIMIT 5;

-- here the average was pretty low so instead of just seeing most of the customers
-- I made the query so that it gives out top 5 customers with above average total spending

-- Task 2 : Store Comparison;
-- Which store generates more revenue, and which categories drive it?

WITH revenue_per_store AS (
  SELECT SUM(p.amount) AS total_revenue,
         s.store_id,
         p.rental_id
  FROM payment p
  JOIN staff s ON p.staff_id = s.staff_id
  GROUP BY s.store_id, p.rental_id
)
SELECT c.name AS category_name,
       rps.store_id,
       SUM(rps.total_revenue) AS total_category_revenue
FROM revenue_per_store rps
JOIN rental r ON rps.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name, rps.store_id
ORDER BY total_category_revenue DESC;

-- Task 3 : Film Insights: 
-- List the top 5 actors who appear in the most rented films.

SELECT COUNT(r.rental_id) as total_rentals,
	   a.first_name ,
       a.last_name 
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_actor f ON i.film_id = f.film_id
JOIN actor a ON f.actor_id = a.actor_id
GROUP BY a.first_name , a.last_name
ORDER BY total_rentals desc
LIMIT 10;

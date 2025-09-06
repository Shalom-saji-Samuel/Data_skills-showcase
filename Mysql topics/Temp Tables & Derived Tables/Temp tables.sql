-- Task 1 : Store the list of customers with more than 30 rentals in a temp table, then query it for customers with most rentals.

CREATE TEMPORARY TABLE cust_more_30rentals (
	SELECT c.first_name ,
		   COUNT(r.rental_id) as total_rentals
	FROM rental r
    JOIN customer c ON r.customer_id = c.customer_id
    GROUP BY c.first_name);
    
-- the above query makes a temp table with customer name and number of rentals they have made ,
-- the next query gives the customers with most rentals 

SELECT * FROM cust_more_30rentals 
ORDER BY total_rentals desc
LIMIT 5;

-- Task 2 : Create a temp table that summarizes number of rentals made by staff member per month.

DROP TABLE IF EXISTS rentals_per_staff;
CREATE TEMPORARY TABLE rentals_per_staff (
	SELECT s.first_name , rental_date,
		   COUNT(r.rental_id) as total_rentals
	FROM rental r
    JOIN staff s ON r.staff_id = s.staff_id
    GROUP BY s.first_name, r.rental_date);

-- here the above query provides staff's firstname along with the rentals they made
-- The next query is for calculating their rentals per month , ordered as highest rentals first .

SELECT 
    MONTHNAME(rental_date) AS month_name,
    SUM(total_rentals) AS tot_rentals,
    first_name
FROM
    rentals_per_staff
GROUP BY month_name , first_name
ORDER BY tot_rentals DESC;

-- Task 3 : Build a multi-step analysis: 
-- 1st step : find total rentals per store.

DROP TABLE IF EXISTS tot_rents_per_store;
CREATE TEMPORARY TABLE tot_rents_per_store (
	SELECT COUNT(r.rental_id) as num_rentals,
		   s.store_id 
	FROM rental r 
    JOIN staff s ON r.staff_id = s.staff_id
    GROUP BY s.store_id);

-- 2nd step : total revenue per store.

DROP TABLE IF EXISTS tot_rev_per_store ;
CREATE TEMPORARY TABLE tot_rev_per_store (
	SELECT SUM(p.amount) as revenue,
		   s.store_id 
	FROM payment p 
    JOIN staff s ON p.staff_id = s.staff_id
    GROUP BY s.store_id);

-- final step : merge and compare store performance.
SELECT t_rev.store_id, 
	   SUM(t_rent.num_rentals) as rentals,
	   t_rev.revenue
FROM tot_rents_per_store t_rent
JOIN tot_rev_per_store t_rev 
ON t_rent.store_id = t_rev.store_id
GROUP BY t_rev.store_id, t_rev.revenue;
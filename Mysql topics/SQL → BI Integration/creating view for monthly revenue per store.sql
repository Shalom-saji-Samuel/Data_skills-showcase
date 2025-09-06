-- Write a query that outputs monthly revenue by store. Save it as a SQL view

CREATE VIEW monthly_rev_by_store as 
SELECT SUM(p.amount) as revenue,
	   MONTHNAME(p.payment_date) as month_name,
       s.store_id
FROM payment p 
JOIN staff st ON p.staff_id = st.staff_id 
JOIN store s ON st.store_id = s.store_id 
GROUP BY month_name , s.store_id;
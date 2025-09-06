-- In the sakila database , it already comes with indexes which makes the querries run faster
-- Hence Im going to have to assume there is no indexes in the customer column

CREATE INDEX first_name_last_name
ON customer(first_name , last_name); 
 
-- the above querry provides an index of customer's first name and last name 
-- The customers table isnt a very good pick for a index ,if this dataset was updated constantly
-- a better target would be the country , city or category tables 

-- Index for Country table
CREATE INDEX country_name
ON country(country);

-- This is how we create an index 
ALTER TABLE customer 
DROP INDEX first_name_last_name;

-- this query deletes the index from customer's table 

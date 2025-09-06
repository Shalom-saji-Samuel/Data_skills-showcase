## Showing schema design and explaining normalizations

**Objective:**  
Try to show the design of the interconnected tables.  

**What I did:**  
- Visualize schema design .  

**Disclaimer**
To open the 'Schema design.drawio' file , first download the file then go to draw.io click on "Open Existing Diagram" from the menu.
Select the "Device" option and navigate to the file's location.

**Explaination of normalization in this schema**
The schema is normalized as we can see all the data on the customer is spread out between four tables , that being customer which includes their names and ids
which are essentially jus foreign keys , connecting the customer table to the other tables . 
In conclusion This schema from the sakila database is using different tables to limit the redundancy we may get when searching in the customer's table

**A star schema format for the same schema**
Fact Table:

fact_customer_location (customer_id, address_id, city_id, country_id, [maybe store_id]).

Dimension Tables:

dim_customer (customer details, active status).

dim_location (country, city, address rolled into one for easy slicing).

dim_date (create_date, last_update broken into year/month/day).

Here I have to do some denormalization so as to make it a star schema.
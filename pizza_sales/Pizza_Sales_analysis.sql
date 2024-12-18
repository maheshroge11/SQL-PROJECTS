CREATE DATABASE Pizzahut;

CREATE TABLE orders(
order_id INT NOT NULL,
order_date DATE NOT NULL,
order_time TIME NOT NULL,
PRIMARY KEY(order_id) );



CREATE TABLE order_details(
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id TEXT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY(order_details_id) );


=============================================================================================================================================

-- Q1 Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id)
FROM
    orders;

==============================================================================================================================================

-- Q2 Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_revenue
FROM
    order_details JOIN pizzas 
    ON pizzas.pizza_id = order_details.pizza_id;

==============================================================================================================================================

-- Q3 Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types JOIN pizzas 
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

================================================================================================================================================

-- Q4 Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    order_details JOIN pizzas 
    ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

================================================================================================================================================

-- Q5 List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS sum_order_quantity
FROM
    pizza_types JOIN pizzas 
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
	JOIN order_details 
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY sum_order_quantity DESC
LIMIT 5;

================================================================================================================================================

-- Q6 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Total_category
FROM
    pizza_types JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
	JOIN order_details 
	ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_category DESC;

================================================================================================================================================

-- Q7 Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hours, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

================================================================================================================================================

-- Q8 Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

===============================================================================================================================================

-- Q9 Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizza_ordered
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders JOIN order_details 
        ON order_details.order_id = orders.order_id
    GROUP BY orders.order_date) AS avearge_numbers_pizza;
    
=================================================================================================================================================

-- Q10 Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
	JOIN order_details 
	ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

================================================================================================================================================

-- Q11 Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND((SUM(order_details.quantity * pizzas.price) / (SELECT SUM(order_details.quantity * pizzas.price)
FROM
    order_details JOIN pizzas 
    ON pizzas.pizza_id = order_details.pizza_id)) * 100,2) AS revenue

FROM
    pizza_types JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
	JOIN order_details 
	ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

================================================================================================================================================

-- Q12 Analyze the cumulative revenue generated over time.

SELECT 
	order_date, sum(revenue) over (ORDER BY order_date) AS cumulative_revenue
FROM
	(SELECT orders.order_date, sum(order_details.quantity * pizzas.price) AS revenue 
FROM 
	order_details JOIN pizzas
    ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders
    ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) AS sales;

===============================================================================================================================================

-- Q13 Determine the top 3 most ordered pizza types based on revenue for each pizza category.


SELECT 
	name, revenue, category
FROM 
	(SELECT category, name, revenue, 
	RANK () OVER (partition by category order by revenue desc) as rn
FROM
	(SELECT pizza_types.category, pizza_types.name, sum(order_details.quantity * pizzas.price) AS revenue
FROM 
	pizza_types JOIN pizzas
	ON pizza_types.pizza_type_id = pizzas.pizza_type_id
	JOIN order_details
	ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn <= 3 ;


==================================================================================================================================================
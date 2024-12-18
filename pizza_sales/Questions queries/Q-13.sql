-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.


SELECT name, revenue, category
FROM (SELECT category, name, revenue, 
RANK () OVER (partition by category order by revenue desc) as rn
FROM
(SELECT pizza_types.category, pizza_types.name, sum(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn <= 3 ;
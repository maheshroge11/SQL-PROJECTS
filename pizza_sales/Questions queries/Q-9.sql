-- Group the orders by date and calculate the average number of pizzas ordered per day.


SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizza_ordered
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders JOIN order_details 
        ON order_details.order_id = orders.order_id
    GROUP BY orders.order_date) AS avearge_numbers_pizza;
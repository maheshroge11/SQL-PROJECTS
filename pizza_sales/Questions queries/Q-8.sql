-- Join relevant tables to find the category-wise distribution of pizzas.


SELECT 
    pizza_types.category, COUNT(name)
FROM
    pizza_types
GROUP BY category;
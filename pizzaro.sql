Use  pizzaro;
-- Retrieve the total number of orders placed.


SELECT COUNT(*) AS total_orders FROM orders;


-- Calculate the total revenue generated from pizza sales.

SELECT 
    SUM(od.quantity * p.price) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;
    
    
    
    -- Identify the highest-priced pizza.

SELECT 
    pizza_id, price
FROM
    pizzas
ORDER BY price DESC
LIMIT 1;


-- Identify the most common pizza size ordered.

SELECT 
    p.size, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;


-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    p.pizza_id, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_id
ORDER BY total_quantity DESC
LIMIT 5;


-- Join the necessary tables to find the total quantity of each pizza category ordered.alter

SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;


-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pt.category, COUNT(DISTINCT p.pizza_id) AS pizza_count
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY pizza_count DESC;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    p.pizza_id, SUM(od.quantity * p.price) AS revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_id
ORDER BY revenue DESC
LIMIT 3;


-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    p.pizza_id,
    SUM(od.quantity * p.price) AS revenue,
    ROUND(SUM(od.quantity * p.price) * 100.0 / (SELECT 
                    SUM(od.quantity * p.price)
                FROM
                    order_details od
                        JOIN
                    pizzas p ON od.pizza_id = p.pizza_id),
            2) AS percentage_contribution
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_id
ORDER BY percentage_contribution DESC;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
    pt.category,
    p.pizza_id,
    SUM(od.quantity * p.price) AS revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category , p.pizza_id
ORDER BY pt.category , revenue DESC
LIMIT 3;

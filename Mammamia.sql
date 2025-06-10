-- Retrieve the total number of orders placed

select * from orders;

SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;


-- Identify the highest-priced pizza.

select pizza_types.name, pizzas.price from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- Identify the most common pizza size ordered.

select pizzas.size , count(orders_details.order_details_id) as order_count
from pizzas join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size
order by order_count desc;

-- List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name, sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by quantity desc limit 5;

-- find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(orders_details.quantity) as quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- Determine the distribution of order by hour of the day. 

SELECT hour(order_time) as hour,
 count(order_id) as order_count
 FROM orders
 GROUP BY hour(order_time);
 
 -- Find category-wise distribution of pizzas.
 
 SELECT category, count(name) FROM pizza_types
 GROUP BY category;
 
 -- Group the orders by date and calculate the average number of pizzas ordered per day. 
 
 SELECT round(avg(quantity),0) as avg_pizza_order_per_day
 FROM 
 ( SELECT orders.order_date, SUM(orders_details.quantity) as quantity
 FROM orders JOIN orders_details 
 ON orders.order_id = orders_details.order_id
 GROUP BY orders.order_date) as order_quantity;
 
 -- Determine the top 3 most ordered pizza types based on revenue. 
 
 SELECT pizza_types.name, SUM(orders_details.quantity * pizzas.price) as revenue
 FROM pizza_types JOIN pizzas
 ON pizzas.pizza_type_id = pizza_types.pizza_type_id
 JOIN orders_details
 ON orders_details.pizza_id = pizzas.pizza_id
 GROUP BY pizza_types.name
 ORDER BY revenue DESC LIMIT 3;
 

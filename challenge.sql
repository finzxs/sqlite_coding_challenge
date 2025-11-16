--step 1: Write a SQL query to find the top 5 customers who have spent the most money on orders.

SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders o
    ON o.customer_id = c.id
JOIN order_items oi
    ON oi.order_id = o.id
GROUP BY c.id
ORDER BY total_spend DESC
LIMIT 5;SELECT * FROM customers LIMIT 5;

--step 2: 


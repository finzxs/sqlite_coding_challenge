--step 1: top 5 customers who have spent the most money on orders.

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

--step 2: total revenue generated from each product category.
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p
    ON p.id = oi.product_id
JOIN orders o
    ON o.id = oi.order_id
GROUP BY p.category
ORDER BY revenue DESC;

--step 3: Above average salary employees
WITH dept_avg AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary AS employee_salary,
    dept_avg.avg_salary AS department_average_salary
FROM employees e
JOIN dept_avg
    ON dept_avg.department_id = e.department_id
JOIN departments d
    ON d.id = e.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY d.name, e.salary DESC;

--step 4: Cities with the Most Gold Customers
SELECT
    c.city,
    COUNT(*) AS gold_customer_count
FROM customers c
WHERE c.loyalty_status = 'Gold'
GROUP BY c.city
ORDER BY gold_customer_count DESC, city ASC;

--step 4+: loyalty distribution by city
SELECT
    c.city,
    SUM(CASE WHEN loyalty_level = 'Gold' THEN 1 ELSE 0 END) AS gold_count,
    SUM(CASE WHEN loyalty_level = 'Silver' THEN 1 ELSE 0 END) AS silver_count,
    SUM(CASE WHEN loyalty_level = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY gold_count DESC, city ASC;
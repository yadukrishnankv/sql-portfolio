-- ============================================
-- SQL MINI PROJECT: SALES ANALYSIS (MySQL)
-- ============================================

-- Create and use database
CREATE DATABASE IF NOT EXISTS sql_portfolio;
USE sql_portfolio;

-- ============================================
-- DROP TABLES (FK order safe)
-- ============================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- ============================================
-- CREATE TABLES
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO customers VALUES
(1, 'Arun', 'Kochi'),
(2, 'Meera', 'Calicut'),
(3, 'Rahul', 'Trivandrum'),
(4, 'Anu', 'Kochi'),
(5, 'Kiran', 'Calicut');

INSERT INTO products VALUES
(1, 'Laptop', 50000),
(2, 'Phone', 20000),
(3, 'Tablet', 30000),
(4, 'Headphones', 5000);

INSERT INTO orders VALUES
(1, 1, 1, 1, '2024-01-10'),
(2, 2, 2, 2, '2024-01-11'),
(3, 3, 3, 1, '2024-01-12'),
(4, 1, 2, 1, '2024-01-13'),
(5, 4, 4, 3, '2024-01-14'),
(6, 5, 1, 1, '2024-01-15'),
(7, 2, 3, 2, '2024-01-16'),
(8, 3, 2, 1, '2024-01-17');

-- ============================================
-- BUSINESS PROBLEMS & SOLUTIONS
-- ============================================

-- Problem 1: Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Problem 2: Total revenue generated
SELECT SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Problem 3: Top 3 customers by total spending
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- Problem 4: Most sold product
SELECT p.product_name,
       SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Problem 5: Revenue by each city
SELECT c.city,
       SUM(p.price * o.quantity) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.city;

-- Problem 6: Average order value
SELECT AVG(p.price * o.quantity) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Problem 7: Customers who spent more than 50000
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING total_spent > 50000;

-- Problem 8: Orders with full details
SELECT o.order_id,
       c.customer_name,
       p.product_name,
       o.quantity,
       (p.price * o.quantity) AS total_price,
       o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

-- Problem 9: Customers who never ordered
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Problem 10: Product revenue ranking
SELECT p.product_name,
       SUM(p.price * o.quantity) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Problem 11: Monthly revenue (MySQL FIXED)
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(p.price * o.quantity) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- Problem 12: Categorize customers by spending
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent,
CASE
    WHEN SUM(p.price * o.quantity) < 30000 THEN 'Low'
    WHEN SUM(p.price * o.quantity) BETWEEN 30000 AND 70000 THEN 'Medium'
    ELSE 'High'
END AS spending_category
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name;

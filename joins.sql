-- ============================================
-- SQL PORTFOLIO: JOINS (MySQL Version)
-- ============================================

-- Create and use database
CREATE DATABASE IF NOT EXISTS sql_portfolio;
USE sql_portfolio;

-- ============================================
-- DROP TABLES (order matters because of FK)
-- ============================================

DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ============================================
-- CREATE TABLES
-- ============================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ============================================
-- INSERT DATA
-- ============================================

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO employees VALUES
(1, 'Arun', 25, 40000, 1),
(2, 'Meera', 30, 60000, 2),
(3, 'Rahul', 28, 50000, 3),
(4, 'Anu', 26, 45000, 1),
(5, 'Kiran', 32, 70000, 2),
(6, 'Neha', 29, 55000, 3),
(7, 'Ajay', 27, 48000, 1),
(8, 'Divya', 31, 62000, 4),
(9, 'Ravi', 24, 35000, NULL);

-- ============================================
-- INNER JOIN
-- ============================================

-- Problem 1: Get employee name with department name
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- Problem 2: Show employee details with department
SELECT e.id, e.name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- ============================================
-- LEFT JOIN
-- ============================================

-- Problem 3: Show all employees with department (including NULL)
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

-- Problem 4: Find employees without department
SELECT e.name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- ============================================
-- RIGHT JOIN (SUPPORTED IN MYSQL)
-- ============================================

-- Problem 5: Show all departments and employees
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

-- ============================================
-- FULL OUTER JOIN (SIMULATED IN MYSQL)
-- ============================================

-- Problem 6: Simulate FULL OUTER JOIN
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id

UNION

SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

-- ============================================
-- JOIN WITH CONDITIONS
-- ============================================

-- Problem 7: Employees with salary > 50000 and their department
SELECT e.name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 50000;

-- ============================================
-- AGGREGATION WITH JOIN
-- ============================================

-- Problem 8: Count employees in each department
SELECT d.department_name, COUNT(e.id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Problem 9: Average salary by department
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- ============================================
-- MULTIPLE JOINS (ADVANCED)
-- ============================================

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

INSERT INTO projects VALUES
(1, 'AI System', 1),
(2, 'Web App', 2),
(3, 'Finance Tool', 3),
(4, 'Marketing Campaign', 8);

-- Problem 10: Employee + Department + Project
SELECT e.name, d.department_name, p.project_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN projects p
ON e.id = p.employee_id;

-- ============================================
-- SQL MINI PROJECT: EMPLOYEE ANALYSIS
-- ============================================

-- Drop tables if exist
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
    experience INT,
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
(1, 'Arun', 25, 40000, 1, 2),
(2, 'Meera', 30, 60000, 2, 6),
(3, 'Rahul', 28, 50000, 3, 4),
(4, 'Anu', 26, 45000, 1, 3),
(5, 'Kiran', 32, 70000, 2, 8),
(6, 'Neha', 29, 55000, 3, 5),
(7, 'Ajay', 27, 48000, 1, 3),
(8, 'Divya', 31, 62000, 4, 7),
(9, 'Ravi', 24, 35000, NULL, 1);

-- ============================================
-- BUSINESS PROBLEMS & SOLUTIONS
-- ============================================

-- Problem 1: Total number of employees
SELECT COUNT(*) AS total_employees FROM employees;

-- Problem 2: Department-wise employee count
SELECT d.department_name, COUNT(e.id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Problem 3: Average salary per department
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Problem 4: Highest paid employee
SELECT * FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Problem 5: Top 3 highest paid employees
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Problem 6: Employees with more than 5 years experience
SELECT * FROM employees
WHERE experience > 5;

-- Problem 7: Department with highest average salary
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC
LIMIT 1;

-- Problem 8: Employees earning above department average
SELECT e.name, e.salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- Problem 9: Employees without department
SELECT * FROM employees
WHERE department_id IS NULL;

-- Problem 10: Salary distribution category
SELECT name, salary,
CASE
    WHEN salary < 40000 THEN 'Low'
    WHEN salary BETWEEN 40000 AND 60000 THEN 'Medium'
    ELSE 'High'
END AS salary_category
FROM employees;

-- Problem 11: Total salary expense per department
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Problem 12: Find youngest employee
SELECT * FROM employees
WHERE age = (SELECT MIN(age) FROM employees);

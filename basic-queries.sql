-- ============================================
-- SQL PORTFOLIO: BASIC QUERIES
-- ============================================

-- Dataset: Employee table created for SQL practice

-- Drop table if exists (optional, for re-running)
DROP TABLE IF EXISTS employees;

-- Create table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary INT,
    department VARCHAR(50)
);

-- Insert sample data
INSERT INTO employees VALUES
(1, 'Arun', 25, 40000, 'IT'),
(2, 'Meera', 30, 60000, 'HR'),
(3, 'Rahul', 28, 50000, 'Finance'),
(4, 'Anu', 26, 45000, 'IT'),
(5, 'Kiran', 32, 70000, 'HR'),
(6, 'Neha', 29, 55000, 'Finance'),
(7, 'Ajay', 27, 48000, 'IT'),
(8, 'Divya', 31, 62000, 'HR');

-- ============================================
-- BASIC QUERIES
-- ============================================

-- Problem 1: View all employee records
SELECT * FROM employees;

-- Problem 2: View employee names and salaries
SELECT name, salary FROM employees;

-- Problem 3: Find employees with salary > 50000
SELECT * FROM employees
WHERE salary > 50000;

-- Problem 4: Find employees with salary > 40000 AND age < 30
SELECT * FROM employees
WHERE salary > 40000 AND age < 30;

-- Problem 5: Find employees in HR or IT department
SELECT * FROM employees
WHERE department = 'HR' OR department = 'IT';

-- Problem 6: Find employees NOT in HR
SELECT * FROM employees
WHERE NOT department = 'HR';

-- Problem 7: Find employees with salary between 30000 and 60000
SELECT * FROM employees
WHERE salary BETWEEN 30000 AND 60000;

-- Problem 8: Find employees in HR and Finance
SELECT * FROM employees
WHERE department IN ('HR', 'Finance');

-- Problem 9: Find employees whose name starts with 'A'
SELECT * FROM employees
WHERE name LIKE 'A%';

-- Problem 10: Find employees whose name ends with 'a'
SELECT * FROM employees
WHERE name LIKE '%a';

-- Problem 11: Sort employees by salary (ascending)
SELECT * FROM employees
ORDER BY salary ASC;

-- Problem 12: Sort employees by salary (descending)
SELECT * FROM employees
ORDER BY salary DESC;

-- Problem 13: Get top 5 employees
SELECT * FROM employees
LIMIT 5;

-- ============================================
-- AGGREGATE FUNCTIONS
-- ============================================

-- Problem 14: Count total employees
SELECT COUNT(*) AS total_employees FROM employees;

-- Problem 15: Find total salary
SELECT SUM(salary) AS total_salary FROM employees;

-- Problem 16: Find average salary
SELECT AVG(salary) AS avg_salary FROM employees;

-- Problem 17: Find highest salary
SELECT MAX(salary) AS highest_salary FROM employees;

-- Problem 18: Find lowest salary
SELECT MIN(salary) AS lowest_salary FROM employees;

-- ============================================
-- GROUP BY & HAVING
-- ============================================

-- Problem 19: Count employees in each department
SELECT department, COUNT(*) AS total
FROM employees
GROUP BY department;

-- Problem 20: Find departments with average salary > 50000
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;

-- ============================================
-- OTHER USEFUL QUERIES
-- ============================================

-- Problem 21: Get unique departments
SELECT DISTINCT department FROM employees;

-- Problem 22: Rename columns using alias
SELECT name AS employee_name, salary AS employee_salary
FROM employees;

-- Problem 23: Filter + sort
SELECT * FROM employees
WHERE salary > 40000
ORDER BY salary DESC;

-- Problem 24: Find employees with NULL department
SELECT * FROM employees
WHERE department IS NULL;

-- Problem 25: Replace NULL values
SELECT name, COALESCE(department, 'Not Assigned')
FROM employees;

-- ============================================
-- STRING FUNCTIONS
-- ============================================

-- Problem 26: Convert names to uppercase
SELECT UPPER(name) FROM employees;

-- Problem 27: Convert names to lowercase
SELECT LOWER(name) FROM employees;

-- Problem 28: Find length of each name
SELECT name, LENGTH(name) FROM employees;

-- Problem 29: Concatenate name and department
SELECT CONCAT(name, ' works in ', department) AS info
FROM employees;

-- ============================================
-- PRACTICE QUERIES
-- ============================================

-- Problem 30: Find employees older than 25
SELECT * FROM employees
WHERE age > 25;

-- Problem 31: Find employees in IT department
SELECT * FROM employees
WHERE department = 'IT';

-- Problem 32: Find top 3 highest paid employees
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Problem 33: Find average age
SELECT AVG(age) FROM employees;

-- Problem 34: Find employees whose name contains 'a'
SELECT * FROM employees
WHERE name LIKE '%a%';

-- Problem 35: Find employees with salary NOT between 30000 and 50000
SELECT * FROM employees
WHERE salary NOT BETWEEN 30000 AND 50000;

-- Problem 36: Sort by department then salary
SELECT * FROM employees
ORDER BY department, salary DESC;

-- Problem 37: Show unique ages
SELECT DISTINCT age FROM employees;

-- Problem 38: Find employee(s) with highest salary
SELECT * FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

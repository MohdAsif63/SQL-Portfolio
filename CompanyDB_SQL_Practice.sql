CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    joining_date DATE,

    FOREIGN KEY (dept_id)
    REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    dept_id INT,

    FOREIGN KEY (dept_id)
    REFERENCES departments(dept_id)
);

CREATE TABLE employee_project (
    emp_id INT,
    project_id INT,

    PRIMARY KEY (emp_id, project_id),

    FOREIGN KEY (emp_id)
    REFERENCES employees(emp_id),

    FOREIGN KEY (project_id)
    REFERENCES projects(project_id)
);

INSERT INTO departments
VALUES
(1,'IT'),
(2,'HR'),
(3,'Finance'),
(4,'Sales');

INSERT INTO employees
VALUES
(101,'Asif',40000,1,105,'2023-01-10'),
(102,'Rahul',55000,1,105,'2022-05-15'),
(103,'Aman',35000,2,106,'2024-02-01'),
(104,'Priya',60000,3,107,'2021-11-12'),
(105,'Vikram',90000,1,NULL,'2020-03-15'),
(106,'Neha',80000,2,NULL,'2019-06-20'),
(107,'Karan',95000,3,NULL,'2018-09-01'),
(108,'Simran',45000,4,109,'2023-04-11'),
(109,'Arjun',85000,4,NULL,'2019-12-05'),
(110,'Rohan',55000,1,105,'2022-08-10');

INSERT INTO projects
VALUES
(1,'Banking App',1),
(2,'HR Portal',2),
(3,'Payroll System',3),
(4,'CRM System',4);

INSERT INTO employee_project
VALUES
(101,1),
(102,1),
(103,2),
(104,3),
(108,4),
(110,1);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM employee_project;

SELECT emp_name FROM employees;

SELECT dept_name FROM departments;

SELECT salary FROM employees;

SELECT joining_date FROM employees;

SELECT emp_name,salary FROM employees;

SELECT project_name FROM projects;

SELECT emp_name,manager_id FROM employees;

SELECT * FROM employee_project;
 
SELECT * FROM employees
WHERE salary > 50000;

SELECT emp_name,salary FROM employees
WHERE salary <= 50000;

SELECT emp_name,salary FROM employees
WHERE dept_id = 1;

SELECT emp_name,salary,joining_date FROM employees
WHERE dept_id = 2;

SELECT emp_name,salary FROM employees
WHERE manager_id = 105;

SELECT emp_name,salary FROM employees
WHERE manager_id IS NULL;

SELECT emp_name, joining_date FROM employees
WHERE joining_date > '2023-01-01';

SELECT emp_name,salary FROM employees
WHERE salary >= 40000 AND salary <= 80000;

SELECT emp_name,salary FROM employees
WHERE salary > 40000;

SELECT emp_name,salary FROM employees
WHERE salary != 40000;

SELECT emp_name,salary FROM employees
WHERE emp_id = 101;

SELECT * FROM employees
ORDER BY salary ASC;

SELECT * FROM employees
ORDER BY salary DESC;

SELECT emp_name,salary FROM employees
ORDER BY emp_name ASC;

SELECT emp_name,joining_date FROM employees
ORDER BY joining_date DESC
LIMIT 3;

SELECT emp_name,joining_date FROM employees
ORDER BY joining_date DESC
LIMIT 1,3;

SELECT salary FROM employees
ORDER BY salary DESC
LIMIT 1;

SELECT  DISTINCT salary FROM employees
ORDER BY salary DESC
LIMIT 1,1;

SELECT  DISTINCT salary FROM employees
ORDER BY salary DESC
LIMIT 3;

SELECT  DISTINCT salary FROM employees
ORDER BY salary DESC;

SELECT DISTINCT dept_id FROM employees;

SELECT DISTINCT count(DISTINCT dept_id)FROM employees;

SELECT emp_name FROM employees
WHERE emp_name LIKE "A%";

SELECT emp_name FROM employees
WHERE emp_name LIKE "%n";

SELECT emp_name FROM employees
WHERE emp_name LIKE "%A%";

SELECT emp_name FROM employees
WHERE emp_name LIKE "_a%";

SELECT emp_name FROM employees
WHERE emp_name LIKE "__i%";


SELECT  COUNT(emp_id) FROM employees;

SELECT  COUNT(salary) FROM employees;

SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;

SELECT SUM(salary) FROM employees;

SELECT AVG(salary) FROM employees;

SELECT AVG(salary) FROM employees
WHERE dept_id = 1;

SELECT dept_id, COUNT(emp_id) FROM employees
GROUP BY dept_id;

SELECT dept_id, AVG(salary) FROM employees
GROUP BY dept_id;

SELECT dept_id, SUM(salary) FROM employees
GROUP BY dept_id;

SELECT dept_id, COUNT(*) FROM employees
GROUP BY dept_id
HAVING COUNT(*)  > 2;


SELECT dept_id, AVG(salary) FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 60000;


SELECT dept_id, SUM(salary) FROM employees
GROUP BY dept_id
HAVING SUM(salary) > 150000;

SELECT dept_id, COUNT(*) FROM employees
GROUP BY dept_id
HAVING COUNT(*) = 2 ;

SELECT emp_name,dept_name FROM employees
INNER JOIN departments
ON employees.dept_id = departments.dept_id;

SELECT emp_name,salary,dept_name FROM employees
INNER JOIN departments
ON employees.dept_id = departments.dept_id;

SELECT emp_name,dept_name FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;


SELECT e.emp_name,d.dept_name FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

SELECT d.dept_name,e.emp_name FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

SELECT e.emp_name,d.dept_name FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;

SELECT e.emp_name,salary,d.dept_name FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;

SELECT e.emp_name,p.project_name FROM employees e
INNER JOIN employee_project ep
ON e.emp_id = ep.emp_id

INNER JOIN projects p 
ON ep.project_id = p.project_id;

SELECT e.emp_name, p.project_name, d.dept_name
FROM employees e
INNER JOIN employee_project ep
ON e.emp_id = ep.emp_id
INNER JOIN projects p
ON ep.project_id = p.project_id
INNER JOIN departments d
ON e.dept_id = d.dept_id;


SELECT d.dept_name, COUNT(*) FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT p.project_name, COUNT(e.emp_id) FROM employees e
INNER JOIN employee_project ep
ON e.emp_id = ep.emp_id
INNER JOIN projects p 
ON ep.project_id = p.project_id
GROUP BY p.project_name;

SELECT p.project_name, COUNT(e.emp_id) FROM employees e
INNER JOIN employee_project ep
ON e.emp_id = ep.emp_id
INNER JOIN projects p 
ON ep.project_id = p.project_id
GROUP BY p.project_name
HAVING COUNT(e.emp_id)  > 2;

SELECT e.emp_name,m.emp_name FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;

SELECT e.emp_name,e.salary FROM employees e
WHERE e.salary = (SELECT MAX( DISTINCT salary) FROM employees);

SELECT e.emp_name,e.salary FROM employees e
WHERE e.salary > (SELECT AVG( DISTINCT salary) FROM employees);

SELECT e.emp_name,e.salary, MAX(e.salary) FROM employees e
WHERE e.salary < (SELECT MAX(e.salary) FROM employees);

SELECT * FROM employees e
WHERE e.dept_id IN (1,2);

SELECT e.emp_name FROM employees e
WHERE e.dept_id IN ( SELECT dept_id FROM departments WHERE dept_name = 'IT' OR dept_name = 'HR');

SELECT e.emp_name FROM employees e
WHERE e.dept_id IN ( SELECT dept_id FROM departments WHERE dept_name = 'Finance' OR dept_name = 'sales');

SELECT e.emp_name FROM employees e
WHERE e.dept_id NOT IN (1,3);

SELECT e.emp_name FROM employees e
WHERE e.manager_id IS NULL; 

SELECT e.emp_name FROM employees e
WHERE e.manager_id IS NOT NULL; 

SELECT e.emp_name FROM employees e
WHERE e.dept_id NOT IN (SELECT dept_id FROM departments WHERE dept_id IS NOT NULL);


SELECT e.emp_name FROM employees e
WHERE EXISTS ( SELECT 1 FROM employee_project ep WHERE e.emp_id = ep.emp_id);


SELECT e.emp_name FROM employees e
WHERE NOT EXISTS ( SELECT 1 FROM employee_project ep WHERE e.emp_id = ep.emp_id);


SELECT e.emp_name FROM employees e
WHERE salary > (SELECT AVG(salary) FROM    employees d WHERE d.dept_id = e.dept_id);

SELECT e.emp_name,e.salary,
CASE
WHEN e.salary >= 80000 THEN "Highest"
WHEN e.salary >= 50000 THEN "Moderate"
WHEN e.salary < 50000 THEN "Low"
ELSE "Intern"
END AS STATUS
FROM employees e;

SELECT e.emp_name FROM employees e
UNION
SELECT d.dept_name FROM departments d;

SELECT e.emp_name AS Name FROM employees e
UNION 
SELECT p.project_name FROM projects p;



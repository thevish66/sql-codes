-- 1. Find the second highest salary
SELECT DISTINCT salary 
FROM Employee 
ORDER BY salary DESC 
LIMIT 1 OFFSET 1;

-- 2. Find the nth highest salary
SELECT DISTINCT salary 
FROM Employee 
ORDER BY salary DESC 
LIMIT 1 OFFSET (N-1);

-- 3. Find employees with duplicate salaries
SELECT salary, COUNT(*) 
FROM Employee 
GROUP BY salary 
HAVING COUNT(*) > 1;

-- 4. Find the department-wise highest salary
SELECT e.DepartmentID, e.Name, e.Salary 
FROM Employee e
WHERE Salary IN (
    SELECT MAX(Salary) 
    FROM Employee 
    WHERE DepartmentID = e.DepartmentID
);

-- 5. Find employees who earn more than their manager
SELECT e.Name 
FROM Employee e 
JOIN Employee m ON e.ManagerID = m.ID 
WHERE e.Salary > m.Salary;

-- 6. Get the count of employees in each department
SELECT DepartmentID, COUNT(*) AS EmployeeCount 
FROM Employee 
GROUP BY DepartmentID;

-- 7. Find the employee with the highest salary in each department
SELECT e.DepartmentID, e.Name, e.Salary 
FROM Employee e
WHERE Salary = (
    SELECT MAX(Salary) 
    FROM Employee 
    WHERE DepartmentID = e.DepartmentID
);

-- 8. Find employees who joined in the last 6 months
SELECT * 
FROM Employee 
WHERE JoinDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 9. Find the average salary of employees in each department
SELECT DepartmentID, AVG(Salary) AS AvgSalary 
FROM Employee 
GROUP BY DepartmentID;

-- 10. Find the top 3 highest-paid employees
SELECT * 
FROM Employee 
ORDER BY Salary DESC 
LIMIT 3;

-- 11. Retrieve employees who do not have a manager
SELECT * 
FROM Employee 
WHERE ManagerID IS NULL;

-- 12. Find employees whose names start with 'A'
SELECT * 
FROM Employee 
WHERE Name LIKE 'A%';

-- 13. Retrieve common records between two tables
SELECT * 
FROM Employee 
INTERSECT 
SELECT * 
FROM Employee_Backup;

-- 14. Retrieve records that exist in one table but not in another
SELECT * 
FROM Employee 
EXCEPT 
SELECT * 
FROM Employee_Backup;

-- 15. Find the median salary of employees
SELECT Salary 
FROM Employee 
ORDER BY Salary 
LIMIT 1 OFFSET (SELECT COUNT(*)/2 FROM Employee);

-- 16. Find the 3rd highest salary without using LIMIT
SELECT Salary 
FROM (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk 
    FROM Employee
) ranked 
WHERE rnk = 3;

-- 17. Find employees who have the same salary
SELECT e1.Name, e2.Name, e1.Salary 
FROM Employee e1, Employee e2 
WHERE e1.Salary = e2.Salary AND e1.ID <> e2.ID;

-- 18. Find employees who have the same salary using self-join
SELECT e1.Name, e2.Name, e1.Salary 
FROM Employee e1 
JOIN Employee e2 ON e1.Salary = e2.Salary 
WHERE e1.ID <> e2.ID;

-- 19. Find departments that have more than 5 employees
SELECT DepartmentID 
FROM Employee 
GROUP BY DepartmentID 
HAVING COUNT(*) > 5;

-- 20. Find the employee with the longest tenure
SELECT * 
FROM Employee 
ORDER BY JoinDate ASC 
LIMIT 1;

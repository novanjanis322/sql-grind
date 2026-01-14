-- Link: https://leetcode.com/problems/employees-with-missing-information/

SELECT
    s.employee_id
FROM
    Salaries s
WHERE
    employee_id NOT IN (SELECT employee_id FROM Employees)
UNION
SELECT
    employee_id
FROM
    Employees
WHERE
    employee_id NOT IN (SELECT employee_id FROM Salaries)
ORDER BY
    employee_id
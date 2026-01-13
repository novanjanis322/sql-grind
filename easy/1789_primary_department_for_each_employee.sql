-- Link: https://leetcode.com/problems/primary-department-for-each-employee/
SELECT
    employee_id,
    department_id
FROM
    Employee
WHERE
    primary_flag = 'Y'
UNION
SELECT
    employee_id,
    department_id
FROM
    (SELECT
    employee_id,
    department_id,
    CASE 
        WHEN COUNT(employee_id) = 1 THEN 'Y'
        ELSE
            'N'
        END AS primary_flag
    FROM 
        Employee
    GROUP BY employee_id) e
WHERE
    primary_flag = 'Y'  

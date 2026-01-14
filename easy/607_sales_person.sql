-- Link: https://leetcode.com/problems/sales-person/

SELECT
    name
FROM
    SalesPerson
WHERE
    sales_id NOT IN
    (
        SELECT 
            sales_id 
        FROM 
            Orders 
        WHERE 
        com_id = (
                SELECT 
                    com_id 
                FROM 
                    company 
                WHERE 
                    name = 'Red'
                )
        )

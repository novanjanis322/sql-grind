-- Link: https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/

SELECT
    customer_number
FROM
(
    SELECT 
        customer_number, COUNT(order_number) as order_count
    FROM 
        Orders 
    GROUP BY 
        customer_number 
    ORDER BY COUNT(order_number) DESC
) c
LIMIT 1

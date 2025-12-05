-- SQL Schema
-- Pandas Schema
-- Table: Customer

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | customer_id | int     |
-- | product_key | int     |
-- +-------------+---------+
-- This table may contain duplicates rows. 
-- customer_id is not NULL.
-- product_key is a foreign key (reference column) to Product table.
 

-- Table: Product

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_key | int     |
-- +-------------+---------+
-- product_key is the primary key (column with unique values) for this table.
 

-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

-- Return the result table in any order.

-- The result format is in the following example.

-- Link: https://leetcode.com/problems/customers-who-bought-all-products 

# Write your MySQL query statement below
SELECT 
    customer_id
FROM
    Customer
GROUP BY
    customer_id
HAVING
    COUNT(DISTINCT product_key) = (SELECT COUNT(1) FROM Product)

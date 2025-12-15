-- Easy
-- Topics
-- premium lock icon
-- Companies
-- SQL Schema
-- Pandas Schema
-- Table: Visits

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | visit_id    | int     |
-- | customer_id | int     |
-- +-------------+---------+
-- visit_id is the column with unique values for this table.
-- This table contains information about the customers who visited the mall.
 

-- Table: Transactions

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | transaction_id | int     |
-- | visit_id       | int     |
-- | amount         | int     |
-- +----------------+---------+
-- transaction_id is column with unique values for this table.
-- This table contains information about the transactions made during the visit_id.
 

-- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

-- Return the result table sorted in any order.

-- The result format is in the following example.

-- Link: https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/

SELECT
    customer_id,
    count(1) as count_no_trans
FROM
    Visits

WHERE
    visit_id NOT IN (SELECT visit_id FROM Transactions)
GROUP BY
    customer_id
;


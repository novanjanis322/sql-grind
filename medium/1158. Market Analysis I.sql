-- link: https://leetcode.com/problems/market-analysis-i/description/

SELECT
    u.user_id as buyer_id,
    u.join_date,
    COALESCE(COUNT(o.buyer_id), 0) AS orders_in_2019
FROM
    Users u
LEFT JOIN
    Orders o
ON
    u.user_id = o.buyer_id
AND
    EXTRACT(YEAR FROM o.order_date) = 2019
GROUP BY
    u.user_id

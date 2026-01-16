-- Link: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

with cte AS (
SELECT
    requester_id AS id,
    COUNT(requester_id) as count_req
FROM
    RequestAccepted
GROUP BY 
    requester_id
UNION ALL
SELECT
    accepter_id AS id,
    COUNT(accepter_id) as count_req
FROM
    RequestAccepted
GROUP BY 
    accepter_id
)
SELECT
    id,
    SUM(count_req) AS num
FROM    
    cte
GROUP BY 
    id
ORDER BY
    SUM(count_req) DESC
LIMIT 1
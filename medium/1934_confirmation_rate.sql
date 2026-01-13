-- Link: https://leetcode.com/problems/confirmation-rate/

SELECT
    s.user_id,
    ROUND(COALESCE(c.timeout_total/c.request_total, 0),2) AS confirmation_rate
FROM
    Signups s
LEFT JOIN
    (
        SELECT
            user_id,
            SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS timeout_total,
            COUNT(user_id) AS request_total
        FROM
            Confirmations
        GROUP BY user_id
    ) c
ON
    c.user_id = s.user_id


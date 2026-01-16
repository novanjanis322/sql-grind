-- Link: https://leetcode.com/problems/percentage-of-users-attended-a-contest/

WITH user_pct AS (SELECT
    r.contest_id,
    ROUND(
        reg_user / all_user * 100
        ,2
        ) AS percentage
FROM
    (
        SELECT
            contest_id, COUNT(user_id) AS reg_user
        FROM
            Register
        GROUP BY 
            contest_id
    ) r
CROSS JOIN
(SELECT 
    COUNT(user_id) as all_user
FROM
    Users) u)
SELECT 
    *
FROM
    user_pct
ORDER BY percentage DESC, contest_id

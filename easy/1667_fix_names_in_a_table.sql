-- Link: https://leetcode.com/problems/fix-names-in-a-table/description/
SELECT
    user_id,
    CONCAT(
        UPPER(LEFT(name, 1)),
        LOWER(SUBSTRING(name, 2, LENGTH(name) - 1))
    ) AS name 
FROM
    Users
ORDER BY
    user_id;

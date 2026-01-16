-- Link: https://leetcode.com/problems/biggest-single-number/

SELECT
    (MAX(num)) as num
FROM
    (
        SELECT
            num
        FROM
            MyNumbers
        GROUP BY
            num
        HAVING COUNT(num) = 1
    ) mn

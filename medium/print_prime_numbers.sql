-- Link: https://www.hackerrank.com/challenges/print-prime-numbers/problem
WITH RECURSIVE numbers AS 
(
    SELECT 
        2 AS num
    UNION ALL
    SELECT num + 1 FROM numbers WHERE num < 1000
)
SELECT GROUP_CONCAT(num ORDER BY num SEPARATOR '&')
FROM numbers
WHERE num NOT IN 
(
    SELECT DISTINCT n1.num
    FROM 
        numbers n1
    JOIN
        numbers n2 
    ON
        n2.num < n1.num AND n2.num > 1
    WHERE
        n1.num % n2.num = 0
)


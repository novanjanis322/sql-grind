-- Link: https://leetcode.com/problems/exchange-seats/

SELECT 
    id,
    CASE
        
        WHEN id % 2 = 1 and id + 1 IN (SELECT id FROM Seat)
            THEN LEAD(student) OVER(ORDER BY id)
        WHEN id % 2 = 0
            THEN LAG(student) OVER(ORDER BY id)
        ELSE
            student
    END AS
        student
FROM 
    Seat

-- Link: https://leetcode.com/problems/classes-with-at-least-5-students/

SELECT
    class
FROM
    (SELECT
        class, 
        COUNT(class) as class_count
    FROM
        Courses
    GROUP BY 
        class
    HAVING
        COUNT(class) >= 5 
        ) c
ORDER BY
    class

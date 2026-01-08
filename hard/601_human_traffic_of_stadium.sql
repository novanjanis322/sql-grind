-- Link: https://leetcode.com/problems/human-traffic-of-stadium/description/

WITH forward_row AS
(
    SELECT
        id, visit_date,
        people
    FROM
        (
            SELECT
                id, visit_date,
                people,
                LEAD(people, 1) OVER(ORDER BY id) AS people_2,
                LEAD(people, 2) OVER(ORDER BY id) AS people_3
            FROM
                Stadium
        ) AS three_row
    WHERE
        people >= 100 AND people_2 >= 100 AND people_3 >= 100
 ),
backward_row AS
(
    SELECT
        id, visit_date,
        people
    FROM
        (
            SELECT
                id, visit_date, people,
                LAG(people, 1) OVER(ORDER BY id) AS people_2,
                LAG(people, 2) OVER(ORDER BY id) AS people_3
            FROM
                Stadium
        ) AS three_row
    WHERE
        people >= 100 AND people_2 >= 100 AND people_3 >= 100
),
middle_row AS 
(
    SELECT
        id, visit_date,
        people
    FROM
        (
            SELECT
                id, visit_date, people,
                LAG(people, 1) OVER(ORDER BY id) AS people_2,
                LEAD(people, 1) OVER(ORDER BY id) AS people_3
            FROM
                Stadium
        ) AS three_row
    WHERE
        people >= 100 AND people_2 >= 100 AND people_3 >= 100
)
SELECT 
    * 
FROM
    forward_row fw
UNION
SELECT 
    * 
FROM
    backward_row bw
UNION 
SELECT 
    * 
FROM
    middle_row md
ORDER BY
    visit_date
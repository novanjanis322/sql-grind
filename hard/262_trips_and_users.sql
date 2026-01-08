-- Link: https://leetcode.com/problems/trips-and-users/description/


WITH
    cancel_trips
AS
    (
        SELECT
            SUM(
                CASE
                    WHEN status LIKE 'cancelled%' THEN 1
                    ELSE 0
            END) AS cancelled_total,
            t.request_at
        FROM
            Trips t
        JOIN
            Users u
        ON
            t.client_id = u.users_id
        AND
            u.banned = 'No'
        JOIN
            Users u2
        ON
            t.driver_id = u2.users_id
        AND
            u2.banned = 'No'
            
        GROUP BY 
            request_at
    ),
    total_trips   
AS 
    (
        SELECT
            COUNT(t.status) AS trips_total,
            t.request_at
        FROM
            Trips t
        JOIN
            Users u
        ON
            t.client_id = u.users_id
        AND
            u.banned = 'No'
        JOIN
            Users u2
        ON
            t.driver_id = u2.users_id
        AND
            u2.banned = 'No'
        GROUP BY 
            request_at
    )
SELECT 
    ct.request_at AS Day,
    ROUND( 
        ct.cancelled_total 
        / tt.trips_total
        ,2
    ) AS 'Cancellation Rate'
FROM
    cancel_trips ct
JOIN
    total_trips tt
ON
    ct.request_at = tt.request_at
WHERE
    tt.request_at BETWEEN '2013-10-01' AND '2013-10-03'
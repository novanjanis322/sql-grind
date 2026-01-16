-- Link: https://leetcode.com/problems/investments-in-2016/

SELECT
    ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM
    Insurance
WHERE 
    pid 
IN
    (
        SELECT
            pid
        FROM
            Insurance
        GROUP BY 
            lat, lon
        HAVING 
            COUNT(lat) = 1
        AND 
            COUNT(lon) = 1
    ) 
AND
    tiv_2015 
IN
    (
        SELECT
            tiv_2015
        FROM
            Insurance
        GROUP BY
            tiv_2015
        HAVING
            COUNT(tiv_2015) > 1
    )


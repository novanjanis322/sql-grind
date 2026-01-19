-- Link: https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/description/

SELECT
    actor_id,
    director_id
FROM
    ActorDirector
GROUP BY 
    actor_id, director_id
HAVING
    COUNT(director_id) >= 3
ORDER BY
    actor_id
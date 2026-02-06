-- Link: https://leetcode.com/problems/find-students-who-improved/
SELECT
    student_id,   
    subject,
    first_score,
    latest_score
FROM 
(SELECT
    student_id,
    subject,
    FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS first_score,
    LAST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS latest_score,
    ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS row_num
FROM 
    Scores) s
WHERE
    first_score < latest_score
AND
    row_num = 1


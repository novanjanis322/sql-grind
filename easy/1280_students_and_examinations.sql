-- Link: https://leetcode.com/problems/students-and-examinations/description/

SELECT
    st.student_id,
    st.student_name,
    sub.subject_name,
    COUNT(ex.subject_name) AS attended_exams    
FROM
    Students st
CROSS JOIN
    Subjects sub
LEFT JOIN 
    Examinations ex
ON
    ex.student_id = st.student_id
AND
    sub.subject_name = ex.subject_name
GROUP BY student_id, student_name, subject_name
ORDER BY student_id

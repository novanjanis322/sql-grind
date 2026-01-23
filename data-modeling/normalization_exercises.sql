-- ============================================================
-- Normalization Exercise: School Enrollment System
-- Week 3, Day 4 - Normalization Practice (1NF → 3NF)
-- ============================================================

-- ============================================================
-- ORIGINAL DENORMALIZED TABLE (for reference)
-- ============================================================
-- | student_id | student_name | student_email       | course_id | course_name     | instructor_id | instructor_name | instructor_dept  | grade |
-- |------------|--------------|---------------------|-----------|-----------------|---------------|-----------------|------------------|-------|
-- | 1          | Alice        | alice@school.edu    | CS101     | Intro to Python | 10            | Dr. Smith       | Computer Science | A     |
-- | 1          | Alice        | alice@school.edu    | CS102     | Data Structures | 10            | Dr. Smith       | Computer Science | B+    |
-- | 2          | Bob          | bob@school.edu      | CS101     | Intro to Python | 10            | Dr. Smith       | Computer Science | B     |
-- | 2          | Bob          | bob@school.edu      | MA101     | Calculus I      | 20            | Dr. Jones       | Mathematics      | A-    |
-- | 3          | Carol        | carol@school.edu    | MA101     | Calculus I      | 20            | Dr. Jones       | Mathematics      | A     |

-- ============================================================
-- NORMALIZED TABLES (3NF)
-- ============================================================

-- ------------------------------------------------------------
-- students: Student information
-- PK: student_id
-- ------------------------------------------------------------
CREATE TABLE students(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL UNIQUE
);

-- ------------------------------------------------------------
-- instructors: Instructor information
-- PK: instructor_id
-- ------------------------------------------------------------
CREATE TABLE instructors(
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100) NOT NULL,
    instructor_dept VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- courses: Course information
-- PK: course_id
-- FK: instructor_id → instructors
-- ------------------------------------------------------------
CREATE TABLE courses(
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- ------------------------------------------------------------
-- enrollments: Student-Course relationship with grade
-- PK: (student_id, course_id) - composite key
-- FK: student_id → students
-- FK: course_id → courses
-- ------------------------------------------------------------
CREATE TABLE enrollments(
    student_id INT NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- students (3 unique students)
INSERT INTO students VALUES
(1, 'Alice', 'alice@school.edu'),
(2, 'Bob', 'bob@school.edu'),
(3, 'Carol', 'carol@school.edu');

-- instructors (2 unique instructors)
INSERT INTO instructors VALUES
(10, 'Dr. Smith', 'Computer Science'),
(20, 'Dr. Jones', 'Mathematics');

-- courses (3 unique courses)
INSERT INTO courses VALUES
('CS101', 'Intro to Python', 10),
('CS102', 'Data Structures', 10),
('MA101', 'Calculus I', 20);

-- enrollments (5 records - matches original denormalized rows)
INSERT INTO enrollments VALUES
(1, 'CS101', 'A'),
(1, 'CS102', 'B+'),
(2, 'CS101', 'B'),
(2, 'MA101', 'A-'),
(3, 'MA101', 'A');


-- ============================================================
-- TEST QUERY: Recreate original denormalized view
-- ============================================================
-- After inserting data, this query should return the original 5 rows:

SELECT
    s.student_id,
    s.student_name,
    s.student_email,
    c.course_id,
    c.course_name,
    i.instructor_id,
    i.instructor_name,
    i.instructor_dept,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN instructors i ON c.instructor_id = i.instructor_id
ORDER BY s.student_id, c.course_id;

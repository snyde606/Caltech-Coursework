-- [Problem 1a]
SELECT name 
  FROM student 
  WHERE ID IN (SELECT DISTINCT ID 
    FROM course, takes
    WHERE course.dept_name = 'Comp. Sci.' 
      AND course.course_id = takes.course_id);


-- [Problem 1b]
SELECT dept_name, MAX(salary) AS max_salary 
  FROM instructor 
  GROUP BY dept_name;


-- [Problem 1c]
SELECT MIN(max_salary) AS min_max_salary 
  FROM (
    SELECT dept_name, MAX(salary) AS max_salary
    FROM instructor 
    GROUP BY dept_name) AS max_salaries;


-- [Problem 1d]
WITH max_salaries AS (
  SELECT dept_name, MAX(salary) AS max_salary 
    FROM instructor GROUP BY dept_name)
  SELECT MIN(max_salary) AS min_max_salary FROM max_salaries;


-- [Problem 2a]
INSERT INTO course VALUES ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 3);


-- [Problem 2b]
INSERT INTO section (course_id, sec_id, semester, year, building,
  room_number, time_slot_id) 
  VALUES ('CS-001', 1, 'Fall', 2009, null, null, null);


-- [Problem 2c]
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) 
  SELECT stu.ID, sec.course_id, sec.sec_id, sec.semester, sec.year, grade
  FROM student AS stu CROSS JOIN section AS sec LEFT JOIN takes ON FALSE 
  WHERE sec.course_id = 'CS-001' AND stu.dept_name = 'Comp. Sci.';

-- [Problem 2d]
DELETE FROM takes WHERE ID = (
  SELECT DISTINCT ID FROM student WHERE name = 'Chavez');


-- [Problem 2e]
DELETE FROM course WHERE course_id = 'CS-001';
-- Because the CASCADE keyword is used when setting up the section table,
-- all related sections will also be automatically deleted when the course
-- is deleted.

-- [Problem 2f]
DELETE FROM takes WHERE course_id = (SELECT DISTINCT course_id 
  FROM course WHERE title LIKE LOWER('%database%'));

-- [Problem 3a]
SELECT name FROM member WHERE memb_no IN (
  SELECT memb_no FROM borrowed WHERE isbn IN (
    SELECT isbn FROM book WHERE publisher = 'McGraw-Hill'));


-- [Problem 3b]
SELECT name FROM member WHERE memb_no IN (
  SELECT memb_no FROM borrowed AS b1 WHERE (
    SELECT COUNT(b2.isbn) FROM borrowed AS b2 WHERE b2.memb_no = b1.memb_no 
      AND b2.isbn IN (
      SELECT b3.isbn FROM book AS b3 WHERE b3.publisher = 'McGraw-Hill'))
    = (SELECT count(b4.isbn) 
          FROM book AS b4 WHERE b4.publisher = 'McGraw-Hill'));


-- [Problem 3c]
SELECT b1.publisher, m1.name FROM member AS m1, book AS b1, borrowed AS b2
  WHERE m1.memb_no = b2.memb_no AND b2.isbn = b1.isbn
  GROUP BY b1.publisher, m1.name
  HAVING COUNT(b2.isbn) > 5;


-- [Problem 3d]
SELECT COUNT(*)/(SELECT COUNT(*) FROM member) FROM borrowed;


-- [Problem 3e]
WITH ct1 AS (SELECT memb_no FROM member)
  SELECT COUNT(*)/(SELECT COUNT(*) FROM ct1) FROM borrowed;



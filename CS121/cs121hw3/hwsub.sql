-- [Problem 1a]
SELECT SUM(perfectscore) AS perfcourse
  FROM assignment;


-- [Problem 1b]
SELECT sec_name, COUNT(username)
  FROM section NATURAL JOIN student
  GROUP BY sec_name;


-- [Problem 1c]
DROP VIEW IF EXISTS totalscores;
CREATE VIEW totalscores AS
  SELECT username, SUM(score) AS total_score
  FROM submission NATURAL JOIN student
  WHERE graded = TRUE
  GROUP BY username;


-- [Problem 1d]
DROP VIEW IF EXISTS passing;
CREATE VIEW passing AS
  SELECT username, total_score
  FROM totalscores
  WHERE total_score >= 40;


-- [Problem 1e]
DROP VIEW IF EXISTS failing;
CREATE VIEW failing AS
  SELECT username, total_score
  FROM totalscores
  WHERE total_score < 40;


-- [Problem 1f]
SELECT username FROM (SELECT username, COUNT(asn_id) AS lab_ct FROM (
  SELECT DISTINCT username, asn_id FROM
    ((submission NATURAL RIGHT JOIN student) NATURAL JOIN assignment) 
      NATURAL JOIN fileset 
  WHERE shortname LIKE 'lab%') AS dist_subs GROUP BY username) AS stu_cts
  WHERE lab_ct != (
    SELECT COUNT(*) FROM assignment WHERE shortname LIKE 'lab%')
    AND username IN (SELECT username FROM passing);
    
-- RESULT: coleman, edwards, flores, gibson, harris, miller, murphy, ross, 
-- simmons, tucker, turner

-- [Problem 1g]

SELECT username 
  FROM (
    SELECT username, COUNT(DISTINCT sub_id) AS ct_tests
    FROM student NATURAL RIGHT JOIN (submission NATURAL JOIN fileset) 
      NATURAL JOIN assignment
    WHERE (shortname = 'midterm' OR shortname = 'rinal') AND username IN (
      SELECT username FROM passing)
    GROUP BY username) AS num_tests
  WHERE ct_tests != 2;

-- RESULT: collins

-- [Problem 2a]
SELECT DISTINCT username
  FROM student NATURAL JOIN (submission NATURAL JOIN fileset) 
    NATURAL JOIN assignment
  WHERE shortname = 'midterm' AND sub_date > due;


-- [Problem 2b]
SELECT EXTRACT (hour FROM sub_date) AS hour, count(sub_id) AS num_submits
  FROM submission NATURAL JOIN fileset NATURAL JOIN assignment
  WHERE shortname LIKE 'lab%'
  GROUP BY hour;


-- [Problem 2c]
SELECT COUNT(*)
  FROM submission NATURAL JOIN fileset NATURAL JOIN assignment
  WHERE shortname = 'final' AND sub_date < due 
    AND sub_date > due - INTERVAL 30 MINUTE;


-- [Problem 3a]
ALTER TABLE student
  ADD COLUMN email VARCHAR(200);
  
UPDATE student
  SET email = CONCAT(username, '@school.edu');
  
ALTER TABLE student
  CHANGE COLUMN email email VARCHAR(200) NOT NULL;


-- [Problem 3b]
ALTER TABLE assignment
  ADD COLUMN submit_files BOOLEAN DEFAULT TRUE;
  
UPDATE assignment
  SET submit_files = FALSE
  WHERE shortname LIKE 'dq%';


-- [Problem 3c]
DROP TABLE IF EXISTS gradescheme;
CREATE TABLE gradescheme (
    scheme_id INT PRIMARY KEY,
    scheme_desc VARCHAR(100) NOT NULL
);

INSERT INTO gradescheme VALUES (0, 'Lab assignment with min-grading.'), 
  (1, 'Daily quiz.'), (2, 'Midterm or final exam');

ALTER TABLE assignment
  CHANGE COLUMN gradescheme scheme_id INT NOT NULL;
  
ALTER TABLE assignment
  ADD FOREIGN KEY (scheme_id) REFERENCES gradescheme(scheme_id);
  

-- [Problem 4a]
DROP FUNCTION IF EXISTS is_weekend;
DELIMITER !

CREATE FUNCTION is_weekend(d DATE) RETURNS BOOLEAN
BEGIN
  IF DAYOFWEEK(d) = 7 OR DAYOFWEEK(d) = 1 THEN RETURN TRUE;
  ELSE RETURN FALSE;
  END IF;
END !

DELIMITER ;


-- [Problem 4b]
DROP FUNCTION IF EXISTS is_holiday;
DELIMITER !

CREATE FUNCTION is_holiday(d DATE) RETURNS VARCHAR(20)
BEGIN
  IF DAYOFMONTH(d) = 1 AND MONTH(d) = 1 THEN RETURN 'New Year\'s Day';
  ELSEIF DAYOFMONTH(d) = 4 AND MONTH(d) = 7 THEN RETURN 'Independence Day';
  ELSEIF MONTH(d) = 5 AND DAYOFWEEK(d) = 2 AND DAYOFMONTH(d) >= 25 
    AND DAYOFMONTH(d) <= 31 THEN RETURN 'Memorial Day';
  ELSEIF MONTH(d) = 9 AND DAYOFWEEK(d) = 2 
    AND DAYOFMONTH(d) <= 7 THEN RETURN 'Labor Day';
  ELSEIF MONTH(d) = 11 AND DAYOFWEEK(d) = 5 AND DAYOFMONTH(d) >= 22 
    AND DAYOFMONTH(d) <= 28 THEN RETURN 'Thanksgiving';
  ELSE RETURN NULL;
  END IF;
END !

DELIMITER ;


-- [Problem 5a]
SELECT is_holiday(DATE(sub_date)), COUNT(*)
  FROM fileset
  GROUP BY is_holiday(DATE(sub_date));


-- [Problem 5b]
SELECT (CASE is_weekend(sub_date) WHEN TRUE THEN 'weekend' 
    ELSE 'weekday' END) AS result, COUNT(*)
  FROM fileset
  GROUP BY result;


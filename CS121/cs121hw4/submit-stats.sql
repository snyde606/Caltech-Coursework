-- [Problem 1]
DROP FUNCTION IF EXISTS min_submit_interval;
DELIMITER !
CREATE FUNCTION min_submit_interval(submission_id INTEGER)
RETURNS INTEGER
BEGIN

  DECLARE min_interval INTEGER;
  DECLARE first_val TIMESTAMP;
  DECLARE second_val TIMESTAMP;
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR
    SELECT sub_date 
    FROM fileset 
    WHERE sub_id = submission_id
    ORDER BY sub_date;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
    SET done = 1;
  OPEN cur;
  FETCH cur INTO first_val;
  FETCH cur INTO second_val;
  IF done THEN
    RETURN NULL;
  END IF;
  SET min_interval = UNIX_TIMESTAMP(second_val) - UNIX_TIMESTAMP(first_val);
  SET first_val = second_val;
  WHILE NOT done DO
    FETCH cur INTO second_val;
    IF NOT done THEN
      IF UNIX_TIMESTAMP(second_val) - UNIX_TIMESTAMP(first_val) < min_interval THEN
        SET min_interval = UNIX_TIMESTAMP(second_val) - UNIX_TIMESTAMP(first_val);
	  END IF;
      SET first_val = second_val;
	END IF;
  END WHILE;
  RETURN min_interval;
  
END !
DELIMITER ;

-- [Problem 2]
DROP FUNCTION IF EXISTS max_submit_interval;
DELIMITER !
CREATE FUNCTION max_submit_interval(submission_id INTEGER)
RETURNS INTEGER
BEGIN

  DECLARE max_interval INTEGER;
  DECLARE first_val TIMESTAMP;
  DECLARE second_val TIMESTAMP;
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR
    SELECT sub_date 
    FROM fileset 
    WHERE sub_id = submission_id
    ORDER BY sub_date;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
    SET done = 1;
  OPEN cur;
  FETCH cur INTO first_val;
  FETCH cur INTO second_val;
  IF done THEN
    RETURN NULL;
  END IF;
  SET max_interval = UNIX_TIMESTAMP(second_val) - UNIX_TIMESTAMP(first_val);
  SET first_val = second_val;
  WHILE NOT done DO
    FETCH cur INTO second_val;
    IF NOT done THEN
      IF UNIX_TIMESTAMP(second_val) - UNIX_TIMESTAMP(first_val) 
        > max_interval THEN
        SET
        max_interval = UNIX_TIMESTAMP(second_val) - UNIX_TIMESTAMP(first_val);
	  END IF;
      SET first_val = second_val;
	END IF;
  END WHILE;
  RETURN max_interval;
  
END !
DELIMITER ;


-- [Problem 3]
DROP FUNCTION IF EXISTS avg_submit_interval;
DELIMITER !
CREATE FUNCTION avg_submit_interval(submission_id INTEGER)
RETURNS DOUBLE
BEGIN

  DECLARE total INTEGER DEFAULT 0;
  SET total = (
    SELECT UNIX_TIMESTAMP(MAX(sub_date)) - UNIX_TIMESTAMP(MIN(sub_date)) 
      AS total_interval
	FROM fileset
    WHERE sub_id = submission_id);
    IF total = 0 THEN
      RETURN NULL;
	END IF;
    RETURN total / 
      ((SELECT COUNT(*) FROM fileset WHERE sub_id = submission_id) - 1);

END !
DELIMITER ;


-- [Problem 4]
CREATE INDEX idx_date ON fileset (sub_id, sub_date);

SELECT sub_id,
min_submit_interval(sub_id) AS min_interval, max_submit_interval(sub_id) AS max_interval, avg_submit_interval(sub_id) AS avg_interval
FROM (SELECT sub_id FROM fileset
GROUP BY sub_id HAVING COUNT(*) > 1) AS multi_subs
ORDER BY min_interval, max_interval;

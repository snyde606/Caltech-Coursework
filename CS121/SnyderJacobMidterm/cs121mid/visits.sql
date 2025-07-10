-- [Problem 1]
-- DROP INDEX idx_logtime ON weblog;
CREATE INDEX idx_logtime ON weblog (ip_addr, logtime);

WITH new_visit_log AS (
  SELECT ip_addr, logtime
  FROM weblog AS w1
  WHERE 0 = (SELECT COUNT(*)
                  FROM weblog AS w2
                  WHERE w1.ip_addr = w2.ip_addr AND
						w2.logtime < w1.logtime AND w2.logtime > w1.logtime - INTERVAL 30 MINUTE)
)
SELECT COUNT(DISTINCT ip_addr, logtime) 
FROM new_visit_log;

-- This query computes the number of visits by identifying all of the log
-- entries that start a new visit and then counting them up. It identifies
-- these log entries by comparing them to all other log entries and checking
-- if there are any other log entries with the same ip address that have a
-- timestamp from the 30 minutes before the timestamp of the entry we're
-- checking. If so, then the entry we're checking is not a new visit.

-- [Problem 2]
-- Every log entry needs to be checked against every other log entry in order
-- to determine which ones are new visits. This means we're making on the order
-- of n^2 comparisons so as the number of entries gets larger the computation
-- time increases drastically. In order to increase performance we could:
-- Create an index on ip_addr and logtime because they're frequently used
-- in the query to check if an entry is a new visit
-- Use a cursor to iterate through a sorted weblog only once so that
-- computation time reduces to order of n

-- The SQL is as follows (commented out because it's implemented at the top):

-- CREATE INDEX idx_logtime ON weblog (ip_addr, logtime);

-- This creates an index on the ip_addr and logtime values of the weblog table.
-- This speeds up the query considerably because ip_addr and logtime are
-- frequently used, so getting them from the index is much faster than
-- searching through weblog each time.


-- [Problem 3]
DROP FUNCTION IF EXISTS num_visits;
DELIMITER @
CREATE FUNCTION num_visits()
RETURNS INTEGER
BEGIN

  DECLARE ltime1 TIMESTAMP;
  DECLARE address1 VARCHAR(100);
  DECLARE ltime2 TIMESTAMP;
  DECLARE address2 VARCHAR(100);
  DECLARE counter INTEGER DEFAULT 0;
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR
    SELECT ip_addr, logtime 
    FROM weblog
    ORDER BY ip_addr, logtime;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
    SET done = 1;
  OPEN cur;
  FETCH cur INTO address1, ltime1;
  IF done THEN
    RETURN 0;
  ELSE
    SET counter = 1;
  END IF;
  
  WHILE NOT done DO
    FETCH cur INTO address2, ltime2;
    IF NOT done THEN
      IF address1 != address2 THEN
        SET counter = counter + 1;
      ELSEIF UNIX_TIMESTAMP(ltime2) - UNIX_TIMESTAMP(ltime1) > 1800 THEN
        SET counter = counter + 1;
	  END IF;
      SET address1 = address2;
      SET ltime1 = ltime2;
	END IF;
  END WHILE;
  RETURN counter;
  
END @
DELIMITER @

SELECT num_visits();

-- [Problem 1]
DROP FUNCTION IF EXISTS total_salaries_adjlist;
DELIMITER $
CREATE FUNCTION total_salaries_adjlist(emp_id0 INTEGER)
RETURNS INTEGER
BEGIN
  
  DECLARE result INTEGER;
  DECLARE rowschanged INTEGER;
  SET rowschanged = 1;
  
  CREATE TEMPORARY TABLE sub_employees (
    emp_id INTEGER NOT NULL
  );
  
  INSERT INTO sub_employees VALUES (emp_id0);
  
  WHILE rowschanged != 0 DO
    INSERT INTO sub_employees SELECT emp_id FROM employee_adjlist
       WHERE manager_id IN (SELECT * FROM sub_employees)
         AND emp_id NOT IN (SELECT * FROM sub_employees);
    SET rowschanged = ROW_COUNT();
  END WHILE;
  
  SET result = (SELECT SUM(salary) AS sum_of_salaries
    FROM employee_adjlist
    WHERE emp_id IN (sub_employees));
    
  RETURN result;
  
END $
DELIMITER ;


-- [Problem 2]
DROP FUNCTION IF EXISTS total_salaries_nestset;
DELIMITER $
CREATE FUNCTION total_salaries_nestset(emp_id0 INTEGER)
RETURNS INTEGER
BEGIN
  
  DECLARE higher INTEGER;
  DECLARE lower INTEGER;
  DECLARE result INTEGER;
  SET higher = (SELECT high FROM employee_nestset WHERE emp_id = emp_id0);
  SET lower = (SELECT low FROM employee_nestset WHERE emp_id = emp_id0);
  
  SET result = (SELECT SUM(salary) AS sum_of_salaries
    FROM employee_nestset
    WHERE low >= lower AND low <= higher AND high <= higher AND high >= lower);
    
  RETURN result;
  
END $
DELIMITER ;


-- [Problem 3]
WITH manager_list AS(
  SELECT manager_id FROM employee_adjlist WHERE !ISNULL(manager_id)
)
SELECT emp_id, name, salary
  FROM employee_adjlist
  WHERE emp_id NOT IN (SELECT * FROM manager_list);


-- [Problem 4]
WITH not_leaves AS (
  SELECT e1.emp_id
    FROM employee_nestset AS e1, employee_nestset AS e2
    WHERE(e2.low < e1.high AND e2.low > e1.low) 
      OR (e2.high < e1.high AND e2.high > e1.low)
)
SELECT emp_id, name, salary
  FROM employee_nestset
  WHERE emp_id NOT IN (SELECT * FROM not_leaves);


-- [Problem 5]
DROP FUNCTION IF EXISTS find_depth;
DELIMITER $
CREATE FUNCTION find_depth()
RETURNS INTEGER
BEGIN
  
  DECLARE depth INTEGER;
  DECLARE counter INTEGER;
  SET counter = 1;
  
  CREATE TEMPORARY TABLE sub_employees (
    emp_id INTEGER NOT NULL
  );
  
  INSERT INTO sub_employees (
    SELECT manager_id FROM sub_employees WHERE !ISNULL(manager_id)
  );
  
  WHILE (SELECT COUNT(*) FROM sub_employees) != 0 DO
    SET counter = counter + 1;
    DELETE FROM sub_employees WHERE emp_id NOT IN (
      SELECT manager_id FROM sub_employees WHERE !ISNULL(manager_id));
  END WHILE;
  
  RETURN counter;
  
END $
DELIMITER ;


-- [Problem 6]
DROP FUNCTION IF EXISTS emp_reports;
DELIMITER $
CREATE FUNCTION emp_reports(emp_id0 INTEGER)
RETURNS INTEGER
BEGIN
  
  DECLARE lasthigh INTEGER;
  DECLARE finalhigh INTEGER;
  DECLARE current_id INTEGER;
  DECLARE counter INTEGER;
  
  SET counter = 0;
  SET finalhigh = (SELECT high FROM employee_nestset WHERE emp_id = emp_id0);
  SET lasthigh = (SELECT low FROM employee_nestset WHERE emp_id = emp_id0);
  
  SET current_id = (SELECT emp_id 
    FROM employee_nestset 
    WHERE low-lasthigh = (
      SELECT MIN(low-lasthigh) FROM employee_nestset WHERE low-lasthigh > 0));
    
  WHILE (
    SELECT high FROM employee_nestset WHERE emp_id = current_id) < finalhigh DO
      SET counter = counter + 1;
      SET lasthigh = (SELECT high FROM employee_nestset WHERE emp_id = current_id);
      SET current_id = (SELECT emp_id 
      FROM employee_nestset 
      WHERE low-lasthigh = (
        SELECT MIN(low-lasthigh) FROM employee_nestset WHERE low-lasthigh > 0));
  END WHILE;
  
  RETURN counter;
  
END $
DELIMITER ;

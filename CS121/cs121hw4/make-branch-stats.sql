-- [Problem 1]
CREATE INDEX idx_balance ON account (branch_name, balance);


-- [Problem 2]
DROP TABLE IF EXISTS mv_branch_account_stats;
CREATE TABLE mv_branch_account_stats(
    branch_name VARCHAR(30) PRIMARY KEY,
    num_accounts INTEGER NOT NULL,
    total_deposits DOUBLE NOT NULL,
    min_balance DOUBLE NOT NULL,
    max_balance DOUBLE NOT NULL
);


-- [Problem 3]
INSERT INTO mv_branch_account_stats
  SELECT branch_name, 
                 COUNT(*) AS num_accounts, 
				 SUM(balance) AS total_deposits, 
                 MIN(balance) AS min_balance, 
                 MAX(balance) AS max_balance
  FROM account
  GROUP BY branch_name;


-- [Problem 4]
DROP VIEW IF EXISTS branch_account_stats;
CREATE VIEW branch_account_stats AS 
  SELECT branch_name, 
                 num_accounts, 
				 total_deposits, 
                 (total_deposits / num_accounts) AS avg_balance, 
                 min_balance, 
                 max_balance
  FROM mv_branch_account_stats;


-- [Problem 5]
DROP TRIGGER IF EXISTS trg_insert;
DELIMITER !
CREATE TRIGGER trg_insert AFTER INSERT ON account FOR EACH ROW
BEGIN

  DECLARE new_count INTEGER;
  DECLARE new_sum DOUBLE;
  DECLARE new_min DOUBLE;
  DECLARE new_max DOUBLE;

  IF NEW.branch_name NOT IN (SELECT branch_name FROM mv_branch_account_stats)
  THEN
    INSERT INTO mv_branch_account_stats 
    VALUES (NEW.branch_name, 1, NEW.balance, NEW.balance, NEW.balance);
  ELSE
    SET new_count = (SELECT (num_accounts + 1) AS nc 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = NEW.branch_name);
	SET new_sum = (SELECT total_deposits + NEW.balance AS ns 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = NEW.branch_name);
    SET new_min = (SELECT min_balance AS mb 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = NEW.branch_name);
	IF NEW.balance < new_min THEN SET new_min = NEW.balance;
    END IF;
    SET new_max = (SELECT max_balance AS mb 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = NEW.branch_name);
	IF NEW.balance > new_max THEN SET new_max = NEW.balance;
    END IF;
    
	REPLACE INTO mv_branch_account_stats 
    VALUES (NEW.branch_name, new_count, new_sum, new_min, new_max);
  END IF;

END !
DELIMITER ;


-- [Problem 6]
DROP TRIGGER IF EXISTS trg_delete;
DELIMITER !
CREATE TRIGGER trg_delete AFTER DELETE ON account FOR EACH ROW
BEGIN

  DECLARE new_count INTEGER;
  DECLARE new_sum DOUBLE;
  DECLARE new_min DOUBLE;
  DECLARE new_max DOUBLE;

  IF (SELECT num_accounts 
	   FROM mv_branch_account_stats 
       WHERE OLD.branch_name = branch_name) = 1
  THEN
    DELETE FROM mv_branch_account_stats WHERE OLD.branch_name = branch_name;
  ELSE
    SET new_count = (SELECT (num_accounts - 1) AS nc 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	SET new_sum = (SELECT total_deposits - OLD.balance AS ns 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
    SET new_min = (SELECT min_balance 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	IF OLD.balance = new_min THEN
      SET new_min = (SELECT MIN(balance)
                                  FROM account
                                  WHERE OLD.branch_name = branch_name
                                  GROUP BY branch_name);
    END IF;
    SET new_max = (SELECT max_balance 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	IF OLD.balance = new_max THEN
      SET new_max = (SELECT MAX(balance)
                                  FROM account
                                  WHERE OLD.branch_name = branch_name
                                  GROUP BY branch_name);
    END IF;
    
	REPLACE INTO mv_branch_account_stats 
    VALUES (OLD.branch_name, new_count, new_sum, new_min, new_max);
  END IF;

END !
DELIMITER ;


-- [Problem 7]
DROP TRIGGER IF EXISTS trg_update;
DELIMITER |
CREATE TRIGGER trg_update AFTER UPDATE ON account FOR EACH ROW
BEGIN

  DECLARE new_count INTEGER;
  DECLARE new_sum DOUBLE;
  DECLARE new_min DOUBLE;
  DECLARE new_max DOUBLE;

  IF OLD.branch_name != NEW.branch_name
  THEN
    IF (SELECT num_accounts 
	     FROM mv_branch_account_stats 
         WHERE OLD.branch_name = branch_name) = 1
    THEN
      DELETE FROM mv_branch_account_stats WHERE OLD.branch_name = branch_name;
     ELSE
      SET new_count = (SELECT (num_accounts - 1) AS nc 
                                     FROM mv_branch_account_stats 
                                     WHERE branch_name = OLD.branch_name);
	  SET new_sum = (SELECT total_deposits - OLD.balance AS ns 
								  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
      SET new_min = (SELECT min_balance 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	  IF OLD.balance = new_min THEN
        SET new_min = (SELECT MIN(balance)
                                    FROM account
                                    WHERE OLD.branch_name = branch_name
                                    GROUP BY branch_name);
      END IF;
      SET new_max = (SELECT max_balance 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	  IF OLD.balance = new_max THEN
        SET new_max = (SELECT MAX(balance)
                                    FROM account
                                    WHERE OLD.branch_name = branch_name
                                    GROUP BY branch_name);
      END IF;
    
	  REPLACE INTO mv_branch_account_stats 
      VALUES (OLD.branch_name, new_count, new_sum, new_min, new_max);
    END IF;
    IF NEW.branch_name NOT IN (SELECT branch_name FROM mv_branch_account_stats)
    THEN
      INSERT INTO mv_branch_account_stats 
      VALUES (NEW.branch_name, 1, NEW.balance, NEW.balance, NEW.balance);
    ELSE
      SET new_count = (SELECT (num_accounts + 1) AS nc 
                                    FROM mv_branch_account_stats 
                                    WHERE branch_name = NEW.branch_name);
	  SET new_sum = (SELECT total_deposits + NEW.balance AS ns 
                                    FROM mv_branch_account_stats 
                                    WHERE branch_name = NEW.branch_name);
      SET new_min = (SELECT min_balance AS mb 
                                    FROM mv_branch_account_stats 
                                    WHERE branch_name = NEW.branch_name);
	  IF NEW.balance < new_min THEN SET new_min = NEW.balance;
      END IF;
      SET new_max = (SELECT max_balance AS mb 
                                    FROM mv_branch_account_stats 
                                    WHERE branch_name = NEW.branch_name);
	  IF NEW.balance > new_max THEN SET new_max = NEW.balance;
      END IF;
      
	  REPLACE INTO mv_branch_account_stats 
      VALUES (NEW.branch_name, new_count, new_sum, new_min, new_max);
    END IF;
    
    
    
  ELSE
    SET new_count = (SELECT num_accounts
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	SET new_sum = (SELECT total_deposits - OLD.balance + NEW.balance AS ns 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
    SET new_min = (SELECT min_balance 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	IF NEW.balance < new_min THEN SET new_min = NEW.balance;
    ELSEIF OLD.balance = new_min AND OLD.balance != NEW.balance THEN
      SET new_min = (SELECT MIN(balance)
                                  FROM account
                                  WHERE OLD.branch_name = branch_name
                                  GROUP BY branch_name);
    END IF;
    SET new_max = (SELECT max_balance 
                                  FROM mv_branch_account_stats 
                                  WHERE branch_name = OLD.branch_name);
	IF NEW.balance > new_max THEN SET new_max = NEW.balance;
    ELSEIF OLD.balance = new_max AND OLD.balance != NEW.balance THEN
      SET new_max = (SELECT MAX(balance)
                                  FROM account
                                  WHERE OLD.branch_name = branch_name
                                  GROUP BY branch_name);
    END IF;
    
	REPLACE INTO mv_branch_account_stats 
    VALUES (OLD.branch_name, new_count, new_sum, new_min, new_max);
  END IF;

END |
DELIMITER ;

-- [Problem 1a]
SELECT loan_number, amount FROM loan WHERE amount >= 1000 AND amount <= 2000;


-- [Problem 1b]
SELECT loan_number, amount FROM loan WHERE loan.loan_number IN (
  SELECT DISTINCT borrower.loan_number 
  FROM borrower 
  WHERE customer_name = 'Smith') ORDER BY amount;


-- [Problem 1c]
SELECT DISTINCT branch_city FROM branch WHERE branch.branch_name = (
  SELECT account.branch_name FROM account WHERE account_number = 'A-446');


-- [Problem 1d]
SELECT customer_name, account_number, branch_name, balance 
  FROM account NATURAL JOIN depositor 
  WHERE depositor.customer_name like 'J%' 
  ORDER BY depositor.customer_name;


-- [Problem 1e]
SELECT customer_name 
  FROM depositor 
  GROUP BY customer_name 
  HAVING COUNT(account_number) > 5;


-- [Problem 2a]

CREATE VIEW pownal_customers AS
  SELECT depositor.account_number, depositor.customer_name 
    FROM account NATURAL JOIN depositor 
    WHERE account.branch_name = 'Pownal';
    
-- [Problem 2b]
CREATE VIEW onlyacct_customers AS
  SELECT customer_name, customer_street, customer_city
    FROM customer
    WHERE customer_name IN (SELECT customer_name FROM depositor) 
      AND customer_name NOT IN (SELECT customer_name FROM borrower);

-- [Problem 2c]
CREATE VIEW branch_deposits AS
  SELECT branch.branch_name, IFNULL(SUM(account.balance), 0) AS total_balance,
    AVG(balance) AS avg_balance
    FROM branch LEFT JOIN account ON branch.branch_name = account.branch_name
    GROUP BY branch.branch_name;
SELECT * FROM branch_deposits;

-- [Problem 3a]
SELECT DISTINCT customer_city FROM customer WHERE customer_city NOT IN (
  SELECT branch_city FROM branch) 
  ORDER BY customer_city;

-- [Problem 3b]
SELECT customer_name 
  FROM customer 
  WHERE customer_name NOT IN (SELECT customer_name from borrower)
    AND customer_name NOT IN (SELECT customer_name from depositor);
SELECT * FROM customer;

-- [Problem 3c]
UPDATE account
  SET balance = balance + 50
  WHERE branch_name IN (
    SELECT branch_name FROM branch WHERE branch_city = 'Horseneck');

-- [Problem 3d]
UPDATE account, branch
  SET account.balance = account.balance + 50
  WHERE account.branch_name = branch.branch_name 
    AND branch.branch_city = 'Horseneck';


-- [Problem 3e]
SELECT account_number, account.branch_name, balance FROM account JOIN (
  SELECT branch_name, MAX(balance) AS max_bal
    FROM account 
    GROUP BY branch_name) 
  AS large_accs 
  ON account.balance = large_accs.max_bal 
    AND account.branch_name = large_accs.branch_name;


-- [Problem 3f]
SELECT account_number, branch_name, balance 
  FROM account
  WHERE (branch_name, balance) IN (
    SELECT branch_name, MAX(balance) FROM account GROUP BY branch_name);


-- [Problem 4]
WITH branch_totals AS (
  SELECT branch_name, IFNULL(SUM(assets), 0) AS assets
    FROM branch GROUP BY branch_name)
  SELECT branch_totals.branch_name, branch_totals.assets, ranks.rank 
    FROM branch_totals JOIN (
      SELECT b1.branch_name, COUNT(*) AS rank
        FROM branch_totals AS b1 JOIN branch_totals AS b2 
          ON b1.assets < b2.assets OR b1.branch_name = b2.branch_name
        GROUP BY b1.branch_name) AS ranks 
      ON branch_totals.branch_name = ranks.branch_name
      ORDER BY rank, branch_name;


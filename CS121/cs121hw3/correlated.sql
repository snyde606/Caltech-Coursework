-- [Problem a]
-- Get the number of loans in decreasing order of each customer
SELECT customer_name, count(loan_number) AS num_loans
  FROM customer NATURAL LEFT JOIN borrower 
  GROUP BY customer_name
  ORDER BY num_loans DESC;


-- [Problem b]
-- Get the names of all branches that have less assets than total loan amounts
SELECT branch_name 
  FROM branch NATURAL LEFT JOIN (
    SELECT branch_name, SUM(amount) as tot_amounts FROM loan 
      GROUP BY branch_name) AS amtcts
  WHERE assets < tot_amounts;


-- [Problem c]
SELECT c.branch_name, (
  SELECT COUNT(*) FROM account l
    WHERE l.branch_name = c.branch_name) AS num_accounts, (
  SELECT COUNT(*) FROM loan b
    WHERE b.branch_name = c.branch_name) AS num_loans
  FROM branch c ORDER BY branch_name;


-- [Problem d]
SELECT branch_name, num_accounts, num_loans
  FROM (
    SELECT branch_name, COUNT(account_number) AS num_accounts 
      FROM branch NATURAL LEFT JOIN account GROUP BY branch_name) AS tb1
	NATURAL JOIN (
      SELECT branch_name, COUNT(loan_number) AS num_loans
        FROM branch NATURAL LEFT JOIN loan GROUP BY branch_name) AS tb2
  ORDER BY branch_name;


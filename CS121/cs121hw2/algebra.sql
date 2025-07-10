-- [Problem 1]
SELECT DISTINCT A FROM r;
-- DISTINCT is needed because PI deletes duplicates while SELECT does not.


-- [Problem 2]
SELECT * FROM r WHERE B = 17;
-- No DISTINCT needed because SIGMA doesn't delete duplicates.

-- [Problem 3]
SELECT * FROM r, s;
-- No DISTINCT needed because SIGMA doesn't delete duplicates.

-- [Problem 4]
SELECT DISTINCT A, F FROM r, s WHERE C = D;
-- DISTINCT is needed because PI deletes duplicates while SELECT does not.

-- [Problem 5]
(SELECT * FROM r1) UNION (SELECT * FROM r2);


-- [Problem 6]
(SELECT * FROM r1) INTERSECT (SELECT * FROM r2);


-- [Problem 7]
(SELECT * FROM r1) EXCEPT (SELECT * FROM r2);


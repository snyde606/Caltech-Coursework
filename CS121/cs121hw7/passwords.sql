-- [Problem 1]
DROP TABLE IF EXISTS user_info;
CREATE TABLE user_info (
    username   VARCHAR(20)  NOT NULL,
    salt CHAR(6) NOT NULL,
    password_hash CHAR(64) NOT NULL
);


-- [Problem 2]
DROP PROCEDURE IF EXISTS sp_add_user;
DELIMITER !
CREATE PROCEDURE sp_add_user(
         IN  new_username VARCHAR(20),
	     IN  password VARCHAR(20)
)
BEGIN
  DECLARE salt CHAR(6);
  SET salt = make_salt(6);
  INSERT INTO user_info VALUES (new_username, salt, SHA2(
    CONCAT(salt, password), 256));
END !
DELIMITER ;

-- [Problem 3]
DROP PROCEDURE IF EXISTS sp_change_password;
DELIMITER !
CREATE PROCEDURE sp_change_password(
         IN  new_username VARCHAR(20),
	     IN  password VARCHAR(20)
)
BEGIN
  DECLARE salty CHAR(6);
  SET salty = make_salt(6);
  UPDATE user_info
    SET salt = salty, password_hash = SHA2(CONCAT(salt, password), 256)
    WHERE username = new_username;
END !
DELIMITER ;


-- [Problem 4]
DROP FUNCTION IF EXISTS authenticate;
DELIMITER !
CREATE FUNCTION authenticate(new_username VARCHAR(20), password VARCHAR(20))
RETURNS BOOLEAN
BEGIN
  
  DECLARE salty CHAR(6);
  IF new_username IN (SELECT username FROM user_info) THEN 
    SET salty = (SELECT salt FROM user_info WHERE username = new_username);
  ELSE
    RETURN FALSE;
  END IF;
  IF SHA2(CONCAT(salty, password), 256) = (
    SELECT password_hash FROM user_info WHERE username = new_username) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
  
END !
DELIMITER ;

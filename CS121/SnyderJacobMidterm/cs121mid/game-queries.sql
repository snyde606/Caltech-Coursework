-- [Problem 3]
SELECT person_id, person_name
  FROM (SELECT person_id, person_name, COUNT(DISTINCT type_id) AS num_types
		FROM geezer NATURAL JOIN game_score NATURAL JOIN game NATURAL JOIN game_type
		GROUP BY person_id, person_name
		 ) AS t0
  WHERE num_types = (SELECT COUNT(*) FROM game_type);


-- [Problem 4]
WITH top_scores (tid, max_score) AS(
  SELECT type_id, MAX(score) AS max_score
  FROM game_score NATURAL JOIN game NATURAL JOIN game_type
  GROUP BY type_id)
  SELECT type_id, type_name, person_id, person_name, score
  FROM game_score NATURAL JOIN game NATURAL JOIN game_type NATURAL JOIN geezer,
			  top_scores
  WHERE type_id = tid AND score = top_scores.max_score
  ORDER BY type_id, person_id;

-- [Problem 5]


WITH game_counts AS (
  SELECT type_id, COUNT(game_id) AS num_games 
  FROM game
  WHERE game_date <= CURRENT_DATE() 
				AND game_date >= CURRENT_DATE() - INTERVAL 2 WEEK
  GROUP BY type_id
)
  SELECT type_id
  FROM game_counts
  WHERE num_games > (SELECT AVG(num_games) FROM (game_counts));

-- [Problem 6]
DROP TABLE IF EXISTS ted_game_ids;

CREATE TABLE ted_game_ids (
    game_id INT PRIMARY KEY
);

INSERT INTO ted_game_ids (SELECT game_id 
			FROM game_score NATURAL JOIN game NATURAL JOIN game_type
			WHERE person_id = (SELECT person_id
												FROM geezer
												WHERE person_name = 'Ted Codd')
						  AND type_name = 'cribbage');

DELETE FROM game_score WHERE game_id IN (SELECT * FROM ted_game_ids);
DELETE FROM game WHERE game_id IN (SELECT * FROM ted_game_ids);

DROP TABLE IF EXISTS ted_game_ids;

-- [Problem 7]
DROP VIEW IF EXISTS cribbage_player_ids;

CREATE VIEW cribbage_player_ids AS
  SELECT person_id
  FROM game_score NATURAL JOIN game NATURAL JOIN game_type
  WHERE type_name = 'cribbage';
  
UPDATE geezer
  SET prescriptions = 'Extra pudding on Thursdays!'
  WHERE person_id IN (SELECT * FROM cribbage_player_ids) 
                AND prescriptions IS NULL;
UPDATE geezer
  SET prescriptions = CONCAT(prescriptions, ' Extra pudding on Thursdays!')
  WHERE person_id IN (SELECT * FROM cribbage_player_ids) 
                AND prescriptions IS NOT NULL;
  
DROP VIEW IF EXISTS cribbage_player_ids;


-- [Problem 8]
WITH max_scores (gid, max_score) AS (
    SELECT game_id, MAX(score) AS max_score
    FROM game_score NATURAL JOIN game NATURAL JOIN game_type
    WHERE min_players > 1
    GROUP BY game_id
  ),
  wins_or_ties (gid, pid) AS (
    SELECT game_id, person_id
    FROM game_score NATURAL JOIN geezer, max_scores
    WHERE max_score = score AND gid = game_id
  ),
  point_vals (person_id, points_for_game) AS (
    SELECT person_id, CASE WHEN 1 = (
      SELECT COUNT(*) 
      FROM wins_or_ties
      GROUP BY gid
      HAVING gid = game_id) THEN 1
      WHEN (
      SELECT COUNT(*) 
      FROM wins_or_ties
      GROUP BY gid
      HAVING gid = game_id) > 1 THEN 0.5
      ELSE 0 END AS points_for_game
      FROM game_score NATURAL JOIN geezer
  )
  SELECT person_id, person_name, SUM(points_for_game) AS total_points
  FROM geezer NATURAL JOIN point_vals
  GROUP BY person_id, person_name
  ORDER BY total_points DESC;



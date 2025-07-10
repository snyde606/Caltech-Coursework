-- [Problem 1]
DROP TABLE IF EXISTS game_score;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS game_type;
DROP TABLE IF EXISTS geezer;


-- [Problem 2]

-- Table containing information about the old residents
CREATE TABLE geezer (
    person_id   INTEGER NOT NULL AUTO_INCREMENT,
    person_name VARCHAR(100) NOT NULL,
    gender CHAR(1) NOT NULL, -- This column can only take M or F
    birth_date DATE NOT NULL,
    prescriptions VARCHAR(1000),
    PRIMARY KEY (person_id),
    CHECK (gender = 'M' OR gender = 'F')
);

-- Table containing details about the different types of games
CREATE TABLE game_type (
    type_id   INTEGER NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(20) NOT NULL,
    game_desc VARCHAR(1000) NOT NULL,
    min_players INTEGER NOT NULL, -- This column must take a positive integer
    max_players INTEGER, -- This column must either be null
    -- (to indicate unlimited players) or greater or equal to the min_players
    -- column
    PRIMARY KEY (type_id),
    CHECK (min_players > 0 AND (
        max_players IS NULL OR max_players >= min_players))
);

-- Table containing game instances
CREATE TABLE game (
    game_id   INTEGER NOT NULL AUTO_INCREMENT,
    type_id INTEGER NOT NULL,
    game_date TIMESTAMP NOT NULL,
    PRIMARY KEY (game_id),
    FOREIGN KEY (type_id) REFERENCES game_type(type_id)
);

-- Table containing scores associated with people and game instances
CREATE TABLE game_score (
    game_id   INTEGER     NOT NULL,
    person_id INTEGER NOT NULL,
    score INTEGER NOT NULL,
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (person_id) REFERENCES geezer(person_id)
);
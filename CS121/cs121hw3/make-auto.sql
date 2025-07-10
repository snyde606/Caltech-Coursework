-- [Problem 1]
DROP TABLE IF EXISTS participated;
DROP TABLE IF EXISTS owns;
DROP TABLE IF EXISTS accident;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS person;


-- Table containing people's lisence information
CREATE TABLE person (
    driver_id   CHAR(10) NOT NULL,
    name VARCHAR(80) NOT NULL,
    address VARCHAR(80) NOT NULL,
    PRIMARY KEY (driver_id)
);

-- Table containing car details
CREATE TABLE car (
    license   CHAR(7) NOT NULL,
    model VARCHAR(80),
    year CHAR(4),
    PRIMARY KEY (license)
);

-- Table containing accident reports
CREATE TABLE accident (
    report_number   INTEGER NOT NULL AUTO_INCREMENT,
    date_occurred TIMESTAMP NOT NULL,
    location VARCHAR(300) NOT NULL,
    description VARCHAR(3000),
    PRIMARY KEY (report_number)
);

-- Table containing recitation ownership information
CREATE TABLE owns (
    driver_id   CHAR(10)     NOT NULL,
    license CHAR(7) NOT NULL,
    PRIMARY KEY (driver_id, license),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id) 
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (license) REFERENCES car(license) 
      ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table containing accident participant details
CREATE TABLE participated (
    driver_id   CHAR(10) NOT NULL,
    license CHAR(7) NOT NULL,
    report_number INTEGER NOT NULL AUTO_INCREMENT,
    damage_amount NUMERIC(10,2),
    PRIMARY KEY (driver_id, license, report_number),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id) ON UPDATE CASCADE,
    FOREIGN KEY (license) REFERENCES car(license) ON UPDATE CASCADE,
    FOREIGN KEY (report_number) REFERENCES accident(report_number) 
      ON UPDATE CASCADE
);
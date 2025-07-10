-- [Problem 5]

-- DROP TABLE commands:
DROP TABLE IF EXISTS ticket_unique;
DROP TABLE IF EXISTS seat;
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS airplane;
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS purchase;
DROP TABLE IF EXISTS purchaser;
DROP TABLE IF EXISTS traveler;
DROP TABLE IF EXISTS customer_phone_numbers;
DROP TABLE IF EXISTS customer;


-- CREATE TABLE commands:

-- This table contains information about any customers whether they be
-- purchasers or travelers.
CREATE TABLE customer (
    cust_ID   INTEGER  AUTO_INCREMENT   NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email_address VARCHAR(100) NOT NULL,
    PRIMARY KEY (cust_ID)
);

-- This table is used to store multiple phone numbers for customers.
CREATE TABLE customer_phone_numbers (
    cust_ID   INTEGER  AUTO_INCREMENT  NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    PRIMARY KEY (cust_ID, phone_number),
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
    ON UPDATE CASCADE ON DELETE CASCADE -- Used to ensure that this value 
    -- is kept up to date
);

-- This table contains travel information for travelers, which is a subset of
-- customers.
CREATE TABLE traveler (
    cust_ID   INTEGER  AUTO_INCREMENT  NOT NULL,
    passport_number VARCHAR(40),
    country_of_citizenship VARCHAR(50),
    emergency_contact VARCHAR(50),
    emerg_phone_number VARCHAR(12),
    frq_fly_num CHAR(7),
    PRIMARY KEY (cust_ID),
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
    ON UPDATE CASCADE ON DELETE CASCADE -- Used to ensure that this value
    -- is kept up to date
);

-- This table contains payment information for purchasers, who are subset
-- of customers.
CREATE TABLE purchaser (
    cust_ID   INTEGER AUTO_INCREMENT   NOT NULL,
    card_number CHAR(16),
    expiration_date CHAR(5),
    verification_code CHAR(3),
    PRIMARY KEY (cust_ID),
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
    ON UPDATE CASCADE ON DELETE CASCADE -- Used to ensure that this value
    -- is kept up to date
);

-- This table contains information about transactions completed by
-- purchasers.
CREATE TABLE purchase (
    purchase_ID INTEGER NOT NULL,
    cust_ID   INTEGER  AUTO_INCREMENT  NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    confirmation_number CHAR(6) UNIQUE NOT NULL,
    PRIMARY KEY (purchase_ID),
    FOREIGN KEY (cust_ID) REFERENCES purchaser(cust_ID)
    ON UPDATE CASCADE ON DELETE CASCADE -- Used to ensure that this value
    -- is kept up to date
);

-- This table contains information about tickets purchased by purchasers.
CREATE TABLE ticket (
    ticket_ID INTEGER UNIQUE NOT NULL,
    cust_ID   INTEGER  AUTO_INCREMENT  NOT NULL,
    purchase_ID INTEGER NOT NULL,
    sale_price DOUBLE NOT NULL,
    PRIMARY KEY (ticket_ID),
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (purchase_ID) REFERENCES purchase(purchase_ID)
    ON UPDATE CASCADE ON DELETE CASCADE, -- Used to ensure that this value
    -- is kept up to date
    CHECK (sale_price<10000)
);

-- This table contains information about planes used for flights.
CREATE TABLE airplane (
    type_code   CHAR(3)    NOT NULL, -- This is a 3 character code used to
    -- identify aircraft
    company VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
    PRIMARY KEY (type_code)
);

-- This table contains information about outgoing flights.
CREATE TABLE flight (
    flight_number   VARCHAR(10)    NOT NULL,
    date DATE NOT NULL,
    type_code CHAR(3) NOT NULL, -- This is a 3 character code used to
    -- identify aircraft
    time TIME NOT NULL,
    source_airport CHAR(3) NOT NULL,
    dest_airport CHAR(3) NOT NULL,
    domestic BOOLEAN NOT NULL,
    PRIMARY KEY (flight_number, date),
    FOREIGN KEY (type_code) REFERENCES airplane(type_code)
    ON UPDATE CASCADE ON DELETE CASCADE -- Used to ensure that this value
    -- is kept up to date
);

-- This table contains information about seats on each plane.
CREATE TABLE seat (
    type_code   CHAR(3)    NOT NULL, -- This is a 3 character code used to
    -- identify aircraft
    number VARCHAR(4) NOT NULL,
    class CHAR(1) NOT NULL,
    type CHAR(1) NOT NULL,
    exit_row BOOLEAN NOT NULL,
    PRIMARY KEY (type_code, number),
    FOREIGN KEY (type_code) REFERENCES airplane(type_code)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- This table associates a ticket with a seat on a flight.
CREATE TABLE ticket_unique (
    flight_number   VARCHAR(10)    NOT NULL,
    date DATE NOT NULL,
    type_code CHAR(3) NOT NULL, -- This is a 3 character code used to
    -- identify aircraft
    number VARCHAR(4) NOT NULL,
    ticket_ID INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (flight_number, date, type_code, number),
    FOREIGN KEY (flight_number, date) REFERENCES flight(flight_number, date)
    ON UPDATE CASCADE ON DELETE CASCADE, -- Used to ensure that this value
    -- is kept up to date
    FOREIGN KEY (type_code, number) REFERENCES seat(type_code, number)
    ON UPDATE CASCADE ON DELETE CASCADE, -- Used to ensure that this value
    -- is kept up to date
    FOREIGN KEY (ticket_ID) REFERENCES ticket(ticket_ID)
    ON UPDATE CASCADE ON DELETE CASCADE -- Used to ensure that this value
    -- is kept up to date
);


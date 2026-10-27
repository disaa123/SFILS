--- Dustin Isaacson
--- Assignment 1
--- Combined scripts used to import, create and manipulate the database
--- broken into 4 tables, utilizes foreign keys to join


CREATE DATABASE IF NOT EXISTS assignment1;

USE assignment1;

CREATE TABLE library_usage (
    patron_type_code INT,
    patron_type_def VARCHAR(100),
    checkout_total INT,
    renewal_total INT,
    age_range VARCHAR(50),
    home_library_code VARCHAR(20),
    home_library_def VARCHAR(100),
    circ_active_month VARCHAR(20),
    circ_active_year INT,
    notification_code VARCHAR(20),
    notification_type VARCHAR(50),
    provided_email VARCHAR(10),
    within_SanFranCounty VARCHAR(10),
    year_registered INT
);

LOAD DATA LOCAL INFILE
'D:/College/Fall 2026/DataBases/assignment1/SFPL_DataSF_library-usage_Jan_2023.csv'
INTO TABLE library_usage
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE TABLE patron_types (
    patron_type_code INT PRIMARY KEY,
    patron_type_def VARCHAR(100)
);

INSERT INTO patron_types
SELECT DISTINCT
    patron_type_code,
    patron_type_def
FROM library_usage;

CREATE TABLE libraries (
    home_library_code VARCHAR(20) PRIMARY KEY,
    home_library_def VARCHAR(100)
);

INSERT INTO libraries (
    home_library_code,
    home_library_def
)
SELECT
    home_library_code,
    MAX(home_library_def)
FROM library_usage
WHERE home_library_code IS NOT NULL
GROUP BY home_library_code;

CREATE TABLE libraries (
    home_library_code VARCHAR(20) PRIMARY KEY,
    home_library_def VARCHAR(100)
);

INSERT INTO libraries (
    home_library_code,
    home_library_def
)
SELECT
    home_library_code,
    MAX(home_library_def)
FROM library_usage
WHERE home_library_code IS NOT NULL
GROUP BY home_library_code;

CREATE TABLE notification_types (
    notification_code VARCHAR(20) PRIMARY KEY,
    notification_type VARCHAR(50)
);

INSERT INTO notification_types (
    notification_code,
    notification_type
)
SELECT
    notification_code,
    MAX(notification_type)
FROM library_usage
WHERE notification_code IS NOT NULL
GROUP BY notification_code;

CREATE TABLE patrons (
    patron_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_type_code INT,
    home_library_code VARCHAR(20),
    notification_code VARCHAR(20),
    checkout_total INT,
    renewal_total INT,
    age_range VARCHAR(50),
    circ_active_month VARCHAR(20),
    circ_active_year INT,
    provided_email VARCHAR(10),
    within_SanFranCounty VARCHAR(10),
    year_registered INT
);

INSERT INTO patrons (
    patron_type_code,
    home_library_code,
    notification_code,
    checkout_total,
    renewal_total,
    age_range,
    circ_active_month,
    circ_active_year,
    provided_email,
    within_SanFranCounty,
    year_registered
)
SELECT
    patron_type_code,
    home_library_code,
    notification_code,
    checkout_total,
    renewal_total,
    age_range,
    circ_active_month,
    circ_active_year,
    provided_email,
    within_SanFranCounty,
    year_registered
FROM library_usage;

ALTER TABLE patrons
ADD CONSTRAINT fk_patron_type
FOREIGN KEY (patron_type_code)
REFERENCES patron_types(patron_type_code);

ALTER TABLE patrons
ADD CONSTRAINT fk_home_library
FOREIGN KEY (home_library_code)
REFERENCES libraries(home_library_code);

ALTER TABLE patrons
ADD CONSTRAINT fk_notification
FOREIGN KEY (notification_code)
REFERENCES notification_types(notification_code);
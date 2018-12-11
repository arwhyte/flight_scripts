SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS airport, flight, airline, aircraft, temp_airport, temp_airline, iatacode, airline_iata, airportname, city, state, country, latitude, longitude;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE IF NOT EXISTS temp_airport (
  airport_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  iata_code CHAR(3) NOT NULL,
  airport_name VARCHAR(255) NOT NULL,
  city VARCHAR(45) NOT NULL,
  state CHAR(2) NOT NULL,
  country CHAR(3) NOT NULL,
  latitude VARCHAR(50) NOT NULL,
  longitude VARCHAR(50) NOT NULL,
  PRIMARY KEY (airport_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE temp_airport
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (iata_code, airport_name, city, state, country, latitude, longitude);

CREATE TABLE IF NOT EXISTS iatacode (
  iata_code_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  iata_code_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (iata_code_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE iatacode
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (iata_code_name, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

CREATE TABLE IF NOT EXISTS airportname (
  airport_name_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  airportname VARCHAR(100) NOT NULL,
  PRIMARY KEY (airport_name_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE airportname
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@dummy, @airportname, @dummy, @dummy, @dummy, @dummy, @dummy);

CREATE TABLE IF NOT EXISTS city (
  city_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  city_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (city_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE city
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@dummy, @dummy, city_name, @dummy, @dummy, @dummy, @dummy);

CREATE TABLE IF NOT EXISTS state (
  state_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  state_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (state_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE state
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@dummy, @dummy, @dummy, state_name, @dummy, @dummy, @dummy);

CREATE TABLE IF NOT EXISTS country (
  country_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  country_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (country_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE country
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@dummy, @dummy, @dummy, @dummy, country_name, @dummy, @dummy);

CREATE TABLE IF NOT EXISTS latitude (
  latitude_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  latitude_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (latitude_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE latitude
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@dummy, @dummy, @dummy, @dummy, @dummy, latitude_name, @dummy);

CREATE TABLE IF NOT EXISTS longitude (
  longitude_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  longitude_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (longitude_id)
)
ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

LOAD DATA LOCAL INFILE './input/csv/airports.csv'
INTO TABLE longitude
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, longitude_name);

CREATE TABLE IF NOT EXISTS temp_airline (
  airline_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  iata_code CHAR(3) NOT NULL,
  airline_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (airline_id)
)
  ENGINE=InnoDB
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

  LOAD DATA LOCAL INFILE './input/csv/airlines.csv'
  INTO TABLE temp_airline
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (iata_code, airline_name);

CREATE TABLE IF NOT EXISTS airline_iata (
  airline_iata_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  airline_iata_name CHAR(2) NOT NULL,
  PRIMARY KEY (airline_iata_id)
)
  ENGINE=InnoDB
  CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

  LOAD DATA LOCAL INFILE './input/csv/airlines.csv'
  INTO TABLE airline_iata
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (airline_iata_name, @dummy);

CREATE TABLE IF NOT EXISTS airport (
  airport_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  iata_code CHAR(3) NOT NULL,
  airport_name VARCHAR(255) NOT NULL,
  city VARCHAR(45) NOT NULL,
  state CHAR(2) NOT NULL,
  country CHAR(3) NOT NULL,
  latitude VARCHAR(50) NOT NULL,
  longitude VARCHAR(50) NOT NULL,
  PRIMARY KEY (airport_id)
)
  ENGINE=InnoDB
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

  LOAD DATA LOCAL INFILE './input/csv/airports.csv'
  INTO TABLE airport
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (iata_code, airport_name, city, state, country, latitude, longitude);

-- INSERT IGNORE INTO airport (
--   iata_code_id,
--   airport_name_id,
--   city_id,
--   state_id,
--   country_id,
--   latitude_id,
--   longitude_id,
-- )

INSERT IGNORE INTO airline (
airline_id,
airline_name,
airline_iata_code_id
)


SELECT ta.airline_id, ta.airline_name, ta.airline_iata_id
  FROM temp_airline ta
       LEFT JOIN airline_iata ai
              ON TRIM(ta.airline_name) = TRIM(ai.airline_name)
ORDER BY ta.airline_name;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS airport, flight, airline, aircraft, temp_flight;
SET FOREIGN_KEY_CHECKS=1;


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
CHARACTER SET ascii
COLLATE ascii_general_ci;

LOAD DATA LOCAL INFILE './output/airlines/airports_trimmed.csv'
INTO TABLE airport
  CHARACTER SET ascii
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (iata_code, airport_name, city, state, country, latitude, longitude);


CREATE TABLE IF NOT EXISTS airline (
  airline_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  iata_code CHAR(3) NOT NULL,
  airline_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (airline_id)
)
  ENGINE=InnoDB
  CHARACTER SET ascii
  COLLATE ascii_general_ci;

  LOAD DATA LOCAL INFILE './output/airlines/airlines_trimmed.csv'
  INTO TABLE airline
    CHARACTER SET ascii
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (iata_code, airline_name);

CREATE TABLE IF NOT EXISTS temp_flight (
  flight_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  day INTEGER NOT NULL,
  day_of_week INTEGER NOT NULL,
  airline CHAR(2) NOT NULL,
  flight_number INTEGER NOT NULL,
  tail_number VARCHAR(6) NOT NULL,
  origin_airport CHAR(3) NOT NULL,
  destination_airport CHAR(3) NOT NULL,
  scheduled_departure INTEGER NOT NULL,
  departure_time VARCHAR(50) NOT NULL,
  departure_delay VARCHAR(50) NOT NULL,
  taxi_out VARCHAR(50) NOT NULL,
  wheels_off VARCHAR(50) NOT NULL,
  scheduled_time VARCHAR(50) NOT NULL,
  elapsed_time VARCHAR(50) NOT NULL,
  air_time VARCHAR(50) NOT NULL,
  distance INTEGER NOT NULL,
  wheels_on VARCHAR(50) NOT NULL,
  taxi_in VARCHAR(50) NOT NULL,
  scheduled_arrival INTEGER NOT NULL,
  arrival_time VARCHAR(50) NOT NULL,
  arrival_delay VARCHAR(50) NOT NULL,
  diverted INTEGER NOT NULL,
  cancelled INTEGER NOT NULL,
  PRIMARY KEY (flight_id)
)
  ENGINE=InnoDB
  CHARACTER SET ascii
  COLLATE ascii_general_ci;

  LOAD DATA LOCAL INFILE './output/airlines/flights_trimmed.csv'
  INTO TABLE temp_flight
    CHARACTER SET ascii
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (year, month, day, day_of_week, airline, flight_number, tail_number, origin_airport, destination_airport, scheduled_departure, departure_time, departure_delay, taxi_out, wheels_off, scheduled_time, elapsed_time, air_time, distance, wheels_on, taxi_in, scheduled_arrival, arrival_time, arrival_delay, diverted, cancelled);

CREATE TABLE IF NOT EXISTS aircraft (
  aircraft_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  tail_number VARCHAR(6) NOT NULL,
  PRIMARY KEY (aircraft_id)
)
  ENGINE=InnoDB
  CHARACTER SET ascii
  COLLATE ascii_general_ci;

  LOAD DATA LOCAL INFILE './output/airlines/flights_trimmed.csv'
  INTO TABLE aircraft
    CHARACTER SET ascii
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, tail_number, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);


CREATE TABLE IF NOT EXISTS flight (
  flight_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  day INTEGER NOT NULL,
  day_of_week INTEGER NOT NULL,
  airline CHAR(2) NOT NULL,
  airline_id INTEGER NOT NULL,
  aircraft_id INTEGER NOT NULL,
  flight_number INTEGER NOT NULL,
  origin_airport CHAR(3) NOT NULL,
  destination_airport CHAR(3) NOT NULL,
  scheduled_departure INTEGER NOT NULL,
  departure_time VARCHAR(50) NOT NULL,
  departure_delay VARCHAR(50) NOT NULL,
  taxi_out VARCHAR(50) NOT NULL,
  wheels_off VARCHAR(50) NOT NULL,
  scheduled_time VARCHAR(50) NOT NULL,
  elapsed_time VARCHAR(50) NOT NULL,
  air_time VARCHAR(50) NOT NULL,
  distance INTEGER NOT NULL,
  wheels_on VARCHAR(50) NOT NULL,
  taxi_in VARCHAR(50) NOT NULL,
  scheduled_arrival INTEGER NOT NULL,
  arrival_time VARCHAR(50) NOT NULL,
  arrival_delay VARCHAR(50) NOT NULL,
  diverted INTEGER NOT NULL,
  cancelled INTEGER NOT NULL,
  PRIMARY KEY (flight_id),
  FOREIGN KEY (airline_id) REFERENCES airline(airline_id)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id)
  ON DELETE CASCADE ON UPDATE CASCADE,
)
  ENGINE=InnoDB
  CHARACTER SET ascii
  COLLATE ascii_general_ci;

INSERT IGNORE INTO flight
(
  year,
  month,
  day,
  day_of_week,
  airline,
  airline_id,
  aircraft_id,
  flight_number,
  origin_airport,
  destination_airport,
  scheduled_departure,
  departure_time,
  departure_delay,
  taxi_out,
  wheels_off,
  scheduled_time,
  elapsed_time,
  air_time,
  distance,
  wheels_on,
  taxi_in,
  scheduled_arrival,
  arrival_time,
  arrival_delay,
  diverted,
  cancelled
)

SELECT tf.year, tf.month, tf.day, tf.day_of_week, tf.airline, air.airline_id, ac.aircraft_id
  FROM temp_flight tf
      LEFT JOIN airline air
            ON TRIM(tf.flight_id) = TRIM(air.airline_id)
      LEFT JOIN aircraft ac
            ON TRIM(tf.flight_id) = TRIM(ac.aircraft_id)
ORDER BY tf.airline;

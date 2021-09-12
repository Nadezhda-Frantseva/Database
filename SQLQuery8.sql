--Дефиниране на ограничения на ниво таблица
--Упражнение
--1:

CREATE DATABASE Flights;
USE  Flights;

CREATE TABLE Airline(
code int NOT NULL,
name varchar(50),
country varchar(30)
)

CREATE TABLE Airport(
code int NOT NULL,
name varchar(50),
country varchar(30),
town varchar(30)
)

CREATE TABLE Airplane(
code int NOT NULL,
type varchar(10),
places int,
year int
)

CREATE TABLE Flight(
number int NOT NULL,
airlineCode int,
startAirportCode int,
endAirportCode int,
flightTime time,
duration int,
planeCode int
)

CREATE TABLE Customer(
ID int NOT NULL,
firstName varchar(30),
lastName varchar(30),
email varchar(50)
)

CREATE TABLE Agency(
name varchar(30) NOT NULL,
country varchar(30),
town varchar(30),
telephone char(10)
)

CREATE TABLE Booking(
code int NOT NULL,
agencyName varchar(30),
airLineCode int,
flightNumber int,
customerID int,
reservationDate date,
flightDate date,
price float,
confirmed char(3) CHECK (confirmed IN ('yes','no'))
)

--2
--a
ALTER TABLE Airline ADD CONSTRAINT pk_al PRIMARY KEY(code);
ALTER TABLE Airport ADD CONSTRAINT pk_aport PRIMARY KEY(code);
ALTER TABLE Airplane ADD CONSTRAINT pk_aplane PRIMARY KEY(code);
ALTER TABLE Flight ADD CONSTRAINT pk_flight PRIMARY KEY(number);
ALTER TABLE Customer ADD CONSTRAINT pk_cust PRIMARY KEY(ID);
ALTER TABLE Agency ADD CONSTRAINT pk_agency PRIMARY KEY(name);
ALTER TABLE Booking ADD CONSTRAINT pk_booking PRIMARY KEY(code);

--b
ALTER TABLE Flight ADD CONSTRAINT fk_al_flight FOREIGN KEY(airlineCode) REFERENCES Airline(code);
ALTER TABLE Flight ADD CONSTRAINT fk_booking_flight FOREIGN KEY(planeCode) REFERENCES Booking(code);

ALTER TABLE Flight ADD CONSTRAINT fk_ap_flight FOREIGN KEY(startAirportCode) REFERENCES Airport(code);
ALTER TABLE Flight ADD CONSTRAINT fk_apend_flight FOREIGN KEY(endAirportCode) REFERENCES Airport(code);

ALTER TABLE Flight ADD CONSTRAINT fk_ap_flight_plane FOREIGN KEY(planeCode) REFERENCES Airplane(code);

ALTER TABLE Booking ADD CONSTRAINT fk_agency_booking FOREIGN KEY(agencyName) REFERENCES Agency(name);

ALTER TABLE Booking ADD CONSTRAINT fk_flight_booking FOREIGN KEY(flightNumber) REFERENCES Flight(number);

ALTER TABLE Booking ADD CONSTRAINT fk_customer_booking FOREIGN KEY(customerID) REFERENCES Customer(ID);

--d
ALTER TABLE Airline ADD CONSTRAINT uq_airline_name UNIQUE(name);
ALTER TABLE Airport ADD CONSTRAINT uq_airport UNIQUE(name,country);

--e
ALTER TABLE Airplane ADD CONSTRAINT chk_places CHECK(places>0);

ALTER TABLE Booking ADD CONSTRAINT chk_date CHECK(reservationDate<=flightDate);

ALTER TABLE Customer ADD CONSTRAINT chk_email CHECK(email LIKE '%_@_%_._%');

ALTER TABLE Booking ADD CONSTRAINT chk_state CHECK(confirmed IN (0,1));

select * from information_schema.table_constraints
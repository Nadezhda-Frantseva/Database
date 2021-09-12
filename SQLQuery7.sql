--Дефиниране на схеми на релации
--Упражнение

--1:
--а)
CREATE TABLE Product(
maker char(1),
model char(4),
type varchar(7));

CREATE TABLE Printer(
code int,
model char(4),
price decimal(16,2));

--б)
INSERT INTO Product(maker,model,type) VALUES ('H','1234','pc');  
INSERT INTO Printer(code,model,price) VALUES (1235,'1235',299.99);

--в)
ALTER TABLE Printer ADD type varchar(6); 
ALTER TABLE Printer ADD color char(1);  
ALTER TABLE Printer ADD color char(1) default 'n';
ALTER TABLE Printer ADD CONSTRAINT ck_printer_type CHECK(type in ('laser','matrix','jet'));
ALTER TABLE Printer ADD CONSTRAINT ck_printer_color CHECK(color in ('y','n'));
--г)
ALTER TABLE Printer DROP COLUMN price;

--д)
DROP TABLE Product;
DROP TABLE Printer;

--2
--а)

USE master;
CREATE DATABASE fb;
USE fb;

CREATE TABLE Users(
id bigint,
email varchar(50),
password varchar(20),
registrationDate date);

CREATE TABLE Friends(
user1 bigint,
user2 bigint);

CREATE TABLE Walls(
ownerID bigint,          
writerID bigint,
message varchar(1000),
messageDate date);

CREATE TABLE Groups(
id bigint,
name varchar(30),
text varchar(100) DEFAULT '');

CREATE TABLE GroupsMember(
userID bigint,
groupID bigint);

--б)
INSERT INTO Users(id,email,password,registrationDate) VALUES(12345,'nadezhda_frantseva@abv.bg','12345678910','2021-04-25');
INSERT INTO Friends VALUES(123,456);
INSERT INTO Friends VALUES(12345,456);
INSERT INTO Walls(owberID,writerID,message,messageDate) VALUES(123,456,'hello, how are you ?', '2021-04-25'); 
INSERT INTO Groups(id,name) VALUES(12345,'students');
INSERT INTO Groups(id,name,text) VALUES(123,'students','group: students');
INSERT INTO GroupsMember VALUES(12345,123);

SELECT *
FROM Users;
SELECT *
FROM Friends;
SELECT *
FROM Walls; 
SELECT *
FROM Groups;
SELECT *
FROM GroupsMember;

DROP TABLE Users;
DROP TABLE Friends;
DROP TABLE Walls;
DROP TABLE Groups;
DROP TABLE GroupsMember;

DROP DATABASE fb;
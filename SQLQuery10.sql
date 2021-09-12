--Тригери
--Задачи

USE FLIGHTS

--1. Добавете нова колона num_pass към таблицата Flights, която ще съдържа броя на
--   пътниците, потвърдили резервация за съответния полет 

ALTER TABLE FLIGHTS ADD num_pass INT;
--проверка:
SELECT * FROM FLIGHTS;

--2. Добавете нова колона num_book към таблицата Agencies, която ще съдържа броя на
--   резервациите към съответната агенция.

ALTER TABLE Agencies ADD num_book INT;
--проверка:
SELECT * FROM Agencies;

-- 3. Създайте тригер за таблицата Bookings, който да се задейства при вмъкване на
--    резервация в таблицата и да увеличава с единица броя на пътниците, потвърдили
--    резервация за таблицата Flights, както и броя на резервациите към съответната агенция.

CREATE TRIGGER trigger_one ON Bookings
AFTER INSERT
AS
BEGIN
	UPDATE FLIGHTS SET num_pass=num_pass+1 WHERE fnumber=(SELECT FLIGHT_NUMBER FROM INSERTED);
	UPDATE AGENCIES SET num_book=num_book+1 WHERE name=(SELECT agency FROM inserted);
END;
--ПРОВЕРКИ:
INSERT INTO Bookings VALUES('YI111P'),('AGG'),('OO'),('TK1111'),(12),(2021-05-24),(2021-11-11),(100.00),(1);
select * from bookings

-- 4. Създайте тригер за таблицата Bookings, който да се задейства при изтриване на
--    резервация в таблицата и да намалява с единица броя на пътниците, потвърдили
--    резервация за таблицата Flights, както и броя на резервациите към съответната агенция

CREATE TRIGGER trigger_two ON Bookings 
AFTER DELETE
AS
BEGIN
	UPDATE FLIGHTS SET num_pass=num_pass-1 WHERE fnumber=(SELECT FLIGHT_NUMBER FROM DELETED);
	UPDATE AGENCIES SET num_book=num_book-1 WHERE name=(SELECT agency FROM DELETED);
END;

--ПРОВЕРКИ:
DELETE FROM Bookings WHERE Bookings.CODE = 'YA298P';
select * from bookings;
select * from FLIGHTS;
select * from AGENCIES;

--5. Създайте тригер за таблицата Bookings, който да се задейства при обновяване на
--   резервация в таблицата и да увеличава или намалява с единица броя на пътниците,
--   потвърдили резервация за таблицата Flights при промяна на статуса на резервацията.

CREATE TRIGGER trigger_three ON Bookings 
AFTER UPDATE
AS
BEGIN
	UPDATE FLIGHTS SET num_pass=num_pass+1 WHERE fnumber=(SELECT FLIGHT_NUMBER FROM INSERTED);
	UPDATE AGENCIES SET num_book=num_book+1 WHERE name=(SELECT agency FROM INSERTED);
	UPDATE FLIGHTS SET num_pass=num_pass-1 WHERE fnumber=(SELECT FLIGHT_NUMBER FROM DELETED);
	UPDATE AGENCIES SET num_book=num_book-1 WHERE name=(SELECT agency FROM DELETED);
END;
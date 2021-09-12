--Изгледи и индекси
--Упражнение

--1
USE FLIGHTS
CREATE VIEW view_one(name,num, count_id)
AS
	SELECT airlines.name, flights.fnumber, COUNT(customer_id) AS count_id
	FROM airlines JOIN flights ON (airlines.code=flights.airline_operator) JOIN bookings ON (flights.fnumber=bookings.flight_number)
	GROUP BY airlines.name, flights.fnumber

select * from view_one
DROP VIEW view_one

--2 TO DO
CREATE VIEW view_two
AS
	SELECT CUSTOMERS.FNAME
	FROM CUSTOMERS JOIN BOOKINGS ON ID=CUSTOMER_ID
	GROUP BY AGENCY,CUSTOMERS.FNAME
	HAVING COUNT(CUSTOMER_ID)>=ALL(SELECT COUNT(CUSTOMER_ID)
	                               FROM CUSTOMERS JOIN BOOKINGS ON ID=CUSTOMER_ID
	                               GROUP BY AGENCY,CUSTOMERS.FNAME);
CREATE VIEW view_two2
AS
  SELECT DISTINCT agency,
                  Max(bookings_count) AS max
  FROM   (SELECT agency,
                 customer_id,
                 Count(code) AS bookings_count
          FROM   bookings
          GROUP  BY agency,
                    customer_id) t1
  WHERE  bookings_count = (SELECT TOP 1 Count(code) AS bookings_count
                           FROM   bookings t2
                           WHERE  t2.agency = t1.agency
                                  AND t2.customer_id = t1.customer_id
                           GROUP  BY agency,
                                     customer_id
                           ORDER  BY bookings_count DESC)
  GROUP  BY agency;
select *  from sys.views;
select * from view_two2
DROP VIEW view_two

--3
CREATE VIEW view_three
AS
	SELECT *
	FROM AGENCIES
	WHERE city = 'Sofia'
WITH CHECK OPTION

--4
CREATE VIEW view_four
AS
	SELECT *
	FROM AGENCIES
	WHERE phone IS NULL
WITH CHECK OPTION

--5
INSERT INTO view_three -- може
VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359');

INSERT INTO view_three -- може
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);

INSERT INTO view_three --не може да се вмъкне, защото града е Varna
VALUES('T3 Tour', 'Bulgaria', 'Varna','+359');

INSERT INTO view_three --не може да се вмъкне, защото града е Varna
VALUES('T4 Tour', 'Bulgaria', 'Varna',null);

INSERT INTO view_three -- може
VALUES('T4 Tour', 'Bulgaria', 'Sofia','+359');

INSERT INTO view_four -- не може, защото номерът не е NULL
VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359');

INSERT INTO view_four -- може
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);

INSERT INTO view_four -- не може, защото номерът не е NULL
VALUES('T3 Tour', 'Bulgaria', 'Varna','+359');

INSERT INTO view_four -- може
VALUES('T4 Tour', 'Bulgaria', 'Varna',null);

INSERT INTO view_four
VALUES('T4 Tour', 'Bulgaria', 'Sofia','+359');

--6 ???
--Кои от горните изгледи са updateable (т.е. върху тях могат да се изпълняват DML
--оператори)?
alter table AGENCIES drop column num_book;
select * from view_three;
select * from view_four;
select * from agencies;
DELETE FROM AGENCIES
WHERE NAME LIKE 'T1 Tour';
DELETE FROM AGENCIES
WHERE NAME LIKE 'T2 Tour';
DELETE FROM AGENCIES
WHERE NAME LIKE 'T3 Tour';
DELETE FROM AGENCIES
WHERE NAME LIKE 'T4 Tour';
--7
DROP VIEW view_one
DROP VIEW view_two
DROP VIEW view_two2
DROP VIEW view_three
DROP VIEW view_four

--8 
USE PC
CREATE INDEX index_products ON Product(model)
exec sp_helpindex Product

--9
USE Ships
CREATE INDEX index_ships ON Ships(name)
exec sp_helpindex Ships

USE Ships
CREATE INDEX index_classes ON Classes(type)
exec sp_helpindex Classes

USE Ships
CREATE INDEX index_battles ON Battles(name)
exec sp_helpindex Battles

USE Ships
CREATE INDEX index_outcomes ON Outcomes(battle)
exec sp_helpindex Outcomes

--10

DROP INDEX index_ships ON Ships
DROP INDEX index_classes ON Classes
DROP INDEX index_battles ON Battles
DROP INDEX index_outcomes ON Outcomes
-- Общи задачи
--1
CREATE DATABASE FurnitureCompany;
USE FurnitureCompany;

CREATE TABLE CUSTOMER(
Customer_ID int identity(1,1) CONSTRAINT pk_customer PRIMARY KEY,
Customer_Name varchar(50),
Customer_Address varchar(100),
Customer_City varchar(30),
City_Code int);

CREATE TABLE PRODUCT(
Product_ID int CONSTRAINT pk_product PRIMARY KEY,
Product_Description varchar(100),
Product_Finish varchar(30),
Standard_Price int,
Product_Line_ID int,
CHECK (Product_Finish IN ('череша','естествен ясен','бял ясен','червен дъб','естествен дъб','орех')));

CREATE TABLE ORDER_T(
Order_ID int CONSTRAINT pk_order_t PRIMARY KEY,
Order_Date date,
Customer_ID int CONSTRAINT fk_order_t_customer REFERENCES CUSTOMER(Customer_ID));

CREATE TABLE ORDER_LINE(
Order_ID int CONSTRAINT fk_order_line_t REFERENCES ORDER_T(ORDER_ID),
Product_ID int CONSTRAINT fk_order_line_product REFERENCES PRODUCT(Product_ID),
Order_Quantity int,
CONSTRAINT pk_order_line PRIMARY KEY (Order_ID, Product_ID));

insert into CUSTOMER values
('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

insert into PRODUCT values
(1000, 'офис бюро', 'череша', 195, 10),
(1001, 'директорско бюро', 'червен дъб', 250, 10),
(2000, 'офис стол', 'череша', 75, 20),
(2001, 'директорски стол', 'естествен дъб', 129, 20),
(3000, 'етажерка за книги', 'естествен ясен', 85, 30),
(4000, 'настолна лампа', 'естествен ясен', 35, 40);

insert into ORDER_T values
(100, '2013-01-05', 1),
(101, '2013-12-07', 2),
(102, '2014-10-03', 3),
(103, '2014-10-08', 2),
(104, '2015-10-05', 1),
(105, '2015-10-05', 4),
(106, '2015-10-06', 2),
(107, '2016-01-06', 1);

insert into ORDER_LINE values
(100, 4000, 1),
(101, 1000, 2),
(101, 2000, 2),
(102, 3000, 1),
(102, 2000, 1),
(106, 4000, 1),
(103, 4000, 1),
(104, 4000, 1),
(105, 4000, 1),
(107, 4000, 1);

--2
SELECT PRODUCT.Product_ID, PRODUCT.Product_Description, COUNT(ORDER_T.Order_ID) as product_count
FROM PRODUCT JOIN ORDER_LINE ON (PRODUCT.Product_Id = ORDER_LINE.Product_ID) JOIN ORDER_T ON (ORDER_LINE.Order_ID = ORDER_T.Order_ID)
GROUP BY PRODUCT.Product_ID, PRODUCT.Product_Description;

--3
SELECT PRODUCT.Product_ID, PRODUCT.Product_Description, COUNT(ORDER_Line.Order_Quantity) as product_order_quantity
FROM PRODUCT LEFT JOIN ORDER_LINE ON (PRODUCT.Product_Id = ORDER_LINE.Product_ID)
GROUP BY PRODUCT.Product_ID, PRODUCT.Product_Description;

--4
SELECT CUSTOMER.Customer_Name, SUM(PRODUCT.Standard_Price * ORDER_Line.Order_Quantity) as sum
FROM Customer JOIN ORDER_T ON (CUSTOMER.Customer_ID = ORDER_T.Customer_ID) JOIN ORDER_LINE ON ( ORDER_T.Order_ID = ORDER_LINE.Order_ID) JOIN PRODUCT ON (PRODUCT.Product_Id = ORDER_LINE.Product_ID)
GROUP BY CUSTOMER.Customer_Name;

SELECT * FROM CUSTOMER;

--5
USE PC
--1ви начин:
SELECT DISTINCT maker
FROM   product
WHERE  type = 'laptop'
       AND maker IN (SELECT maker
                     FROM   product
                     WHERE  type = 'printer');
--2ри начин: 
SELECT DISTINCT maker
FROM PRODUCT
WHERE type = 'Printer'
INTERSECT 
SELECT DISTINCT maker
FROM PRODUCT
WHERE type = 'Laptop';

--6
UPDATE PC
SET price = price - 0.05 * price
WHERE PC.model IN (SELECT model 
				   FROM product 
				   WHERE maker IN (SELECT maker 
								   FROM PRODUCT JOIN printer ON (product.model = printer.model)  
								   GROUP BY maker
								   HAVING AVG(printer.price) > 800));

--7
SELECT hd, MIN(price)
FROM PC
WHERE hd>=10 AND hd<=30
GROUP BY hd;

--8
USE SHIPS
--a)
CREATE VIEW FIRST_view
AS 
SELECT battle
FROM outcomes JOIN ships ON (outcomes.ship = ships.name) JOIN classes ON (ships.class = classes.class)
WHERE battle != 'Guadalcanal'
GROUP BY battle
HAVING COUNT(outcomes.ship) >= ALL(SELECT COUNT(outcomes.ship)
							       FROM outcomes
							       WHERE battle = 'Guadalcanal')
AND COUNT(classes.country) >= ALL(SELECT COUNT(classes.country)
							      FROM outcomes
							      WHERE battle = 'Guadalcanal'); 
DROP VIEW FIRST_view;
select * from sys.views;
select *
from FIRST_view;

--9 
select *
from outcomes;
DELETE FROM outcomes
WHERE ship IN (SELECT ship 
			   FROM outcomes	
			   GROUP BY ship
			   HAVING COUNT(SHIP) = 1);

--10 
INSERT INTO outcomes VALUES ('Missouri','Surigao Strait', 'sunk'),
('Missouri','North Cape', 'sunk'),
('Missouri','North Atlantic', 'ok');
DELETE FROM outcomes
WHERE OUTCOMES.ship IN (SELECT OUTCOMES.ship
						FROM OUTCOMES JOIN battles ON (OUTCOMES.BATTLE=BATTLES.NAME)
						WHERE result = 'sunk' 
						GROUP BY SHIP
						HAVING COUNT(DATE)>=1);

--11
DROP VIEW second_view;
CREATE VIEW second_view
AS
SELECT DISTINCT battle,country
FROM outcomes JOIN ships ON (outcomes.ship = ships.name) JOIN classes ON (ships.class = classes.class);

select *
from second_view;

SELECT DISTINCT BATTLE
FROM second_view
WHERE BATTLE NOT LIKE 'Guadalcanal'
AND COUNTRY IN  (SELECT COUNTRY
                 FROM second_view
				 WHERE BATTLE='Guadalcanal');

--12
SELECT COUNTRY,COUNT(BATTLE)
FROM CLASSES FULL JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS FULL JOIN OUTCOMES ON SHIP=NAME
GROUP BY COUNTRY;


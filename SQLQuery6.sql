--Модификации на данните в базата от данни
--              Упражнение
--за Movies:
USE movies
--1
INSERT INTO moviestar(name,birthdate) VALUES('Nicole Kidman','1967-06-20');

--проверка:
SELECT *
FROM moviestar;

--2
DELETE FROM movieexec 
WHERE networth < 30000000;

--проверка:
SELECT *
FROM movieexec;

--3
DELETE FROM moviestar
WHERE address is NULL;

--проверка:
SELECT *
FROM moviestar;


--за PC:
USE pc
--1
INSERT INTO product(maker,model,type) VALUES('C',1100,'pc');
INSERT INTO pc(code,model,speed,ram,hd,cd,price) VALUES(12,1100,2400,2048,500,'52x',299);

--проверка:
SELECT *
FROM product;
SELECT *
FROM pc;

--2
DELETE FROM pc
WHERE model=1100;

--проверка:
SELECT *
FROM pc;

--3
DELETE FROM laptop
WHERE model in (SELECT model 
                FROM product 
				WHERE type='laptop' AND  maker NOT IN (SELECT maker
				                                       FROM product 
									                   WHERE type LIKE 'printer'));
--проверка:
SELECT *
FROM product JOIN laptop ON (product.model = laptop.model);
SELECT *
FROM product JOIN printer ON (product.model = printer.model);

--4
UPDATE product 
SET maker='A'
WHERE maker='B';

--проверка:
SELECT *
FROM product;

--5
UPDATE pc
SET price = price/2, hd = hd+20; --!!! може да променяме по 2

--6
UPDATE laptop
SET screen = screen+1
WHERE model in (SELECT model 
                FROM product 
				WHERE type='laptop' AND maker='B');


--за Ships:
USE ships
--1
INSERT INTO ships(name,class,launched) 
VALUES('Nelson','Nelson',1927),
      ('Rodney','Nelson',1927);
INSERT INTO classes(class,type,country,numguns,bore,displacement)
VALUES('Nelson','bb','Gt.Britain',9,16,34000),
      ('Nelson','bb','Gt.Britain',9,16,34000);

DELETE FROM classes
WHERE numguns is null and class like 'Nelson';
SELECT * 
FROM ships join classes on (ships.class=classes.class);

--2
DELETE FROM ships
WHERE name in (SELECT ship 
               FROM outcomes
			   WHERE result LIKE 'sunk');
--проверка:
SELECT *
FROM ships join outcomes on (ships.name=outcomes.ship);

--3
UPDATE classes
SET bore = bore*2.5, displacement = displacement/1.1;

--проверка:
SELECT *
FROM classes;


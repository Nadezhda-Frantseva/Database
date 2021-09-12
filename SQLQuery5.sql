/* Групиране
   Упражнение */
/* I. За базата от данни PC: */
USE pc
--1
SELECT CONVERT(decimal(8,2), AVG(speed)) as AvgSpeed
FROM pc;
--2
SELECT maker, AVG(screen) as AvgScreen
FROM product JOIN laptop ON (product.model = laptop.model)
GROUP BY maker;
--3
SELECT CONVERT(decimal(8,2), AVG(speed)) as AvgSpeed
FROM laptop
WHERE price > 1000;
--4
SELECT maker,CONVERT(decimal(8,2), AVG(price)) as AvgPrice
FROM product JOIN pc ON (product.model = pc.model)
GROUP BY maker
HAVING maker='A';
--5
SELECT maker,CONVERT(decimal(8,1), AVG(price)) as AvgPrice
FROM product JOIN ((SELECT model,price FROM pc) UNION ALL(SELECT model,price FROM laptop))t1 ON (product.model = t1.model) -- !!!
GROUP BY maker
HAVING maker='B';
--6
SELECT speed, AVG(price) as AvgPrice
FROM pc
GROUP BY speed;
--7
SELECT maker, COUNT(pc.code) as Number_of_pc
FROM product JOIN pc ON (product.model = pc.model)
GROUP BY maker
HAVING COUNT(pc.code) >= 3;
--8
SELECT maker, MAX(price) as price
FROM product JOIN pc ON (product.model = pc.model)
WHERE price >= ALL(SELECT price
                    FROM pc)
GROUP BY maker;
--9
SELECT speed, AVG(price) as AvgPrice
FROM pc
GROUP BY speed
HAVING speed > 800; 
--10
SELECT maker, CONVERT(decimal(8,2), AVG(hd)) as PChd
FROM product JOIN pc ON (product.model = pc.model)
WHERE maker IN (SELECT maker
                FROM product JOIN printer ON (product.model = printer.model))
GROUP BY maker;
/* II. За базата от данни SHIPS */
USE ships
--1
SELECT COUNT(class) as NO_classes
FROM classes
WHERE type LIKE 'bb';
--2
SELECT class, AVG(numGuns) as AVG_numguns
FROM classes
WHERE type LIKE 'bb'
GROUP BY class;
--3
SELECT AVG(numGuns) as AVG_numguns
FROM classes
WHERE type LIKE 'bb';
--4
SELECT classes.class, MIN(launched) as FirstYear, MAX(launched) as LastYear
FROM classes JOIN ships ON (classes.class = ships.class)
GROUP BY classes.class;
--5
SELECT class, COUNT(ships.name) as NO_sunk
FROM ships JOIN outcomes ON (ships.name = outcomes.ship)
WHERE result LIKE 'sunk'
GROUP BY class;
--6 ???
SELECT class, COUNT(ships.name) as NO_sunk
FROM ships JOIN outcomes ON (ships.name = outcomes.ship)
WHERE result LIKE 'sunk' AND class IN (SELECT classes.class
                                       FROM ships JOIN classes ON (ships.class = classes.class)
									   GROUP BY classes.class
									   HAVING COUNT(classes.class)>=2)
GROUP BY class;
--7 ???
SELECT country, CONVERT(decimal(8,2),AVG(bore)) as AVG_bore
FROM classes JOIN ships ON (classes.class = ships.class)
GROUP BY country;


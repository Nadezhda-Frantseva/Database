/* Съединения - задачи: */
/* I. За базата от данни Movies: */
USE movies
--1
SELECT title, name
FROM movie inner JOIN movieexec ON (producerc# = cert#)
WHERE cert# IN (SELECT producerc#
                FROM movie
				WHERE title LIKE 'Star Wars');
--2
SELECT DISTINCT name
FROM movieexec inner JOIN movie ON (producerc# = cert#)inner JOIN starsin ON (title = movietitle)
WHERE starname LIKE 'Harrison Ford';
--3
SELECT DISTINCT name, starname
FROM studio inner JOIN movie ON (name = studioname) inner JOIN starsin ON (title = movietitle)
ORDER BY name;
--4
SELECT starname, networth, title 
FROM starsin inner JOIN movie ON (movietitle = title) inner JOIN movieexec ON (producerc# = cert#)
WHERE networth >= ALL(SELECT networth
                      FROM movieexec);
--5
SELECT name, movietitle
FROM moviestar LEFT JOIN starsin ON (name = starname)
WHERE movietitle IS NULL;

/* II. За базата от данни PC */
USE pc
--1 
SELECT product.maker, product.model, product.type
FROM product LEFT JOIN pc ON (pc.model=product.model) LEFT JOIN laptop ON (laptop.model=product.model) LEFT JOIN printer ON (printer.model=product.model)
WHERE printer.code IS NULL AND laptop.code IS NULL AND pc.code IS NULL;
--2 - 1ви начин
SELECT DISTINCT maker
FROM product inner JOIN printer ON (product.model = printer.model) 
WHERE maker IN (SELECT maker
                FROM product 
				WHERE type LIKE 'laptop');
--2 - 2ри начин
SELECT DISTINCT maker
FROM product inner JOIN printer ON (product.model = printer.model) 
WHERE maker IN (SELECT maker
                FROM product inner JOIN laptop ON (product.model = laptop.model));
--2 - 3ти начин
SELECT maker
FROM product inner JOIN printer ON (product.model = printer.model) 
INTERSECT
SELECT maker
FROM product inner JOIN laptop ON (product.model = laptop.model);
--3
SELECT DISTINCT l1.hd
FROM laptop AS l1 inner JOIN laptop AS l2 ON (l1.hd = l2.hd)
WHERE l1.model != l2.model;
--4
SELECT pc.model
FROM pc LEFT JOIN product ON (pc.model = product.model)
WHERE product.maker IS NULL;

/* III. За базата от данни SHIPS */
USE ships
--1 - 1ви начин:
SELECT ships.name, ships.class, ships.launched, classes.class, classes.type, classes.country, classes.numguns, classes.bore, classes.displacement
FROM ships RIGHT JOIN classes ON (ships.class = classes.class)
WHERE ships.name IS NOT NULL;
--1 - 2ри начин:
SELECT *
FROM classes inner JOIN ships ON (ships.class = classes.class);
--2 - 1ви начин:
SELECT ships.name, ships.class, ships.launched, classes.class, classes.type, classes.country, classes.numguns, classes.bore, classes.displacement
FROM ships RIGHT JOIN classes ON (ships.class = classes.class)
WHERE ships.name IS NOT NULL
UNION
SELECT ships.name, ships.class, ships.launched, classes.class, classes.type, classes.country, classes.numguns, classes.bore, classes.displacement
FROM ships RIGHT JOIN classes ON (ships.class = classes.class)
WHERE ships.name IS NULL AND classes.class IN (SELECT name
                                               FROM ships);
--2 - 2ри начин:
SELECT ships.name, ships.class, ships.launched, classes.class, classes.type, classes.country, classes.numguns, classes.bore, classes.displacement
FROM ships RIGHT JOIN classes ON (ships.class = classes.class);
--3 - 1ви начин:
SELECT classes.country, ships.name
FROM classes FULL JOIN ships ON (classes.class = ships.class) FULL JOIN outcomes ON (ships.name = outcomes.ship)
WHERE battle IS NULL AND ships.name IS NOT NULL;
--3 - 2ри начин:
SELECT classes.country, ships.name
FROM classes inner JOIN ships ON (classes.class = ships.class) LEFT JOIN outcomes ON (ships.name = outcomes.ship)
WHERE battle IS NULL;
--4
SELECT ships.name AS 'Ship Name'
FROM ships inner JOIN classes ON (ships.class = classes.class)
WHERE numguns >=7 AND launched = 1916;
--5
SELECT outcomes.ship, battles.name AS 'battle', battles.date
FROM outcomes inner JOIN battles ON (outcomes.battle = battles.name)
WHERE result LIKE 'sunk'
ORDER BY battles.name;
--6
SELECT ships.name, classes.displacement, ships.launched
FROM ships inner JOIN CLASSES ON (ships.class = classes.class)
WHERE ships.name = ships.class;
--7
SELECT classes.*
FROM classes LEFT JOIN ships ON (classes.class = ships.class)
WHERE launched IS NULL;
--8
SELECT ships.name, classes.displacement, classes.numguns, outcomes.result
FROM ships inner JOIN classes ON (ships.class = classes.class) inner JOIN outcomes ON (ships.name = outcomes.ship)
WHERE outcomes.battle LIKE 'North Atlantic';
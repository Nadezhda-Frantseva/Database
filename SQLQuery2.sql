/* Заявки в SQL върху две и повече релации - задачи: */
/* I.За базата от данни Movies */
--1
USE movies
(SELECT NAME
FROM MOVIESTAR
WHERE GENDER LIKE 'M')
INTERSECT
(SELECT STARNAME
FROM STARSIN
WHERE MOVIETITLE LIKE 'The Usual Suspects'
);
--2
USE movies
SELECT DISTINCT STARNAME
FROM STARSIN JOIN MOVIE ON (MOVIETITLE = TITLE)
WHERE MOVIEYEAR = 1995 AND STUDIONAME LIKE 'MGM';
--3
USE movies
SELECT DISTINCT NAME
FROM MOVIEEXEC JOIN MOVIE ON (CERT# = PRODUCERC#)
WHERE STUDIONAME LIKE 'MGM';
--4
USE movies
SELECT movie1.TITLE
FROM MOVIE AS movie1 JOIN MOVIE AS movie2 ON (movie1.LENGTH > movie2.LENGTH)
WHERE movie2.TITLE LIKE 'Star Wars';
--5
USE movies
SELECT EX1.NAME
FROM MOVIEEXEC AS EX1 JOIN MOVIEEXEC AS EX2 ON (EX1.NETWORTH > EX2.NETWORTH)
WHERE EX2.NAME = 'Stephen Spielberg';
--6
USE movies
SELECT movie.title
FROM MOVIEEXEC AS EX1 JOIN MOVIEEXEC AS EX2 ON (EX1.NETWORTH > EX2.NETWORTH) JOIN MOVIE ON (MOVIE.PRODUCERC# = EX1.CERT#)
WHERE EX2.NAME = 'Stephen Spielberg';

/* II.За базата от данни PC */
--1 
USE pc
SELECT DISTINCT maker, speed
FROM product JOIN laptop ON (product.model = laptop.model)
WHERE product.type = 'Laptop' AND hd>=9;
--2
USE pc
(SELECT DISTINCT product.model, pc.price
FROM product JOIN pc ON (product.model = pc.model)
WHERE maker LIKE 'B' AND product.type LIKE 'PC')
UNION
(SELECT DISTINCT product.model, laptop.price
FROM product JOIN laptop ON (product.model = laptop.model)
WHERE maker LIKE 'B' AND product.type LIKE 'Laptop')
UNION
(SELECT DISTINCT product.model, printer.price 
FROM product JOIN printer ON (product.model = printer.model)
WHERE maker LIKE 'B' AND product.type LIKE 'Printer');
--3
USE pc
(SELECT maker
FROM product
WHERE type LIKE 'Laptop')
EXCEPT
(SELECT maker
FROM product
WHERE type LIKE 'PC');
--4 
USE pc
SELECT DISTINCT pc1.hd
FROM pc AS pc1 JOIN pc AS pc2 ON (pc1.hd = pc2.hd)
WHERE pc1.code != pc2.code;
--5
USE pc
SELECT DISTINCT pc1.model, pc2.model
FROM pc AS pc1 JOIN pc AS pc2 ON (pc1.speed = pc2.speed AND pc1.ram = pc2.ram AND pc1.model != pc2.model AND pc1.model < pc2.model);
--6
USE pc
SELECT DISTINCT product.maker
FROM product JOIN pc AS pc1 ON (product.model = pc1.model) JOIN pc AS pc2 ON (product.model = pc2.model)
WHERE product.type = 'PC' AND pc1.code != pc2.code AND pc1.speed > 400 AND pc2.speed > 400;

/* III.За базата от данни SHIPS */
--1
USE ships
SELECT NAME
FROM SHIPS JOIN CLASSES ON (SHIPS.CLASS = CLASSES.CLASS)
WHERE CLASSES.DISPLACEMENT > 50000;
--2 
USE ships
SELECT SHIPS.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS
FROM SHIPS JOIN OUTCOMES ON (SHIPS.NAME = OUTCOMES.SHIP) JOIN CLASSES ON (SHIPS.CLASS = CLASSES.CLASS)
WHERE OUTCOMES.BATTLE LIKE 'Guadalcana%';
--3
USE ships
(SELECT country
FROM CLASSES 
WHERE TYPE = 'bb')
INTERSECT
(SELECT country
FROM CLASSES 
WHERE TYPE = 'bc');
--4
USE ships
(SELECT ship
FROM OUTCOMES
WHERE RESULT = 'damaged')
INTERSECT
((SELECT ship
FROM OUTCOMES
WHERE RESULT = 'sunk')
UNION 
(SELECT ship
FROM OUTCOMES
WHERE RESULT = 'ok'));






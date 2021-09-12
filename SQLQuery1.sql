/* Прости заявки - задачи: */
/* I.За базата от данни Movies */
--1
use movies;
select ADDRESS
from STUDIO
where NAME LIKE 'Disney';
--2
USE movies
SELECT BIRTHDATE
FROM MOVIESTAR
WHERE NAME LIKE 'Jack Nicholson';
--3
USE movies
SELECT STARNAME
FROM STARSIN
WHERE MOVIEYEAR LIKE 1980 OR MOVIETITLE LIKE '%Knight%';
--4
USE movies
SELECT NAME 
FROM MOVIEEXEC
WHERE NETWORTH > 10000;
--5
USE movies
SELECT NAME
FROM MOVIESTAR
WHERE GENDER LIKE 'M' OR ADDRESS LIKE 'Perfect Rd';

/* II.За базата от данни PC */
--1
USE pc
SELECT model, speed AS MHz, hd AS GB
FROM pc
WHERE price < 1200;
--2 
USE pc
SELECT DISTINCT maker
FROM product
WHERE type LIKE 'printer';
--3
USE pc
SELECT model,ram,screen
FROM laptop
WHERE price > 1000;
--4
USE pc
SELECT *
FROM printer
WHERE color LIKE 'y';
--5
USE pc
SELECT model, speed, hd
FROM pc
WHERE cd LIKE '12x' OR cd LIKE '16x' AND price < 2000;

/* III.За базата от данни SHIPS */
--1
USE ships
SELECT CLASS, COUNTRY
FROM CLASSES
WHERE NUMGUNS < 10;
--2
USE ships
SELECT NAME AS 'shipName'
FROM SHIPS
WHERE LAUNCHED < 1918;
--3
USE ships
SELECT SHIP, BATTLE 
FROM OUTCOMES
WHERE RESULT LIKE 'sunk';
--4
USE ships
SELECT NAME
FROM SHIPS
WHERE NAME LIKE CLASS;
--5
USE ships
SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';
--6
USE ships
SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %';

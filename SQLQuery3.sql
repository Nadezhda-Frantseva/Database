/* Подзаявки - задачи: */
/* I.За базата от данни Movies */
--1
USE movies
SELECT name 
FROM moviestar
WHERE moviestar.name IN (SELECT name 
                         FROM movieexec
			             WHERE networth > 10000000);
--2
USE movies
SELECT name
FROM moviestar
WHERE name NOT IN (SELECT name 
                   FROM movieexec);
--3
USE movies
SELECT title
FROM movie
WHERE length > (SELECT length
                FROM movie 
				WHERE title LIKE 'Star Wars');
--4
USE movies
SELECT movie.title, movieexec.name
FROM movie JOIN movieexec ON (cert#=producerc#)
WHERE networth > (SELECT networth
                  FROM movieexec
				  WHERE name LIKE 'Merv Griffin');

/* II.За базата от данни PC */
--1
USE pc
SELECT DISTINCT maker 
FROM product p, (SELECT model
                 FROM pc
				 WHERE pc.speed > 500) t
WHERE p.model = t.model; 
--2 
USE pc
SELECT DISTINCT code, model, price
FROM printer
WHERE price >= ALL(SELECT price
                   FROM printer);
--3
USE pc
SELECT DISTINCT *
FROM laptop
WHERE speed < ALL(SELECT speed
				  FROM pc);
--4 
USE pc
SELECT model, price
FROM pc
WHERE price >= ALL((SELECT price 
				   FROM pc)
				   UNION
				   (SELECT price 
				   FROM laptop)
				   UNION 
				   (SELECT price 
				   FROM printer))
UNION 
SELECT model, price
FROM printer
WHERE price >= ALL((SELECT price 
				   FROM pc)
				   UNION
				   (SELECT price 
				   FROM laptop)
				   UNION 
				   (SELECT price 
				   FROM printer))
UNION
SELECT model, price
FROM laptop
WHERE price >= ALL((SELECT price 
				   FROM pc)
				   UNION
				   (SELECT price 
				   FROM laptop)
				   UNION 
				   (SELECT price 
				   FROM printer));
--5 
USE pc
SELECT maker
FROM product 
WHERE model IN (SELECT model 
                FROM printer
				WHERE color = 'y' AND price <= ALL (SELECT price
										            FROM printer
												    WHERE color = 'y'));
--6 -  да си прегледам пак !
USE pc
SELECT maker
FROM product 
WHERE model IN (SELECT model
				FROM (SELECT *
				      FROM pc
					  WHERE ram <= ALL (SELECT ram FROM pc))pc2 
				WHERE speed >= ALL (SELECT speed
									   FROM (SELECT *
										     FROM pc AS pc3
									         WHERE ram <= ALL (SELECT ram FROM pc))pc3));
/* III.За базата от данни SHIPS */
USE ships
--1
SELECT DISTINCT country
FROM classes
WHERE numguns >= ALL( SELECT numguns 
					  FROM classes);
--2
SELECT DISTINCT class
FROM ships s, (SELECT ship 
			   FROM outcomes
			   WHERE result LIKE 'sunk') t
WHERE s.name = t.ship;
--3
SELECT DISTINCT name, s.class
FROM ships s,(SELECT class
			  FROM classes
			  WHERE bore = 16) t
WHERE s.class = t.class;
--4
SELECT battle
FROM outcomes o, (SELECT name 
				  FROM ships 
				  WHERE class LIKE 'Kongo')t
WHERE o.ship = t.name;
--5
SELECT class, name
FROM ships
WHERE class IN (SELECT class 
				FROM classes c
				WHERE numguns >= ALL (SELECT numguns 
									  FROM classes 
									  WHERE bore = c.bore));
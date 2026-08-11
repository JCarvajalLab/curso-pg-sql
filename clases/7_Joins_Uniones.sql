--Combinar 2 tablas con UNION
SELECT * FROM continent WHERE name LIKE '%America'
UNION
SELECT * FROM continent WHERE code IN (3,5)
ORDER BY name ASC

-- NO SE RECOMIENDA WHERE
SELECT a.name AS Country, b.name AS Continent FROM country a, continent b
WHERE a.continent = b.code
ORDER BY b.name ASC
-- SE RECOMIENDA INNER JOIN
SELECT a.name AS country, b.name AS continent FROM country a
INNER JOIN continent b ON a.continent = b.code
ORDER BY a.name ASC
-- EN CASO DE QUE LOS REGISTROS ESTEN CON PROBLEMAS DE SECUENCIA EJ 8 - 15-16-17 (CON EL RESET 8-9-10)
ALTER SEQUENCE 'continent_code_seq' RESTART WITH 8;
-- combinar 2 tablas
SELECT a.name as country, a.continent as continentCode, b.name as continentName FROM country a
FULL OUTER JOIN continent b
ON a.continent = b.code
-- ORDER BY a.name DESC

--Listado de todos los continentes que no tienen registro en tabla paises
SELECT 
	a.name as country,
	a.continent as continentCode, 
	b.name as continentName 
FROM country a
	RIGHT JOIN continent b
	ON a.continent = b.code
	WHERE a.continent IS NULL

--EJERCICIO PRACTICO
SELECT COUNT(*), continent, name FROM country
GROUP BY continent
ORDER BY continent ASC
--	EN VEZ DE MOSTRAR LOS NUMEROS, MOSTRAR NOMBRES CON UN INNER JOIN
SELECT COUNT(*), b.name as NombreContinente FROM country a
INNER JOIN continent b ON a.continent= b.code
GROUP BY b.name
ORDER BY COUNT(*) ASC
-- 
SELECT COUNT(*), b.name as NombreContinente FROM country a
FULL OUTER JOIN continent b ON a.continent= b.code
GROUP BY b.name
ORDER BY COUNT(*) ASC
--
SELECT COUNT(*), b.name as NombreContinente FROM country a
FULL OUTER JOIN continent b ON a.continent= b.code
GROUP BY b.name
UNION
SELECT 0, b.name as NombreContinente FROM country a
RIGHT JOIN continent b ON a.continent= b.code
WHERE a.continent IS NULL
GROUP BY b.name
--
(SELECT COUNT(*) AS count, b.name as NombreContinente FROM country a
FULL OUTER JOIN continent b ON a.continent= b.code
GROUP BY b.name)
UNION
(SELECT 0 as count, b.name as NombreContinente FROM country a
RIGHT JOIN continent b ON a.continent= b.code
WHERE a.continent IS NULL
GROUP BY b.name)
ORDER BY count
-- 
-- Ejercicio practico
-- MOSTRAR PAIS CON MAS CIUDADES 
-- CAMPOS: TOTAL DE CIUDADES Y EL NOMBRE DEL PAIS
-- USAR INNER JOIN 

SELECT COUNT(*) AS total, b.name AS country FROM city a
INNER JOIN country b ON a.countrycode = b.code
GROUP BY b.name
ORDER BY COUNT(*) DESC
LIMIT 1

-- QUE IDIOMA OFICIAL HABLAN POR CONTINENTE

SELECT DISTINCT a."language", c."name" AS continente FROM countrylanguage a
INNER JOIN country b ON a.countrycode = b.code
INNER JOIN continent c ON b.continent = c.code
WHERE a.isofficial = TRUE;

-- CUANTOS IDIOMAS SE HABLAN POR CONTINENTE

SELECT COUNT(*), continent FROM (
	SELECT DISTINCT a."language", c."name" AS continent FROM countrylanguage a
	INNER JOIN country b ON a.countrycode = b.code
	INNER JOIN continent c ON b.continent = c.code
	WHERE a.isofficial = TRUE
) AS totales
GROUP BY continent
--

SELECT DISTINCT d.name , c."name" AS continent FROM countrylanguage a
	INNER JOIN country b ON a.countrycode = b.code
	INNER JOIN continent c ON b.continent = c.code
	INNER JOIN "language" d ON d.code = a.languagecode
	WHERE a.isofficial = TRUE
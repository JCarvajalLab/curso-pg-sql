-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa

-- Opcion1
(SELECT COUNT(*) AS total, b.name FROM country a
INNER JOIN continent b ON a.continent = b.code
WHERE b.name NOT LIKE '%America%'
GROUP BY b.name)
UNION
(SELECT COUNT(*) AS total, 'America' FROM country a
INNER JOIN continent b ON a.continent = b.code
WHERE b."name" LIKE '%America%')
ORDER BY total ASC
-- Opcion2
(SELECT COUNT(*) AS total, b.name FROM country a
INNER JOIN continent b ON a.continent = b.code
WHERE b.code IN (1,2,3,5,7,9,10,11)
GROUP BY b.name)
UNION
(SELECT COUNT(*) AS total, 'America' FROM country a
INNER JOIN continent b ON a.continent = b.code
WHERE b.code IN (4,6,8))
ORDER BY total ASC
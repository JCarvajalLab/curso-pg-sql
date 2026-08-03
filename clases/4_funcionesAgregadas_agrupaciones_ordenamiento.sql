-- 
SELECT * FROM users;

-- FILTRAR 3 TABLAS DE LAS CUALES FOLLOWERS ESTE ENTRE 4600/4700 ORDENADAS DE FORMA DECENDENTE
SELECT first_name, last_name, followers FROM users
WHERE followers> 4600 AND followers < 4700
ORDER BY followers DESC
-- LO MISMO PERO CON BETWEEN
SELECT first_name, last_name, followers FROM users
WHERE followers BETWEEN 4600 AND 4700
ORDER BY followers DESC

-- CANTIDAD DE USUARIOS
SELECT COUNT(*) FROM users;
SELECT COUNT(*) AS Total_Usuarios FROM users;
-- 
SELECT 
COUNT(*) AS Total_Usuarios, 
MIN(followers) AS Min_followers, 
MAX(followers) AS Max_followers,
ROUND(AVG(followers)) AS avg_followers 
FROM users;

-- 

SELECT first_name, last_name, followers FROM users
WHERE followers = 4 or followers = 4999;

--
SELECT COUNT(*), followers from users 
WHERE  followers = 4 or followers = 4999
GROUP BY followers;

--
SELECT COUNT(*), country
FROM users
GROUP BY country
ORDER BY country asc;

-- 
SELECT COUNT(*) AS total, country
FROM users
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY country asc;

-- Listado de paises

SELECT  DISTINCT country FROM users

-- 

SELECT email,
SUBSTRING (email, POSITION('@' IN email)+1) AS dominio 
from users
-- cuantos correos electronicos pertenecen a un dominio
SELECT COUNT(*), SUBSTRING (email, POSITION('@' IN email)+1) AS dominio
from users
GROUP BY dominio
HAVING count(*) > 1;
-- 
SELECT COUNT(*), SUBSTRING (email, POSITION('@' IN email)+1) AS dominio,
'Fernando' as name,
37 as age
from users
GROUP BY dominio
HAVING count(*) > 1;
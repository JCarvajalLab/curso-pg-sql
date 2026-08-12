-- Solo funciona en PostgreSQL
SELECT 'Fernando' AS nombre
SELECT (SELECT COUNT(*) FROM employees) AS nombre

-- RECORDAR
SELECT now(), CURRENT_DATE, CURRENT_TIME, CURRENT_USER, DATE_PART('minutes', now())

--
SELECT * FROM  employees
WHERE hire_date > '1998-02-05'
ORDER BY hire_date DESC
--EL empleado mas nuevo
SELECT MAX(hire_date) AS Mas_nuevo
FROM  employees
--El empleado mas antiguo
SELECT MIN(hire_date) AS Mas_antiguo
FROM  employees
--En un rango
SELECT  * FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2001-01-04'
ORDER BY hire_date DESC
-- Agregar un dia,mes, ano a la fecha
SELECT 
	MAX(hire_date),
	MAX(hire_date) + INTERVAL '1 day' AS UnDia,
	MAX(hire_date) + INTERVAL '1 month' AS UnMes,
	MAX(hire_date) + INTERVAL '1 years' AS UnANO,
    MAX(hire_date) + INTERVAL '1 years'+  INTERVAL '1 Day' AS years
    date_part('year', now())
from employees
-- Sumar 23ANOS
SELECT 
    MAX(hire_date) + INTERVAL '1 years'+  INTERVAL '1 Day' AS years,
    date_part('year', now()),
    MAKE_INTERVAL(YEARS := date_part('year', now())::INTEGER),
    MAX(hire_date) + MAKE_INTERVAL(YEARS := 23)
from employees

--Cantidad de anos trabajados a la fecha
SELECT hire_date,
-- Manual
	MAKE_INTERVAL(YEARS := 2026 - EXTRACT(YEARS FROM hire_date)::INTEGER) AS manual,
-- Programado
	MAKE_INTERVAL(YEARS := date_part('years', CURRENT_DATE)::INTEGER - EXTRACT(YEARS FROM hire_date)::INTEGER) AS programado
FROM employees
ORDER BY hire_date DESC

--
--
SELECT hire_date
FROM employees
ORDER BY hire_date DESC
-- Actualizar tabla y sumarle la cantidad de anos actuales
UPDATE employees
SET hire_date = hire_date + INTERVAL '26 years'

--
SELECT 
	first_name,
	last_name,
	hire_date,
	CASE
		WHEN hire_date > now() - INTERVAL '1 year' THEN '1 ano o menos'
		WHEN hire_date > now() - INTERVAL '3 year' THEN '1 a 3 anos'
		WHEN hire_date > now() - INTERVAL '6 year' THEN '3 a 6 anos'
		ELSE 'mas de 6 anos'
	END AS rango_antiguedad
FROM employees
ORDER BY hire_date DESC

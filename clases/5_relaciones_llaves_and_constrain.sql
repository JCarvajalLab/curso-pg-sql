SELECT * FROM country;

-- modificar tabla y anadir un primary key
ALTER TABLE country
ADD PRIMARY KEY(code);
--
SELECT * FROM country
WHERE code = 'NLD'
-- Borrar tabla duplicada
DELETE FROM country
WHERE code = 'NLD'
AND code2 = 'NA'
-- Agregar restriccion a tabla 
ALTER TABLE country 
ADD CHECK (surfacearea >= 0)
-- Agregar restriccion, que solo puedan ser una de esas countrys y no ejemplo asia2
SELECT DISTINCT continent
FROM country

ALTER TABLE country
ADD CHECK (
    (continent = 'Asia'::text) OR
    (continent = 'South America'::text) OR
    (continent = 'North America'::text) OR
    (continent = 'Oceania'::text) OR
    (continent = 'Antarctica'::text) OR
    (continent = 'Africa'::text) OR
    (continent = 'Central America'::text) OR
    (continent = 'Europe'::text));


-- ELIMINAR UNA RESTRICCION DE UNA TABLA (SE BUSCA CON EL CODE LINEA 36)
ALTER TABLE  country 
DROP CONSTRAINT "country_continent_check";

-- VERIFIFCAR LAS RESTRICCIONES CREADAS [CHECK][INDEX]
SELECT
    conname,
    pg_get_constraintdef(oid)
FROM pg_constraint
WHERE contype = 'c';

-- CREAR INDICE QUE ES UN CONSTRAIN

CREATE UNIQUE INDEX "unique_country_name" ON country(
    name
)

-- 

SELECT * FROM country WHERE  continent = 'Africa';

CREATE INDEX "unique_continent" ON country(
    continent
)
-- CREAR UN INDICE UNICO

CREATE UNIQUE INDEX "unique_name_countrycode_district" ON city(
    name, countrycode, district
)

CREATE INDEX "index_district" ON city(
   district
)


-- 


INSERT INTO country
		values('AFG', 'Afghanistan', 'Asia', 'Southern Asia', 652860, 1919, 40000000, 62, 69000000, NULL, 'Afghanistan', 'Totalitarian', NULL, NULL, 'AF');

ALTER TABLE city
ADD CONSTRAINT fk_country_code
FOREIGN KEY (countrycode)
REFERENCES country(code)

--

ALTER TABLE countrylanguage
ADD CONSTRAINT fk_country_code
FOREIGN KEY (countrycode)
REFERENCES country(code)


-- Borrar en cascada 

DELETE FROM country 
WHERE code = 'AFG';

SELECT * FROM city
WHERE countrycode = 'AFG';

SELECT * FROM country 
WHERE code = 'AFG';

SELECT * FROM countrylanguage
WHERE countrycode = 'AFG';
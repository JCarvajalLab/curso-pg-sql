--Buscar continentes ordenados acendente
SELECT DISTINCT continent
FROM country
ORDER BY continent ASC
-- INSERTAR los continentes de una tabla a otra (columna)
INSERT INTO continent(name)
SELECT DISTINCT continent FROM country
ORDER BY continent ASC

--Crear una tabla de back en caso necesitar un rollback
CREATE TABLE "public"."country_back" (
    "code" bpchar(3) NOT NULL,
    "name" text NOT NULL,
    "continent" text NOT NULL,
    "region" text NOT NULL,
    "surfacearea" float4 NOT NULL,
    "indepyear" int2,
    "population" int4 NOT NULL,
    "lifeexpectancy" float4,
    "gnp" numeric(10,2),
    "gnpold" numeric(10,2),
    "localname" text NOT NULL,
    "governmentform" text NOT NULL,
    "headofstate" text,
    "capital" int4,
    "code2" bpchar(2) NOT NULL,
    PRIMARY KEY ("code")
);
-- Copiar los datos de una tabla a otra tabla
INSERT INTO country_back
SELECT * FROM country

-- Validar todos los CHECK / INDEX creados
SELECT
    conname,
    pg_get_constraintdef(oid)
FROM pg_constraint
WHERE contype = 'c';

--Eliminar un ckeck( constraint ) de una tabla
ALTER TABLE country
DROP CONSTRAINT country_continent_check;

--  CONTINENTE APAREZCA COMO NUMERO Y NO CON EL NOMBRE
SELECT a.name, a.continent,
(SELECT "code" FROM continent b WHERE b.name = a.continent)
FROM country a
--
UPDATE country a
SET continent = (SELECT "code" FROM continent b WHERE b.name = a.continent)

-- CAMBIAR EL TIPO DE DATOS DE UN DATA_TYPE Y FORZARLA

ALTER TABLE country
ALTER COLUMN continent TYPE int4
USING continent::integer
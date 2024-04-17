-- Parte I - Consultas

-- Listar el nombre de la ciudad y el nombre del país de todas las ciudades que pertenezcan
-- a países con una población menor a 10000 habitantes.
SELECT c.name, country.Name, c.Population
FROM city as c
INNER JOIN country ON c.CountryCode = country.Code 
WHERE c.Population < 10000;
-- Listar todas aquellas ciudades cuya población sea mayor que la población promedio entre
-- todas las ciudades.
SELECT c.Name
FROM city as c
WHERE c.Population > (SELECT AVG(Population) FROM city);

-- es lo mismo que 
-- SELECT c.Name
-- FROM city as c
-- WHERE c.Population > SOME (SELECT AVG(Population) FROM city)

-- Listar todas aquellas ciudades no asiáticas cuya población sea igual o mayor a la
-- población total de algún país de Asia.

WITH 
  countriesPopulations AS (
    SELECT country.Population
    FROM country 
    WHERE country.Continent = 'Asia'
  )
SELECT c.Name
FROM city as c
INNER JOIN country ON c.CountryCode = country.Code
WHERE  country.Continent <> 'Asia' AND c.Population > SOME (SELECT * FROM countriesPopulations);

-- sin with
-- SELECT c.Name, c.Population
-- FROM city as c
-- INNER JOIN country ON c.CountryCode = country.Code
-- WHERE  country.Continent <> 'Asia' AND c.Population > SOME
--   (
--   SELECT country.Population
--   FROM country 
--   WHERE country.Continent = 'Asia'
--   );

-- Listar aquellos países junto a sus idiomas no oficiales, que superen en porcentaje
-- de hablantes a cada uno de los idiomas oficiales del país.

WITH
  percentageOfficialSpeakers AS (
    SELECT cl.Percentage, cl.CountryCode
    FROM countrylanguage as cl
    INNER JOIN country as c ON c.Code = cl.CountryCode
    WHERE cl.IsOfficial = 'T'
  )
SELECT c.Name, cl.Language
FROM country as c
INNER JOIN countrylanguage as cl ON cl.CountryCode = c.Code
WHERE cl.IsOfficial = 'F' AND cl.Percentage > ALL (
  SELECT percentageOfficialSpeakers.Percentage
  FROM percentageOfficialSpeakers
  WHERE c.Code = percentageOfficialSpeakers.CountryCode
);

-- Listar (sin duplicados) aquellas regiones que tengan países con una superficie
-- menor a 1000 km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes.
-- (Hint: Esto puede resolverse con o sin una subquery, intenten encontrar ambas respuestas).

WITH
  countriesWithCityOverHabitants AS (
    SELECT DISTINCT c.Code
    FROM country as c
    INNER JOIN city as ci ON c.Code = ci.CountryCode
    WHERE ci.Population > 100000
  )
SELECT DISTINCT c.Region
FROM country as c
WHERE c.SurfaceArea < 1000 AND c.Code IN (
  SELECT *
  FROM countriesWithCityOverHabitants
);
-----------------------------------------------------
WITH
  countriesWithCityOverHabitants AS (
    SELECT c.Region, c.Name as country, ci.Name as city, ci.Population, c.SurfaceArea
    FROM country as c
    INNER JOIN city as ci ON c.Code = ci.CountryCode
    WHERE ci.Population > 100000
  )
SELECT DISTINCT countriesModed.Region
FROM countriesWithCityOverHabitants AS countriesModed
WHERE countriesModed.SurfaceArea < 1000 AND EXISTS (
  SELECT *
  FROM countriesWithCityOverHabitants
);
------------------------------------------------------------------------------------
SELECT c.Region
FROM country as c
INNER JOIN city as ci ON ci.CountryCode = c.Code
WHERE c.SurfaceArea < 1000 AND ci.Population > 100000;

-- Listar el nombre de cada país con la cantidad de habitantes de su ciudad más poblada.
-- (Hint: Hay dos maneras de llegar al mismo resultado. Usando consultas escalares o usando
-- agrupaciones, encontrar ambas).
SELECT c.Name as country, (
  SELECT max(ci.Population) as Population 
  FROM city as ci 
  WHERE c.Code = ci.CountryCode
) as Population
FROM country AS c;
------------------------------------------------------------------------------------
-- Esta no tiene filas con poblacion nula
SELECT c.Name, max(ci.Population) as Population
FROM country as c
INNER JOIN city as ci ON ci.CountryCode = c.Code 
GROUP BY c.Name;
-- Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes sea
-- mayor al promedio de hablantes de los lenguajes oficiales.

SELECT c.Name, cl.Language, cl.Percentage 
FROM country as c
INNER JOIN countrylanguage as cl ON cl.CountryCode = c.Code
WHERE cl.IsOfficial = 'F' AND cl.Percentage > (
  SELECT AVG(cl.Percentage) AS avg_Percentage
  FROM countrylanguage as cl 
  WHERE cl.IsOfficial = 'T' AND cl.CountryCode = c.Code
)
-- Listar la cantidad de habitantes por continente ordenado en forma descendente.

-- Listar el promedio de esperanza de vida (LifeExpectancy) por continente con una
-- esperanza de vida entre 40 y 70 años.

-- Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.


-- Parte II - Preguntas

-- Si en la consulta 6 se quisiera devolver, además de las columnas ya solicitadas,
-- el nombre de la ciudad más poblada. ¿Podría lograrse con agrupaciones?
-- ¿y con una subquery escalar?


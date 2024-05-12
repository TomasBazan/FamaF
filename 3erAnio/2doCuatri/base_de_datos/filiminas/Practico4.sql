-- Ejercicio 1
-- Listar el nombre de la ciudad y el nombre del país de todas las ciudades 
-- que pertenezcan a países con una población menor a 10000 habitantes.

SELECT city.Name, country.Name, city.Population
FROM city
INNER JOIN country ON country.Code = city.CountryCode
WHERE city.Population < 10000;
-- Ejercicio 2
-- Listar todas aquellas ciudades cuya población sea mayor que la población 
-- promedio entre todas las ciudades.
WITH prom(value) AS (SELECT avg(city.Population) FROM city)
SELECT city.Name
FROM city, prom
WHERE city.Population > prom.value;

SELECT city.Name, city.Population
FROM city
WHERE city.Population > SOME (SELECT avg(city.Population) FROM city);
-- Ejercicio 3
-- Listar todas aquellas ciudades no asiáticas cuya población sea igual o 
-- mayor a la población total de algún país de Asia.

SELECT city.Name 
FROM city 
INNER JOIN country ON country.Code = city.CountryCode
WHERE country.Continent != 'Asia' AND 
    city.Population >= SOME (
        SELECT country.Population
        FROM country
        WHERE country.Continent = 'Asia'
    );
-- Ejercicio 4
-- Listar aquellos países junto a sus idiomas no oficiales, que superen en 
-- porcentaje de hablantes a cada uno de los idiomas oficiales del país.
SELECT c.Name AS Country, cl.Language
FROM country AS c
INNER JOIN countrylanguage cl ON cl.CountryCode = c.Code
WHERE cl.IsOfficial = 'F' AND cl.Percentage > ALL (
    SELECT cl.Percentage
    FROM countrylanguage AS cl
    WHERE cl.IsOfficial = 'T' AND c.
);

-- Ejercicio 5
-- Listar (sin duplicados) aquellas regiones que tengan países con una superficie 
-- menor a 1000 km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes. 
-- (Hint: Esto puede resolverse con o sin una subquery, intenten encontrar ambas respuestas).
SELECT DISTINCT country.Region
FROM country
WHERE country.SurfaceArea < 1000 AND country.Code IN (
    SELECT DISTINCT country.Code
    FROM country
    INNER JOIN city ON country.Code = city.CountryCode
    WHERE city.Population >= 100000
);

-- MILI 

SELECT DISTINCT citiesPopulation.Region
FROM (SELECT city.Name AS city, 
            country.SurfaceArea,
             city.Population,
             country.Region
      FROM country JOIN city 
      ON country.Code = city.CountryCode
      WHERE city.Population >= 100000 )
      AS citiesPopulation
WHERE citiesPopulation.SurfaceArea < 1000;
-- CHAT
SELECT DISTINCT Region
FROM country
WHERE SurfaceArea < 1000 AND Code IN (
    SELECT DISTINCT CountryCode
    FROM city
    WHERE Population > 100000
);







-- Ejercicio 6
-- Listar el nombre de cada país con la cantidad de habitantes de su ciudad más poblada. 
-- (Hint: Hay dos maneras de llegar al mismo resultado. Usando consultas escalares o usando 
-- agrupaciones, encontrar ambas).

-- Ejercicio 7
-- Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes sea 
-- mayor al promedio de hablantes de los lenguajes oficiales.

-- Ejercicio 8
-- Listar la cantidad de habitantes por continente ordenado en forma descendente.

-- Ejercicio 9
-- Listar el promedio de esperanza de vida (LifeExpectancy) por continente con una 
-- esperanza de vida entre 40 y 70 años.

-- Ejercicio 10
-- Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.

-- Parte I - Consultas
-- 1. Lista el nombre de la ciudad, nombre del país, región y forma de gobierno
-- de las 10 ciudades más pobladas del mundo.
SELECT city.Name, country.Name, country.Region, country.GovernmentForm, city.Population
FROM country
INNER JOIN city ON city.CountryCode = country.Code
ORDER BY city.Population DESC
LIMIT 10;
-- 2. Listar los 10 países con menor población del mundo, junto a sus ciudades
-- capitales (Hint: puede que uno de estos países no tenga ciudad capital asignada,
-- en este caso deberá mostrar "NULL").
SELECT country.Name, country.Population, city.Name
FROM country
LEFT JOIN city ON city.CountryCode = country.Code 
WHERE city.ID = country.capital
ORDER BY country.Population
LIMIT 10;
-- 3. Listar el nombre, continente y todos los lenguajes oficiales de cada país.
-- (Hint: habrá más de una fila por país si tiene varios idiomas oficiales).
SELECT country.Name, country.Continent, countrylanguage.Language, countrylanguage.IsOfficial
FROM country
RIGHT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code 
WHERE IsOfficial = 'T';
-- 4. Listar el nombre del país y nombre de capital, de los 20 países con mayor
-- superficie del mundo.

SELECT country.Name, city.Name, country.SurfaceArea
FROM country
INNER JOIN city ON city.CountryCode = country.Code
WHERE city.ID = country.Capital
ORDER BY country.SurfaceArea DESC
LIMIT 20;
-- 5. Listar las ciudades junto a sus idiomas oficiales (ordenado por la población
-- de la ciudad) y el porcentaje de hablantes del idioma.

SELECT city.Name, countrylanguage.Language, city.Population, countrylanguage.Percentage
FROM city
RIGHT JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE countrylanguage.IsOfficial = 'T'
ORDER BY city.Population AND countrylanguage.Percentage;
-- 6. Listar los 10 países con mayor población y los 10 países con menor población
-- (que tengan al menos 100 habitantes) en la misma consulta.

(
SELECT country.Name, country.Population
FROM country
WHERE country.Population >= 100
ORDER BY country.Population
LIMIT 10
)
UNION
(
SELECT country.Name, country.Population
FROM country
ORDER BY country.Population DESC
LIMIT 10
);
-- 7. Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés
-- (hint: no debería haber filas duplicadas).
SELECT DISTINCT country.Name
FROM country
INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Language = "English" OR countrylanguage.Language = "French";
-- 8. Listar aquellos países que tengan hablantes del Inglés pero no del Español
-- en su población.
(
SELECT country.Name
  FROM country
  INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
  WHERE countrylanguage.Language = "English"
)
EXCEPT
(
SELECT country.Name
  FROM country
  INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
  WHERE countrylanguage.Language = "Spanish"
);
-- Parte II - Preguntas
-- 1. ¿Devuelven los mismos valores las siguientes consultas? ¿Por qué? 
-- Devuelve lo mismo ya que la primera se encarga de hace el join en base a que 
-- el pais sea argentina, el otro no lo chequea pero luego cuando se ejecuta el WHERE
-- los filtra
-- SELECT city.Name, country.Name
-- FROM city
-- INNER JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina';
-- SELECT city.Name, country.Name
-- FROM city
-- INNER JOIN country ON city.CountryCode = country.Code
-- WHERE country.Name = 'Argentina';

-- 2. ¿Y si en vez de INNER JOIN fuera un LEFT JOIN?

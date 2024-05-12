use world;
# Lista el nombre de la ciudad, nombre del país, región 
# y forma de gobierno de las 10 ciudades más pobladas del mundo.

SELECT city.name ,country.Name, country.Region, country.GovernmentForm FROM country 
INNER JOIN city ON city.CountryCode = country.Code
ORDER BY country.Population DESC
LIMIT 10;


#Listar los 10 países con menor población del mundo, junto a sus 
#ciudades capitales (Hint: puede que uno de estos países no tenga
#ciudad capital asignada, en este caso deberá mostrar "NULL").

SELECT country.Name, city.name FROM country
LEFT JOIN city ON country.Capital = city.ID
ORDER BY country.Population 
LIMIT 10; 

#Listar las ciudades junto a sus idiomas oficiales (ordenado por
#la población de la ciudad) y el porcentaje de hablantes del idioma.

SELECT city.Name, countrylanguage.Lenguage FROM city 
RIGHT JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
ORDER BY city.Population, countrylanguage.Percentage;

#Listar los 10 países con mayor población y los 10 países con menor 
#población (que tengan al menos 100 habitantes) en la misma consulta.

(SELECT country.Name FROM country ORDER BY country.Population DESC LIMIT 10)
UNION
(SELECT country.Name FROM country WHERE country.Population >= 100 ORDER BY country.Population ASC LIMIT 10);

#Listar aquellos países cuyos lenguajes oficiales son el Inglés y
# el Francés (hint: no debería haber filas duplicadas).

SELECT country.Name FROM country
INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = 'T' AND (countrylanguage.Lenguage = 'French' OR countrylanguage.Lenguage = 'English');

#Listar aquellos países que tengan hablantes del Inglés pero no
# del Español en su población.

(SELECT country.Name FROM country
INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Lenguage = 'English')
EXCEPT
(SELECT country.Name FROM country
INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Lenguage = 'Spanish')

# Parte 2: 
#¿Devuelven los mismos valores las siguientes consultas? ¿Por qué? 
# Si devuelven los mismos valores, se devuelve aquellos valores pertenecientes a ambas tablas pero que cumplan las condiciones
# en particular where y ON con el uso de AND cumple la misma funcion
# SELECT city.Name, country.Name
# FROM city
# INNER JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina';
# 
# SELECT city.Name, country.Name
# FROM city
# INNER JOIN country ON city.CountryCode = country.Code
# WHERE country.Name = 'Argentina';

#¿Y si en vez de INNER JOIN fuera un LEFT JOIN?
# No devolveria los mismos resultados ya que LEFT JOIN fuerza a que la tabla 
# resultante tenga todos los valores de la tabla izquierda, cumpla o no las condiciones

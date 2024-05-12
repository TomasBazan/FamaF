-- Ejercicio 1
SELECT city.Name AS City, city.Population, country.Name AS Country, country.Region
FROM city 
INNER JOIN country ON city.CountryCode = country.Code
ORDER BY Population DESC LIMIT 10;

-- Ejercicio 2
SELECT country.Name AS Country, city.Name AS CapitalCity, city.Population
FROM country 
LEFT JOIN city ON country.Code = city.CountryCode
WHERE country.Capital = city.ID
ORDER BY city.Population ASC LIMIT 10;
-- Ejercicio 3
SELECT country.Name AS Country, country.Continent AS Continent, countrylanguage.Language 
FROM country 
LEFT JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.IsOfficial = 'T';

-- Ejercicio 4
SELECT country.Name AS Country, city.Name AS Capital 
FROM country 
INNER JOIN city ON country.Code = city.CountryCode
WHERE country.Capital = city.ID
ORDER BY country.SurfaceArea DESC LIMIT 20;

-- Ejercicio 5
SELECT city.Name AS City, countrylanguage.Language AS 'Official Language', countrylanguage.Percentage
FROM city 
INNER JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
ORDER BY city.Population DESC;

-- Ejercicio 6
(SELECT country.Name, country.Population FROM country ORDER BY country.Population DESC LIMIT 10)
UNION
(SELECT country.Name, country.Population FROM country ORDER BY country.Population ASC LIMIT 10);

-- Ejercicio 7
(
    SELECT country.Name
    FROM country 
    INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.Language = 'English' AND countrylanguage.IsOfficial = 'T'
)
INTERSECT
(
    SELECT country.Name
    FROM country 
    INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T'
)
INTERSECT
(
    SELECT country.Name
    FROM country 
    INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.IsOfficial='T'
);
-- Si hago select otra cosa ademas del nombre el intersect es por cada registro
-- es decir que voy a estar tratando de intersecar Canada Frances con Canada Ingles
-- Y por eso me daba como resultado un empty set

-- Ejercicio 8
(
    SELECT country.Name
    FROM country
    INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.Language = 'English'
)
EXCEPT
(
    SELECT country.Name
    FROM country 
    INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.Language = 'Spanish'
);


(
SELECT city.Name, country.Name
FROM city
LEFT JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina')
EXCEPT
(
SELECT city.Name, country.Name
FROM city
LEFT JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Argentina'
)




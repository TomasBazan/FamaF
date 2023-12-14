USE `world`;
-- Ejercicio 2
CREATE TABLE country (
    Code char(3) NOT NULL,
    Name varchar(55),
    Continent varchar(50),
    Region varchar(55),
    SurfaceArea decimal(10,2),
    IndepYear int,
    Population int,
    LifeExpectanc float,
    GNP decimal(10,2),
    GNPOld decimal(10,2),
    LocalName varchar(55),
    GovernmentForm varchar(100),
    HeadOfState varchar(60),
    Capital int,
    Code2 char(2),
    PRIMARY KEY(Code)
);

CREATE TABLE city (
    ID int NOT NULL,
    Name varchar(60) NOT NULL DEFAULT '' ,
    CountryCode char(3),
    District varchar(50),
    Population int,
    PRIMARY KEY (ID),
    CONSTRAINT city_country_fk FOREIGN KEY(CountryCode) REFERENCES country (Code)
);

CREATE TABLE countrylanguage (
    CountryCode char(3) NOT NULL,
    Language varchar(50) NOT NULL,
    IsOfficial enum('T','F'),
    Percentage decimal(4,1),
    PRIMARY KEY(CountryCode, Language),
    CONSTRAINT clenguage_country_fk FOREIGN KEY(CountryCode) REFERENCES country (Code)
);
-- Ejeercicio 4
CREATE TABLE continent (
    Name varchar(50),
    Area decimal(10,2),
    PercentTotalMass decimal(4,2),
    MostPopulousCity varchar(30),
    PRIMARY KEY (Name)
);


INSERT INTO city (ID, Name, CountryCode, District, Population)
VALUES(1111200, 'McMurdo Station', 'ATA', '', 1000);
-- Ejercicio 5
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Africa', 30370000, 24.4, 608);
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Antarctica', 14000000, 9.2, 4080);
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Asia',44579000 ,29.5 ,1024 );
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Europe', 10180000, 6.8, 3357);
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('North America', 24709000, 16.5, 2515);
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Oceania', 8600000 , 5.9, 130);
INSERT INTO continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('South America', 8600000, 12.0, 206);


-- Ejercicio 6
ALTER TABLE country ADD CONSTRAINT country_continent_fk FOREIGN KEY (Continent) REFERENCES continent(Name);
-- PARTE 2 CONSULTAS

-- Ejercicio 1
SELECT Name,Region
FROM country
ORDER BY Name ASC;

-- Ejercicio 2
SELECT Name, Population
FROM city
ORDER BY Population DESC
LIMIT 10;
-- Ejercicio 3
SELECT Name, Region, SurfaceArea, GovernmentForm  
FROM country
ORDER BY SurfaceArea ASC
LIMIT 10;

-- Ejercicio 4
SELECT Name, IndepYear
FROM country
WHERE IndepYear IS NOT NULL;

-- Ejercicio 5
SELECT Language, Percentage, CountryCode
FROM countrylanguage
WHERE IsOfficial = 'T';

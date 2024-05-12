CREATE TABLE country(
Code char(3) PRIMARY KEY,
Name varchar(50),
Continent varchar (50),
Region varchar (25),
SurfaceArea float,
IndepYear int,
Population int,
LifeExpectancy float,
GNP float,
GNPOld float,
LocalName varchar(30),
GovernmentForm varchar(70),
HeadOfState varchar(50),
Capital int,
Code2 char (2));

CREATE TABLE city(
ID INT PRIMARY KEY		,
Name varchar(20),
CountryCode CHAR(3),
District Varchar(50),
Population INT,
FOREIGN KEY (CountryCode) REFERENCES country(Code)
);

CREATE TABLE countrylanguage(
CountryCode CHAR(3),
Lenguage VARCHAR(40),
IsOfficial char(1),
Percentage FLOAT,
FOREIGN KEY(CountryCode) REFERENCES country(Code)
);

CREATE TABLE Continent(
Name VARCHAR(40) PRIMARY KEY,
Area INT,
PercentTotalMass FLOAT,
MostPopulousCity INT UNIQUE,
FOREIGN KEY(MostPopulousCity) REFERENCES city(ID)
);

INSERT INTO city (ID, Name, CountryCode, District, Population)
VALUES (4080, 'MacMurdo Station', 'ATA', 'MacMurdo Station', 1000);

INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Africa', 30370000, 24.4, 608);
INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Antarctica', 14000000, 9.2, 4080);
INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Asia',44579000 ,29.5 ,1024 );
INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Europe', 10180000, 6.8, 3357);
INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('North America', 24709000, 16.5, 2515);
INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('Oceania', 8600000 , 5.9, 130);
INSERT INTO Continent(Name, Area, PercentTotalMass, MostPopulousCity)
VALUES ('South America', 8600000, 12.0, 206);


# Modificar la tabla "country" de manera que el campo "Continent" 
# pase a ser una clave externa (o foreign key) a la tabla Continent.*
# ALTER TABLE table_name ADD CONSTRAINT constraint_name FOREIGN KEY (foreign_key_name,...) REFERENCES parent_table(column_name,...);
ALTER TABLE country ADD CONSTRAINT fk_country_continent FOREIGN KEY (Continent) REFERENCES Continent(Name); 

#Devuelva una lista de los nombres y las regiones a las que pertenece cada país ordenada alfabéticamente.
Select Name, Region FROM country ORDER BY Name;
#Liste el nombre y la población de las 10 ciudades más pobladas del mundo.
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 10;
#Liste el nombre, región, superficie y forma de gobierno de los 10 países con menor superficie.
SELECT Name, Region, SurfaceArea, GovernmentForm FROM country ORDER BY SurfaceArea ASC LIMIT 10;
#Liste todos los países que no tienen independencia (hint: ver que define la independencia de un país en la BD).
SELECT Name FROM country WHERE IndepYear IS NULL; 
#Liste el nombre y el porcentaje de hablantes que tienen todos los idiomas declarados oficiales.
SELECT Lenguage, Percentage FROM countrylanguage WHERE (IsOfficial LIKE "T");

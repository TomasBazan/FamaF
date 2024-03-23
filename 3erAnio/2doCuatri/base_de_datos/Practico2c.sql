DROP DATABASE world;
CREATE DATABASE world;
USE `world`;

-- Create the Scheme
DROP TABLE IF EXISTS `country`;
CREATE TABLE country (
  Code CHAR(3) PRIMARY KEY,
  Name VARCHAR(80),
  Continent VARCHAR(80),
  Region VARCHAR(80),
  SurfaceArea NUMERIC(20,2),
  IndepYear INT,
  Population INT,
  LifeExpectancy NUMERIC(5,2),
  GNP NUMERIC(10,2),
  GNPOld NUMERIC(10,2),
  LocalName VARCHAR(80),
  GovernmentForm VARCHAR(80),
  HeadOfState VARCHAR(80),
  Capital INT,
  Code2 CHAR(2)
) CHARSET = utf8mb4;

DROP TABLE IF EXISTS `city`;
CREATE TABLE city(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(80),
  CountryCode CHAR(3),
  District VARCHAR(80),
  Population INT,
  FOREIGN KEY(CountryCode) REFERENCES country(Code)
) CHARSET = utf8mb4;

DROP TABLE IF EXISTS `countrylanguage`;
CREATE TABLE countrylanguage(
  CountryCode CHAR(3),
  Language VARCHAR(55) ,
  IsOfficial CHAR(1),
  Percentage NUMERIC(5,2),
  PRIMARY KEY(CountryCode, Language),
  FOREIGN KEY(CountryCode) REFERENCES country(Code)
) CHARSET = utf8mb4;


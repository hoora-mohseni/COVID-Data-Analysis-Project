DROP TABLE IF EXISTS covidvaccination2021_22; 
CREATE TABLE covidvaccination21_22 (
    
    continent VARCHAR(255),
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    new_tests INT,  -- INTEGER data type for the number of tests, may contain NULL
    total_tests BIGINT,  -- INTEGER data type for the total number of tests, may contain NULL
    total_vaccinations BIGINT,  -- INTEGER data type for the total number of vaccinations, may contain NULL
    people_vaccinated BIGINT,  -- INTEGER data type for the number of people vaccinated, may contain NULL
    people_fully_vaccinated BIGINT,  -- INTEGER data type for the number of fully vaccinated people, may contain NULL
    new_vaccinations BIGINT,  -- INTEGER data type for the number of new vaccinations, may contain NULL
    new_vaccinations_smoothed BIGINT  -- INTEGER data type for the number of smoothed new vaccinations, may contain NULL
 
 );

CREATE TABLE covidDeaths21_22 (

  iso_code  char(50) NOT NULL,
  continent varchar(255) DEFAULT NULL,
  location varchar(255) NOT NULL,
  date date NOT NULL,
  population bigint DEFAULT NULL,
  total_cases int DEFAULT NULL,
  new_cases int DEFAULT NULL,
  new_cases_smoothed float DEFAULT NULL,
  total_deaths int DEFAULT NULL,
  new_deaths int DEFAULT NULL
  
) 
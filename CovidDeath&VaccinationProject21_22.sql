

SELECT *
FROM coviddeath21_22
ORDER BY 1,2 ; 

-- select data that will be use

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeath21_22;

-- DeathPercentage 

SELECT location, date, total_cases, total_deaths,(total_cases/total_deaths) * 100 AS deathPrecent, population
FROM coviddeath21_22
WHERE location LIKE '%states%'     -- for specificy loction
ORDER BY 1,2;  

-- what percentage of population got Covid

SELECT location, date, total_cases, population, (total_cases/population) * 100 AS populationInfection
FROM coviddeath21_22
-- WHERE location LIKE '%states%'     -- for specificy loction
ORDER BY 1,2;  

-- Highest infection rate compared to population of countries

SELECT location, MAX(total_cases) AS highestInfectionCount, population, MAX((total_cases/population) * 100) AS highPopulationInfection
FROM coviddeath21_22
GROUP BY location , population
ORDER BY highPopulationInfection desc;  

-- showing countries with highest death count per population

SELECT location, MAX(total_deaths ) AS highestDeathCount
FROM coviddeath21_22
WHERE continent IS NULL
GROUP BY location
ORDER BY highestDeathCount desc;  


-- check with continent 

SELECT location, MAX(total_deaths) AS highestDeathCount
FROM coviddeath21_22
WHERE continent IS NULL
GROUP BY location
ORDER BY highestDeathCount desc;  

-- showing the continents  highest death count per population 

SELECT continent, MAX(total_deaths) AS highestDeathCount
FROM coviddeath21_22
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highestDeathCount desc;  

-- Global Numbers

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) As total_death,
		SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage 
FROM coviddeath21_22
WHERE continent IS NOT NULL     -- for specificy loction
-- GROUP BY date 
ORDER BY 1,2 ;  

-- Vaccination

SELECT * 
FROM covidvaccination21_22;

-- join tables together -- looking total population and vaccination 

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
		SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY cd.location  ORDER BY cd.date, cd.location) AS RollingPeoplevaccinated
FROM coviddeath21_22 AS cd
JOIN covidvaccination21_22 AS cv
	ON cv.location = cd.location
    AND cv.date = cd.date
WHERE cd.continent IS NOT NULL   
ORDER BY  2,3 ;
    
-- see only the when and where they have vaccination

WITH VaccinationSummary AS (
    SELECT
        cd.continent,
        cd.location,
        cd.date,
        cd.population,
        cv.new_vaccinations,
        SUM(CAST(cv.new_vaccinations AS SIGNED)) OVER (PARTITION BY cd.location) AS total_vaccinations
    FROM covidvaccination21_22 AS cv
    JOIN coviddeath21_22 AS cd
        ON cv.location = cd.location
        AND cv.date = cd.date
)

SELECT *
FROM VaccinationSummary
WHERE total_vaccinations IS NOT NULL
AND new_vaccinations IS NOT NULL
ORDER BY location, date;

-- 

WITH PopvsVac ( continent, location, date, population,new_vaccinations, rollingPeopleVaccinated) 
As 
(SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
		SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY cd.location  ORDER BY cd.date, cd.location) AS RollingPeoplevaccinated
FROM coviddeath21_22 AS cd
JOIN covidvaccination21_22 AS cv
	ON cv.location = cd.location
    AND cv.date = cd.date
WHERE cd.continent IS NOT NULL   
ORDER BY  2,3 
) 
SELECT * , (rollingPeoplevaccinated/population)*100
FROM PopvsVac    ;

-- TEMP TABLE 

DROP TABLE IF EXISTS percentPopulatinvaccinated;
CREATE TABLE percentPopulatinvaccinated
(
continent NVARCHAR(255),
lacation NVARCHAR(255),
date DATETIME,
population NUMERIC,
new_vaccinations NUMERIC,
rollingPeopleVaccinated NUMERIC
);

INSERT INTO  percentPopulatinvaccinated
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
		SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY cd.location  ORDER BY cd.date, cd.location) AS RollingPeoplevaccinated
FROM coviddeath21_22 AS cd
JOIN covidvaccination21_22 AS cv
	ON cv.location = cd.location
    AND cv.date = cd.date;
-- WHERE cd.continent IS NOT NULL   
-- ORDER BY  2,3 

SELECT * , (rollingPeoplevaccinated/population)*100
FROM percentPopulatinvaccinated;

-- create view to store data for later visualizations


DROP TABLE IF EXISTS percentPopulatinvaccinated;
CREATE VIEW percentPopulatinvaccinated AS 
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
    SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY cd.location  ORDER BY cd.date, cd.location) AS RollingPeoplevaccinated
FROM coviddeath21_22 AS cd
JOIN covidvaccination21_22 AS cv
    ON cv.location = cd.location
    AND cv.date = cd.date
WHERE cd.continent IS NOT NULL   
ORDER BY cd.location, cd.date;

-- 
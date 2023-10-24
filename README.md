# COVID Data Analysis Project

This project is an analysis of COVID-19 data from the years 2021 and 2022. The data is sourced from [Our World in Data](https://ourworldindata.org/covid-deaths).

## Table of Contents
- [Introduction](#introduction)
- [SQL Code](#sql-code)
- [Data Tables](#data-tables)
- [Instructions](#instructions)

## Introduction
This project aims to provide insights into COVID-19 statistics from the selected years. It includes analysis on both COVID deaths and vaccinations. The data has been organized into two SQL tables: `CovidDeath` and `CovidVaccination`, with common key columns for comparison.
You can find the Tableau Dashboard(visualization) on linke below.
[Covid Tableau Dashboard](https://public.tableau.com/app/profile/hoora.mohseni/viz/CovidDashboardTutorial_16981685176540/Dashboard1?publish=yes)

## SQL Code
Here is an overview of the SQL queries used in this project:

- `SELECT * FROM coviddeath21_22` to view all COVID death data.
- `SELECT location, date, total_cases, new_cases, total_deaths, population` to see essential COVID death information.
- `SELECT location, date, total_cases, total_deaths, (total_cases/total_deaths) * 100 AS deathPercent, population` to calculate death percentages.
- `SELECT location, date, total_cases, population, (total_cases/population) * 100 AS populationInfection` to determine the percentage of population infected.
- `SELECT location, MAX(total_cases) AS highestInfectionCount, population, MAX((total_cases/population) * 100) AS highPopulationInfection` to find countries with the highest infection rates.
- `SELECT location, MAX(total_deaths ) AS highestDeathCount` to find countries with the highest death counts.
- `SELECT continent, MAX(total_deaths) AS highestDeathCount` to find continents with the highest death counts.
- `SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_death, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage` to get global statistics.

For vaccination data:
- `SELECT * FROM covidvaccination21_22` to view all COVID vaccination data.
- `SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY cd.location  ORDER BY cd.date, cd.location) AS RollingPeoplevaccinated` to join death and vaccination data.

## Data Tables
The project includes two tables:
- `CovidDeath`: Contains data related to COVID deaths, including iso_code,	continent, location,	date,	population,	total_cases,	new_cases,	new_cases_smoothed,	total_deaths,	new_deaths,	total_cases_per_million,	new_cases_per_million, total_deaths_per_million,	new_deaths_per_million,	new_deaths_smoothed_per_million,	reproduction_rate	icu_patients,	icu_patients_per_million,	hosp_patients,	hosp_patients_per_million,	weekly_icu_admissions,	weekly_icu_admissions_per_million,	weekly_hosp_admissions,
and weekly_hosp_admissions_per_million.

- `CovidVaccination`: Contains data related to COVID vaccinations, including iso_code,	continent,	location,	date,	total_tests,	new_tests,	total_tests_per_thousand,	new_tests_per_thousand,	new_tests_smoothed,	new_tests_smoothed_per_thousand,	positive_rate	tests_per_case,	tests_units,	total_vaccinations,	people_vaccinated,	people_fully_vaccinated,	total_boosters,	new_vaccinations,	new_vaccinations_smoothed,	total_vaccinations_per_hundred,	total_boosters_per_hundred, stringency_index	median_age,	aged_65_older,	aged_70_older,	gdp_per_capita, and	extreme_poverty.

- You can find the SQL queries used to create the data tables in this project in the following file:
  
  [Create Tables SQL File](https://github.com/hoora-mohseni/COVID-Data-Analysis-Project/blob/main/TableCovid21_22.sql)


## Instructions
1. To use this project, make sure you have a SQL database set up and ready.

2. Download the COVID-19 datasets from [Our World in Data](https://ourworldindata.org/covid-deaths) for the years 2021 and 2022.

3. Import the datasets into your SQL database.

4. Execute the SQL queries provided in the "SQL Code" section to perform various analyses on the data.

5. Customize the queries as needed to suit your analysis requirements.

6. You can create views or temporary tables as shown in the SQL code to store data for later visualizations.

Feel free to explore, analyze, and visualize the data to gain insights into COVID-19 statistics from 2021 and 2022. If you have any questions or need further assistance, please don't hesitate to reach out.

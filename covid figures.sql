-- Select the data we are going to be using

USE covid_canada;

-- Order by province and date

SELECT 
	prname, 
	date, 
	numdeaths, 
	numtotal , 
	numtoday,
	numdeathstoday,
FROM provinces
ORDER BY 2,3

-- Looking at the number of Total Cases vs Total Deaths
-- Order by province and date

SELECT 
	prname AS 'Province', 
	date,
	numtotal AS 'TotalCases',
	numdeaths AS 'TotalDeaths'
FROM provinces
ORDER BY 2,3

-- Showing provinces with the most covid cases

SELECT 
	prname AS 'Province',
	date,
	numtotal AS 'HighestCaseCount'
FROM provinces
ORDER BY HighestCaseCount DESC

-- Looking at the likelihood of dying if you contract covid in Ontario (the province that currently has the most cases)

SELECT 
	prname AS 'Province', 
	date,
	numtotal AS 'TotalCases',
	numdeaths AS 'TotalDeaths',
	(numdeaths/numtotal)*100 AS 'DeathPercentage'
FROM provinces
WHERE prname LIKE 'Ontario%'
ORDER BY 2,3

-- Showing provinces with the highest death count

SELECT 
	prname AS 'Province', 
	date,
	numdeaths AS 'TotalDeaths'
FROM provinces
ORDER BY TotalDeaths DESC

-- Showing latest daily cases and deaths
-- Order by date and then province

SELECT
	prname AS 'Province',
	date,
	numtoday AS 'NewCasesToday',
	numdeathstoday AS 'NewDeathsToday'
FROM provinces
ORDER BY date DESC, Province

-- Showing Number of Covid Cases in each province vs the entire country

SELECT
	prname AS 'Province',
	p.date,
	p.numtotal AS 'ProvinceTotalCases',
	c.total_cases AS 'CanadaTotalCases'
FROM provinces p
JOIN canada c
	ON p.date = c.date
ORDER BY p.date DESC, Province

-- Showing Number of Deaths in each province vs the entire country
-- Showing the percentage of total covid deaths based on province

SELECT
	prname AS 'Province',
	p.date,
	p.numdeaths AS 'ProvinceTotalDeaths',
	c.total_deaths AS 'CanadaTotalDeaths',
	(p.numdeaths/c.total_deaths)*100 AS 'PercentageOfTotalDeaths'
FROM province p
JOIN canada c
	ON p.date = c.date
ORDER BY date DESC, Province

-- Create a table to store all provincial covid data before 2022

CREATE TABLE provinces_archived AS
SELECT *
FROM provinces
WHERE date < '1/1/2022'

-- Added DeathStats column to show when provinces reached 10000 deaths

SELECT
	prname AS 'Provinces',
    	date,
    	numdeaths,
    	CASE WHEN numdeaths > 10000 THEN 'Deaths exceed 10000'
	WHEN numdeaths = 10000 THEN 'Reached 10000 deaths'
	ELSE 'Deaths under 10000'
	END AS DeathStats
FROM provinces

USE cap07;

SELECT COUNT(*) FROM DBO.covid_mortes
SELECT COUNT(*) FROM DBO.covid_vacinacao


ALTER TABLE DBO.covid_mortes
ALTER COLUMN date DATE;

-- # Ordenando por nome de coluna ou numero da coluna
SELECT * FROM DBO.covid_vacinacao 
ORDER BY 
    CONVERT(VARCHAR, location), 
    CONVERT(DATE, date);

-- # Retornando algumas colunas relevantes para nosso estudo
SELECT date,
       location,
       total_cases,
       new_cases,
       total_deaths,
       population 
FROM dbo.covid_mortes 
ORDER BY 2,1; -- # Ordenando por localidade (pais) e depois por data


-- # Qual a média de mortos por país?
-- # Análise Univariada
SELECT location, 
	COALESCE(AVG(total_deaths), -1) as media_mortos
FROM dbo.covid_mortes
GROUP BY location
ORDER BY media_mortos DESC;

-- # Isso é análise univariada ou multivariada? r: UNIVARIADA, visto que está sendo analisada apenas uma variavel por vez
SELECT location,
       AVG(total_deaths) AS MediaMortos,
       AVG(new_cases) AS MediaNovosCasos
FROM DBO.covid_mortes 
GROUP BY location
ORDER BY MediaMortos DESC;

-- # Qual a proporção de mortes em relação ao total de casos no Brasil?
-- # Análise Mutivariada
SELECT date,
       location, 
		CAST(total_cases AS float) AS total_cases,
		CAST(total_deaths AS float) AS total_deaths,
		(CAST(total_deaths AS float) / NULLIF(CAST(total_cases AS float), 0)) * 100.0 AS perc_deaths
FROM dbo.covid_mortes  
WHERE location = 'Brazil'
ORDER BY 2,1;

SELECT TOP (5) * FROM DBO.covid_mortes

-- # Qual a proporção média entre o total de casos e a população de cada localidade?
SELECT 
	COALESCE(AVG(CAST(total_cases AS FLOAT) / CAST(population AS FLOAT)) * 100.0,-1) AS perc_media_casos_populacao,
	location
FROM dbo.covid_mortes
GROUP BY location
ORDER BY 1 DESC;

-- # Considerando o maior valor do total de casos, quais os países com a maior taxa de infecção em relação à população?
SELECT 
	COALESCE(MAX(CAST(total_cases AS FLOAT) / CAST(population AS FLOAT)) * 100.0,-1) AS tx_infeccao,
	location
FROM dbo.covid_mortes
GROUP BY location
ORDER BY 1 DESC

-- # Quais os países com o maior número de mortes?
SELECT 
	COALESCE(MAX(total_deaths * 1),-1) AS total_deaths,
	location
FROM dbo.covid_mortes
GROUP BY location
ORDER BY 1 DESC


-- # Qual o percentual de mortes por dia?
SELECT date,
       SUM(new_cases) as total_cases, 
       SUM(new_deaths * 1) as total_deaths, -- Transformado os dados tipo varchar em tipoo int
       (SUM(new_deaths * 1.0) / SUM(new_cases * 1.0)) * 100.0 as perc_mortes --  Transformando dados em tipo float
FROM dbo.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY date 
ORDER BY 1,2;


-- # Qual o número de novos vacinados e o total de novos vacinados ao longo do tempo por continente?
-- # Considere apenas os dados da América do Sul
-- # Considere a data no formato January/2020
SELECT 
    mortos.continent,
    FORMAT(mortos.date, 'MMMM/yyyy') AS MES,
    vacinados.new_vaccinations,
    SUM(CAST(vacinados.new_vaccinations AS float)) OVER (PARTITION BY mortos.continent ORDER BY FORMAT(mortos.date, 'MMMM/yyyy')) as TotalVacinados
FROM 
    dbo.covid_mortes mortos 
JOIN 
    dbo.covid_vacinacao vacinados ON mortos.location = vacinados.location AND mortos.date = vacinados.date
WHERE 
    mortos.continent = 'South America'
ORDER BY 
    1, 2;


-- # Qual o número de novos vacinados e a média móvel de novos vacinados ao longo do tempo por localidade?
-- # Considere apenas os dados da América do Sul

SELECT mortos.continent,
       mortos.location,
       mortos.date,
       vacinados.new_vaccinations,
       AVG(CAST(vacinados.new_vaccinations AS float)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) as media_movel_vacinados
FROM dbo.covid_mortes mortos 
JOIN dbo.covid_vacinacao vacinados
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.continent = 'South America'
ORDER BY 2,3;

-- # Qual o número de novos vacinados e o total de novos vacinados ao longo do tempo por continente?
-- # Considere apenas os dados da América do Sul

SELECT mortos.continent,
       mortos.date,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS float)) OVER (PARTITION BY mortos.continent ORDER BY mortos.date) as total_vacinados
FROM dbo.covid_mortes mortos 
JOIN dbo.covid_vacinacao vacinados
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.continent = 'South America'
ORDER BY 1,2;

-- # Qual o percentual da população com pelo menos 1 dose da vacina ao longo do tempo?
-- # Considere apenas os dados do Brasil
-- # Usando Common Table Expressions (CTE)

WITH PopvsVac (continent,location, date, population, new_vaccinations, TotalMovelVacinacao) AS
(
SELECT mortos.continent,
       mortos.location,
       mortos.date,
       mortos.population,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS float)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) AS TotalMovelVacinacao
FROM dbo.covid_mortes mortos 
JOIN dbo.covid_vacinacao vacinados 
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.location = 'Brazil'
)
SELECT *, (TotalMovelVacinacao / population) * 100 AS Percentual_1_Dose FROM PopvsVac;

-- # Durante o mês de Maio/2021 o percentual de vacinados com pelo menos uma dose aumentou ou diminuiu no Brasil?
IF OBJECT_ID('dbo.PercentualPopVac', 'V') IS NOT NULL
    DROP VIEW dbo.PercentualPopVac;

CREATE  VIEW dbo.PercentualPopVac AS
WITH PopvsVac AS
(
    SELECT 
        mortos.continent,
        mortos.location,
        mortos.date,
        mortos.population,
        vacinados.new_vaccinations,
        SUM(CAST(vacinados.new_vaccinations AS FLOAT)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) AS TotalMovelVacinacao
    FROM dbo.covid_mortes mortos 
    JOIN dbo.covid_vacinacao vacinados ON mortos.location = vacinados.location AND mortos.date = vacinados.date
    WHERE mortos.location = 'Brazil'
)
SELECT *, (CAST(TotalMovelVacinacao AS FLOAT) / population) * 100 AS Percentual_1_Dose 
FROM PopvsVac
WHERE FORMAT(date, 'MMMM/yyyy') = 'May/2021'
AND location = 'Brazil';
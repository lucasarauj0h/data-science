USE cap06;

-- Renomeando as colunas da tabela TB_BIKES
EXEC sp_rename 'dbo.TB_BIKES.Duration', 'duracao_segundos', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.Start_date', 'data_inicio', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.End_date', 'data_fim', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.Start_station_number', 'numero_estacao_inicio', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.Start_station', 'estacao_inicio', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.End_station_number', 'numero_estacao_fim', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.End_station', 'estacao_fim', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.Bike_number', 'numero_bike', 'COLUMN';
EXEC sp_rename 'dbo.TB_BIKES.Member_type', 'tipo_membro', 'COLUMN';

-- # Duração total do aluguel das bikes (em horas)
SELECT TOP (1000) *
  FROM [cap06].[dbo].[TB_BIKES]

SELECT SUM(duracao_segundos)/3600.0 as duracao_horas
from dbo.tb_bikes;


-- # Duração total do aluguel das bikes (em horas), ao longo do tempo (soma acumulada)

SELECT duracao_segundos,
       SUM(duracao_segundos/3600.0) OVER (ORDER BY data_inicio ) AS duracao_total_horas 
FROM dbo.TB_BIKES
ORDER BY duracao_total_horas; -- OVER: PARA TODO CONJUNTO DE DADOS, ORGANIZE POR DATA_INICIO

-- # Duração total do aluguel das bikes (em horas), ao longo do tempo, por estação de início do aluguel da bike,
-- # quando a data de início foi inferior a '2012-01-08'
SELECT estacao_inicio,
       duracao_segundos,
	   (SUM(duracao_segundos / 3600.0) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio))  AS tempo_total_horas
FROM dbo.TB_BIKES -- Calculando a soma de horas ao longo do tempo (serie temporal) data_inicio, repartindo-as (partition) por estacao_inicio.
WHERE data_inicio < '2012-01-08'
ORDER BY estacao_inicio;


-- # Duração total do aluguel das bikes (em horas), ao longo do tempo, por estação de início do aluguel da bike,
-- # quando a data de início foi inferior a '2012-01-08' 
--- ------------ RETIRANDO A ORDENAÇÃO (ORDER BY data_inicio)
SELECT estacao_inicio,
       duracao_segundos,
	   (SUM(duracao_segundos / 3600.0) OVER (PARTITION BY estacao_inicio))  AS tempo_total_horas
FROM dbo.TB_BIKES -- Calculando a soma de horas ao longo do tempo (serie temporal) data_inicio, repartindo-as (partition) por estacao_inicio.
-- SEM A SERIE TEMPORAL, ELE NÃO TEM COMO CALCULAR A SOMA AO LONGO DO TEMPO, ENTÃO APENAS NOS RESULTA A SOMA TOTAL DE CADA PARTIÇÃO
WHERE data_inicio < '2012-01-08'
ORDER BY estacao_inicio;


-- # Qual a média de tempo (em horas) de aluguel de bike da estação de início 31017?
SELECT estacao_inicio,
       AVG(duracao_segundos/3600.0) AS media_tempo_aluguel
FROM dbo.TB_BIKES
WHERE numero_estacao_inicio = 31017
GROUP BY estacao_inicio;

-- # Retornar:
-- # Estação de início, data de início e duração de cada aluguel de bike em segundos
-- # Duração total de aluguel das bikes ao longo do tempo por estação de início
-- # Duração média do aluguel de bikes ao longo do tempo por estação de início
-- # Número de aluguéis de bikes por estação ao longo do tempo 
-- # Somente os registros quando a data de início for inferior a '2012-01-08'

SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       SUM(duracao_segundos/3600.0) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS duracao_total_aluguel,
       AVG(duracao_segundos/3600.0)  OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS media_tempo_aluguel,
       COUNT(duracao_segundos/3600.0)  OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
GROUP BY estacao_inicio, data_inicio, duracao_segundos;

-- # Retornar:
-- # Estação de início, data de início de cada aluguel de bike e duração de cada aluguel em segundos
-- # Número de aluguéis de bikes (independente da estação) ao longo do tempo 
-- # Somente os registros quando a data de início for inferior a '2012-01-08'

SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (ORDER BY data_inicio) AS numero_alugueis
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
GROUP BY estacao_inicio, data_inicio, duracao_segundos;

-- # E se quisermos o mesmo resultado anterior, mas a contagem por estação?

SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
GROUP BY estacao_inicio, data_inicio, duracao_segundos;

-- # Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio, -- CLAUSULA CAST permite a mudança do tipo de valor da coluna
       duracao_segundos,
       DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08' 
AND numero_estacao_inicio = 31000

-- # Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio, -- CLAUSULA CAST permite a mudança do tipo de valor da coluna
       duracao_segundos,
       RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08' 
AND numero_estacao_inicio = 31000


-- # Comparando as funções
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis,
       DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS ranking_aluguel_dense_rank,
       RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS ranking_aluguel_rank
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;


-- 
-- # NTILE
-- # A função NTILE() é uma função de janela (window) que distribui linhas de uma partição ordenada em um número predefinido 
-- # de grupos aproximadamente iguais. A função atribui a cada grupo um número a partir de 1. 
SELECT estacao_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_alugueis,
       NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_dois,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_quatro,
       NTILE(5) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_cinco
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;



-- # NTILE
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis,
       NTILE(1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo,
       NTILE(16) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;


-- # LAG e LEAD
-- LAG: MOVE UM PARA FRENTE
-- LEAD: MOVE UM PARA TRAS (nesse caso escolhida ao longo do tempo)
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS registro_lag,
       LEAD(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS registro_lead
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

-- # Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para outro?
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM dbo.TB_BIKES
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;


-- # LAG com Subquery
SELECT *
  FROM (
    SELECT estacao_inicio,
           CAST(data_inicio as date) AS data_inicio,
           duracao_segundos,
           duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
      FROM dbo.TB_BIKES
     WHERE data_inicio < '2012-01-08'
     AND numero_estacao_inicio = 31000) resultado
 WHERE resultado.diferenca IS NOT NULL;
 -- Transformando a query em uma tabela para que seja possivel usar a clausula WHERE


-- # Criamos um alias para a janela e particionamos novamente a janela
SELECT estacao_inicio,
       CAST(data_inicio as date) AS data_inicio,
       duracao_segundos,
       NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_dois,
       NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_quatro,
       NTILE(5) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_cinco
  FROM dbo.TB_BIKES
 WHERE data_inicio < '2012-01-08'
WINDOW ntile_window AS (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date))
 ORDER BY estacao_inicio;


SELECT 
    data_inicio,
    CONVERT(DATE, data_inicio) AS Data,
    CONVERT(DATETIME, data_inicio) AS DataHora,
    YEAR(data_inicio) AS Ano,
    MONTH(data_inicio) AS Mes,
    DAY(data_inicio) AS Dia
FROM dbo.TB_BIKES
WHERE numero_estacao_inicio = 31000;


-- # Extraindo o mês da data
SELECT 
    MONTH(data_inicio) AS Mes,
    duracao_segundos
FROM dbo.TB_BIKES
WHERE numero_estacao_inicio = 31000;


-- # Adicionando 10 dias à data de início
SELECT 
    data_inicio, 
    DATEADD(DAY, 10, data_inicio) AS data_inicio, 
    duracao_segundos
FROM dbo.TB_BIKES
WHERE numero_estacao_inicio = 31000;


-- # Retornando dados de 10 dias anteriores à data de início do aluguel da bike
SELECT 
    data_inicio, 
    duracao_segundos
FROM dbo.TB_BIKES
WHERE '2012-03-31' >= DATEADD(DAY, -10, data_inicio)
    AND numero_estacao_inicio = 31000;

-- # Diferença entre data_inicio e data_fim
SELECT 
    data_inicio, 
    duracao_segundos
FROM dbo.TB_BIKES
WHERE '2012-03-31' >= DATEADD(DAY, -10, data_inicio)
    AND numero_estacao_inicio = 31000;

-- # Diferença entre data_inicio e data_fim
SELECT 
    data_inicio, 
    data_fim, 
    DATEDIFF(DAY, data_inicio, data_fim) AS DiffDias
FROM dbo.TB_BIKES
WHERE numero_estacao_inicio = 31000;

-- # Diferença entre data_inicio e data_fim
SELECT 
    DATEPART(HOUR, data_inicio) AS HoraInicio, 
    DATEPART(HOUR, data_fim) AS HoraFim, 
    DATEDIFF(HOUR, data_inicio, data_fim) AS DiffHoras
FROM dbo.TB_BIKES
WHERE numero_estacao_inicio = 31000;

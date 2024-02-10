USE exec5 
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

SELECT TOP (5) [duracao_segundos]
      ,[data_inicio]
      ,[data_fim]
      ,[numero_estacao_inicio]
      ,[estacao_inicio]
      ,[numero_estacao_fim]
      ,[estacao_fim]
      ,[numero_bike]
      ,[tipo_membro]
  FROM [exec5].[dbo].[TB_BIKES]


-- # 1- Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro?
SELECT AVG(duracao_segundos) as media_segundos, tipo_membro
  FROM [exec5].[dbo].[TB_BIKES]
  GROUP BY tipo_membro
  ORDER BY media_segundos DESC;

-- # 2- Qual a média de tempo (em segundos) de duração do aluguel de bike por 
-- tipo de membro e por estação fim (onde as bikes são entregues após o aluguel)?
SELECT AVG(duracao_segundos) as media_segundos, tipo_membro, estacao_inicio
  FROM [exec5].[dbo].[TB_BIKES]
  GROUP BY tipo_membro, estacao_inicio
  ORDER BY estacao_inicio DESC;

-- # 3- Qual hora do dia (independente do mês) a bike de número W01182 teve o 
-- maior número de aluguéis considerando a data de início?

SELECT 
    DATEPART(HOUR, data_inicio) AS hora,
	COUNT(duracao_segundos) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE numero_bike = 'W01182'
	GROUP BY DATEPART(HOUR, data_inicio)
	ORDER BY num_alugueis DESC; 


-- # 4- Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e 
-- # por estação fim (onde as bikes são entregues após o aluguel) ao longo do tempo?

SELECT 
    AVG(duracao_segundos) OVER (PARTITION BY tipo_membro ORDER BY data_inicio) AS media_tempo_aluguel,
	tipo_membro,	   duracao_segundos, 
	estacao_fim
	FROM [exec5].[dbo].[TB_BIKES]
	ORDER BY data_inicio;

-- # 5- Qual o número de aluguéis da bike de número W01182 ao longo do tempo considerando a data de início?
SELECT 
    CONVERT(DATE, data_inicio) AS data,
	ROW_NUMBER() OVER (ORDER BY CONVERT(DATE, data_inicio)) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE numero_bike = 'W01182'
	ORDER BY num_alugueis; 


-- # 6- Retornar:
-- # Estação fim, data fim de cada aluguel de bike e duração de cada aluguel em segundos
-- # Número de aluguéis de bikes (independente da estação) ao longo do tempo 
-- # Somente os registros quando a data fim foi no mês de Abril

SELECT 
    estacao_fim, CONVERT(DATE, data_fim) AS data_fim, duracao_segundos, 
	ROW_NUMBER() OVER (ORDER BY data_fim) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE MONTH(data_fim) = 4
	ORDER BY num_alugueis; 

-- # 7- Retornar:
-- # Estação fim, data fim e duração em segundos do aluguel 
-- # A data fim deve ser retornada no formato: 01/January/2012 00:00:00
-- # Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo do tempo
-- # Retornar os dados para os aluguéis entre 7 e 11 da manhã

SELECT 
    estacao_fim, 
	FORMAT(data_fim, 'dd/MMMM/yyyy HH:mm:ss') AS data_final,
	duracao_segundos,
	DENSE_RANK() OVER (ORDER BY DAY(data_fim)) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE DATEPART(HOUR, data_fim) BETWEEN 07 AND 11
	ORDER BY data_fim; 


-- # 8- Qual a diferença da duração do aluguel de bikes ao longo do tempo, 
-- de um registro para outro, considerando data de início do aluguel e estação de início?
--# A data de início deve ser retornada no formato: Sat/Jan/12 00:00:00 (Sat = Dia da semana abreviado e Jan igual mês abreviado)
--# Retornar os dados para os aluguéis entre 01 e 03 da manhã

SELECT
	estacao_inicio,
	FORMAT(data_fim, 'ddd/MMM/yyyy HH:mm:ss') AS data_final,
	duracao_segundos,
	duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM dbo.TB_BIKES
WHERE DATEPART(HOUR, data_fim) BETWEEN 01 AND 03


-- # 9- Retornar:
-- # Estação fim, data fim e duração em segundos do aluguel 
-- # A data fim deve ser retornada no formato: 01/January/2012 00:00:00
-- # Queremos os registros divididos em 4 grupos ao longo do tempo por partição
-- # Retornar os dados para os aluguéis entre 8 e 10 da manhã
-- # Qual critério usado pela função NTILE para dividir os grupos?

SELECT
	estacao_fim,
	FORMAT(data_fim, 'dd/MMMM/yyyy HH:mm:ss') AS data_final,
	duracao_segundos,
	NTILE(4) OVER (PARTITION BY estacao_fim ORDER BY CAST(data_fim as date)) AS ranking_aluguel
FROM dbo.TB_BIKES
WHERE DATEPART(HOUR, data_fim) BETWEEN 8 AND 10

-- # 10- Quais estações tiveram mais de 35 horas de duração total do aluguel de bike ao longo do tempo considerando a data fim e estação fim?
-- # Retorne os dados entre os dias '2012-04-01' e '2012-04-02'
-- # Dica: Use função window e subquery

SELECT estacao_fim, CONVERT(DATE, data) AS data, MAX(horas_aluguel_acumulado) AS horas_aluguel_acumulado
FROM (
    SELECT 
    estacao_fim,
    CONVERT(DATE, data_fim) AS data,
    duracao_segundos/3600.0 AS duracao_horas,
    SUM(duracao_segundos/3600.0) OVER (PARTITION BY estacao_fim ORDER BY CONVERT(DATE, data_fim)) AS horas_aluguel_acumulado
    FROM [exec5].[dbo].[TB_BIKES]
	WHERE data_fim BETWEEN '2012-04-01' AND '2012-04-02') resultado
GROUP BY estacao_fim, data
HAVING MAX(horas_aluguel_acumulado) > 35
ORDER BY estacao_fim;

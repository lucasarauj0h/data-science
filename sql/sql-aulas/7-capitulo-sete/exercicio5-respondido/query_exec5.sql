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


-- # 1- Qual a m�dia de tempo (em segundos) de dura��o do aluguel de bike por tipo de membro?
SELECT AVG(duracao_segundos) as media_segundos, tipo_membro
  FROM [exec5].[dbo].[TB_BIKES]
  GROUP BY tipo_membro
  ORDER BY media_segundos DESC;

-- # 2- Qual a m�dia de tempo (em segundos) de dura��o do aluguel de bike por 
-- tipo de membro e por esta��o fim (onde as bikes s�o entregues ap�s o aluguel)?
SELECT AVG(duracao_segundos) as media_segundos, tipo_membro, estacao_inicio
  FROM [exec5].[dbo].[TB_BIKES]
  GROUP BY tipo_membro, estacao_inicio
  ORDER BY estacao_inicio DESC;

-- # 3- Qual hora do dia (independente do m�s) a bike de n�mero W01182 teve o 
-- maior n�mero de alugu�is considerando a data de in�cio?

SELECT 
    DATEPART(HOUR, data_inicio) AS hora,
	COUNT(duracao_segundos) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE numero_bike = 'W01182'
	GROUP BY DATEPART(HOUR, data_inicio)
	ORDER BY num_alugueis DESC; 


-- # 4- Qual a m�dia de tempo (em segundos) de dura��o do aluguel de bike por tipo de membro e 
-- # por esta��o fim (onde as bikes s�o entregues ap�s o aluguel) ao longo do tempo?

SELECT 
    AVG(duracao_segundos) OVER (PARTITION BY tipo_membro ORDER BY data_inicio) AS media_tempo_aluguel,
	tipo_membro,	   duracao_segundos, 
	estacao_fim
	FROM [exec5].[dbo].[TB_BIKES]
	ORDER BY data_inicio;

-- # 5- Qual o n�mero de alugu�is da bike de n�mero W01182 ao longo do tempo considerando a data de in�cio?
SELECT 
    CONVERT(DATE, data_inicio) AS data,
	ROW_NUMBER() OVER (ORDER BY CONVERT(DATE, data_inicio)) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE numero_bike = 'W01182'
	ORDER BY num_alugueis; 


-- # 6- Retornar:
-- # Esta��o fim, data fim de cada aluguel de bike e dura��o de cada aluguel em segundos
-- # N�mero de alugu�is de bikes (independente da esta��o) ao longo do tempo 
-- # Somente os registros quando a data fim foi no m�s de Abril

SELECT 
    estacao_fim, CONVERT(DATE, data_fim) AS data_fim, duracao_segundos, 
	ROW_NUMBER() OVER (ORDER BY data_fim) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE MONTH(data_fim) = 4
	ORDER BY num_alugueis; 

-- # 7- Retornar:
-- # Esta��o fim, data fim e dura��o em segundos do aluguel 
-- # A data fim deve ser retornada no formato: 01/January/2012 00:00:00
-- # Queremos a ordem (classifica��o ou ranking) dos dias de aluguel ao longo do tempo
-- # Retornar os dados para os alugu�is entre 7 e 11 da manh�

SELECT 
    estacao_fim, 
	FORMAT(data_fim, 'dd/MMMM/yyyy HH:mm:ss') AS data_final,
	duracao_segundos,
	DENSE_RANK() OVER (ORDER BY DAY(data_fim)) AS num_alugueis
	FROM [exec5].[dbo].[TB_BIKES]
	WHERE DATEPART(HOUR, data_fim) BETWEEN 07 AND 11
	ORDER BY data_fim; 


-- # 8- Qual a diferen�a da dura��o do aluguel de bikes ao longo do tempo, 
-- de um registro para outro, considerando data de in�cio do aluguel e esta��o de in�cio?
--# A data de in�cio deve ser retornada no formato: Sat/Jan/12 00:00:00 (Sat = Dia da semana abreviado e Jan igual m�s abreviado)
--# Retornar os dados para os alugu�is entre 01 e 03 da manh�

SELECT
	estacao_inicio,
	FORMAT(data_fim, 'ddd/MMM/yyyy HH:mm:ss') AS data_final,
	duracao_segundos,
	duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM dbo.TB_BIKES
WHERE DATEPART(HOUR, data_fim) BETWEEN 01 AND 03


-- # 9- Retornar:
-- # Esta��o fim, data fim e dura��o em segundos do aluguel 
-- # A data fim deve ser retornada no formato: 01/January/2012 00:00:00
-- # Queremos os registros divididos em 4 grupos ao longo do tempo por parti��o
-- # Retornar os dados para os alugu�is entre 8 e 10 da manh�
-- # Qual crit�rio usado pela fun��o NTILE para dividir os grupos?

SELECT
	estacao_fim,
	FORMAT(data_fim, 'dd/MMMM/yyyy HH:mm:ss') AS data_final,
	duracao_segundos,
	NTILE(4) OVER (PARTITION BY estacao_fim ORDER BY CAST(data_fim as date)) AS ranking_aluguel
FROM dbo.TB_BIKES
WHERE DATEPART(HOUR, data_fim) BETWEEN 8 AND 10

-- # 10- Quais esta��es tiveram mais de 35 horas de dura��o total do aluguel de bike ao longo do tempo considerando a data fim e esta��o fim?
-- # Retorne os dados entre os dias '2012-04-01' e '2012-04-02'
-- # Dica: Use fun��o window e subquery

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

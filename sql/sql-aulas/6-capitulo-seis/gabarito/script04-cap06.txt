# Script 04

# Estatísticas

# Qual a média de tempo (em horas) de aluguel de bike da estação de início 31017?
SELECT estacao_inicio,
       AVG(duracao_segundos/60/60) AS media_tempo_aluguel
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31017
GROUP BY estacao_inicio;

# Qual a média de tempo (em horas) de aluguel da estação de início 31017, ao longo do tempo (média móvel)?
SELECT estacao_inicio,
       AVG(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS media_tempo_aluguel
FROM cap06.TB_BIKES
WHERE numero_estacao_inicio = 31017;

# Retornar:
# Estação de início, data de início e duração de cada aluguel de bike em segundos
# Duração total de aluguel das bikes ao longo do tempo por estação de início
# Duração média do aluguel de bikes ao longo do tempo por estação de início
# Número de aluguéis de bikes por estação ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'

# Esta query calcula estatísticas, mas não ao longo do tempo!
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       SUM(duracao_segundos/60/60) AS duracao_total_aluguel,
       AVG(duracao_segundos/60/60) AS media_tempo_aluguel,
       COUNT(duracao_segundos/60/60) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08'
GROUP BY estacao_inicio, data_inicio, duracao_segundos;

# Esta query calcula estatísticas, ao longo do tempo!
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS duracao_total_aluguel,
       AVG(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS media_tempo_aluguel,
       COUNT(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Retornar:
# Estação de início, data de início de cada aluguel de bike e duração de cada aluguel em segundos
# Número de aluguéis de bikes (independente da estação) ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'

# Solução 1
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       COUNT(duracao_segundos/60/60) OVER (ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Solução 2
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# E se quisermos o mesmo resultado anterior, mas a contagem por estação?
SELECT estacao_inicio,
       data_inicio,
       duracao_segundos,
       ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';





# Quais embarcações possuem pontuação de risco igual a 310

SELECT *
FROM cap02.TB_NAVIOS 
WHERE pontuacao_risco = 310
ORDER BY nome_navio
 
#  Quais embarcações têm classificação de risco A ou pontuação de risco igual a 0?

SELECT *
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco = 'A' or pontuacao_risco = 0
ORDER BY indice_conformidade

 
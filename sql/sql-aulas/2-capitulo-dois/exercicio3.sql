#  Quais embarcações têm classificação de risco C ou D e índice de conformidade menor ou igual a 95%

SELECT *
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco IN ('C', 'D') AND indice_conformidade <= 95
ORDER BY indice_conformidade

 
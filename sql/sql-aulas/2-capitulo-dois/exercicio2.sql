#  Quais embarcações têm classificação de risco A e índice de conformidade maior ou igual a 95%?

SELECT *
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco = 'A' AND indice_conformidade >= 95
ORDER BY indice_conformidade

 
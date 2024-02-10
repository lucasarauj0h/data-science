# [DESAFIO] Quais embarcações foram inspecionadas em Dezembro de 2016

SELECT *
FROM cap02.TB_NAVIOS 
WHERE temporada LIKE '%Dezembro 2016'

ORDER BY indice_conformidade

 
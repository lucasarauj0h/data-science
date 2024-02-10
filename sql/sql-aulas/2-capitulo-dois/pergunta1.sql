# Em abril de 2018 alguma embarcação teve indice de conformidade de 100% e pontuação de risco igual a 0?

SELECT *
FROM cap02.tb_navios 
WHERE indice_conformidade = 100 AND pontuacao_risco = 0 AND mes_ano = '04/2018'
ORDER BY indice_conformidade
;
# Em abril de 2018 alguma embarcação teve indice de conformidade de 100% e pontuação de risco igual a 0?

SELECT nome_navio, classificacao_risco, indice_conformidade, pontuacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE indice_conformidade IN (SELECT indice_conformidade 
								FROM cap02.TB_NAVIOS 
							   WHERE indice_conformidade > 90)
                                 AND pontuacao_risco = 0 
                                 AND mes_ano = '04/2018'
ORDER BY indice_conformidade 
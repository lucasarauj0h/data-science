# Binarização da variavel classe
# Coluna binaria
 
# SELECT DISTINCT node_caps FROM cap03.TB_DADOS
 

        
SELECT
	CASE
		WHEN node_caps = 'no' THEN 0 
		WHEN node_caps = 'yes' THEN 1
	END as node_caps # apelidando o select
FROM cap03.TB_DADOS
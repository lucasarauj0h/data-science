# Binarização da variavel classe
# Coluna binaria
 
# SELECT DISTINCT irradiando FROM cap03.TB_DADOS
 
SELECT
	CASE
		WHEN irradiando = 'no' THEN 0 
		WHEN irradiando = 'yes' THEN 1
	END as irradiando # apelidando o select
FROM cap03.TB_DADOS
        

# Binarização da variavel classe
# Coluna binaria
 
# SELECT DISTINCT seio FROM cap03.TB_DADOS

SELECT
	CASE
		WHEN seio = 'left' THEN 'E' 
		WHEN seio = 'right' THEN 'D'
	END as seio # apelidando o select
FROM cap03.TB_DADOS
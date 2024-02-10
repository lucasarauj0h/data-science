# Binarização da variavel classe
# Coluna binaria
 
# SELECT DISTINCT classe FROM cap03.TB_DADOS
 
SELECT
	CASE
		WHEN classe = 'no-recurrence-events' THEN 0 
		WHEN classe = 'recurrence-events' THEN 1
	END as classe
FROM cap03.TB_DADOS
        

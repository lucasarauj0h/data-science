# Label Encoding da variável quadrante (1,2,3,4,5)
SELECT DISTINCT quadrante FROM cap03.TB_DADOS;

SELECT 
	CASE 
		WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
	END as quadrante
FROM cap03.TB_DADOS;
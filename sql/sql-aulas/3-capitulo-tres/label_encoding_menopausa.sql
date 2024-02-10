#  [Desafio] Crie uma nova coluna chamada posicao_tumor concatenando as colunas inv_nodes e quadrante.
 
# SELECT DISTINCT menopausa FROM cap03.TB_DADOS;
CREATE TABLE cap03.TB_DADOS2
SELECT
	classe,
    idade,
	CASE
		WHEN menopausa = 'premeno' THEN 1
		WHEN menopausa = 'ge40' THEN 2
		WHEN menopausa = 'lt40' THEN 3
        
	END as menopausa, # apelidando o select
    tamanho_tumor,
    inv_nodes,
    node_caps,
    deg_malig,
    seio,
    quadrante,
    irradiando
FROM cap03.TB_DADOSquery
        

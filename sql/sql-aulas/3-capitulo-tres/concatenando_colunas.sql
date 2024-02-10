# [Desafio] Aplique One-Hot-Encoding à coluna deg_malig.

SELECT * FROM cap03.TB_DADOS4;
 
CREATE TABLE cap03.TB_DADOS4
SELECT
	classe,
    idade,
	menopausa,
    tamanho_tumor,
    posicao_tumor,
    node_caps,
    CASE WHEN deg_malig = 1 THEN 1 ELSE 0 END AS deg_malig_cat1,
    CASE WHEN deg_malig = 2 THEN 1 ELSE 0 END AS deg_malig_cat2,
    CASE WHEN deg_malig = 3 THEN 1 ELSE 0 END AS deg_malig_cat3,
    seio,
    irradiando
FROM cap03.TB_DADOS3
        

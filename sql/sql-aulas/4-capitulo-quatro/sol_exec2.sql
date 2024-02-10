# Solução Exercício 1

# Item 1
SELECT DISTINCT menopausa FROM cap03.TB_DADOS2;

CREATE TABLE cap03.TB_DADOS3
AS
SELECT
classe,
idade,
CASE
	WHEN menopausa = 'premeno' THEN 1
	WHEN menopausa = 'ge40' THEN 2
	WHEN menopausa = 'lt40' THEN 3
END as menopausa,
tamanho_tumor,
inv_nodes,
node_caps,
deg_malig,
seio,
quadrante,
irradiando
FROM cap03.TB_DADOS2;

# Item 2
SELECT * FROM cap03.TB_DADOS3;

CREATE TABLE cap03.TB_DADOS4
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
CONCAT(inv_nodes, '-' , quadrante) AS posição_tumor,
node_caps,
deg_malig,
seio,
irradiando
FROM cap03.TB_DADOS3;

# Item 3
SELECT * FROM cap03.TB_DADOS4;
SELECT DISTINCT deg_malig FROM cap03.TB_DADOS4;

CREATE TABLE cap03.TB_DADOS5
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
posição_tumor,
node_caps, 
CASE WHEN deg_malig = 1 THEN 1 ELSE 0 END AS deg_malig_cat1,
CASE WHEN deg_malig = 2 THEN 1 ELSE 0 END AS deg_malig_cat2,
CASE WHEN deg_malig = 3 THEN 1 ELSE 0 END AS deg_malig_cat3,
seio,
irradiando
FROM cap03.TB_DADOS4;









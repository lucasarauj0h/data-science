# Faturamento total por ano e país e total geral com agrupamento do resultado
SELECT
	IF(GROUPING(ano), 'Total de Todos os Anos', ano) AS ano,
	IF(GROUPING(pais), 'Total de Todos os Países', pais) AS pais,
	IF(GROUPING(produto), 'Total de Todos os Produtos', produto) AS produto,
	SUM(faturamento) faturamento 
FROM cap05.TB_VENDAS
GROUP BY ano, pais, produto WITH ROLLUP;
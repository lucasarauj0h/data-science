# Faturamento total por ano e pais

SELECT * FROM cap05.tb_vendas;

SELECT sum(faturamento) as faturamento, ano, pais FROM cap05.tb_vendas
GROUP BY ano, pais WITH ROLLUP # com total geral (p/ cada hierarquia)
ORDER BY pais DESC;
# Faturamento total por ano

SELECT * FROM cap05.tb_vendas;

SELECT sum(faturamento) as faturamento, ano FROM cap05.tb_vendas
GROUP BY ano WITH ROLLUP; # com total geral (p/ cada hierarquia)


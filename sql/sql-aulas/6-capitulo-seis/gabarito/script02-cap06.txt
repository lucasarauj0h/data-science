# Script 02

# Total de vendas por ano, por funcionário e total de vendas do ano
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;

# Total de vendas
SELECT SUM(valor_venda)
FROM cap06.TB_VENDAS;

# Total de vendas por ano, por funcionário e total de vendas geral
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER() total_vendas_geral
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;

# Número de vendas por ano, por funcionário e número total de vendas em todos os anos
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
    COUNT(*) OVER() num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;

# Reescrevendo a query anterior usando subquery
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
(SELECT COUNT(*) FROM cap06.TB_VENDAS) as num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;




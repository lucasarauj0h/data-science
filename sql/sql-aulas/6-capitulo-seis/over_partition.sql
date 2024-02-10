SELECT * FROM cap06.tb_vendas;
# Total de vendas por ano, por funcionário e total de vendas do ano
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;
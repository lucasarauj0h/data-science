SELECT * FROM cap06.tb_vendas;
# Total de vendas por ano, por funcionário e total de vendas do ano
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER () total_vendas # Calculando a soma cumulativa a partir da coluna selecionada, nesse caso o over é o total de valor venda
FROM cap06.TB_VENDAS
ORDER BY nome_funcionario;
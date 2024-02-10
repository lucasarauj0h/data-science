SELECT * FROM cap06.tb_vendas;
# Número de vendas por ano, por funcionário e número total de vendas em todos os anos
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
    COUNT(*) OVER() num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;

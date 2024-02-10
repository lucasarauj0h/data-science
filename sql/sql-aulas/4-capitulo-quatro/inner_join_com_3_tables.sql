# Query para retornar o id do pedido, e o nome do cliente
# Inner Join

SELECT * FROM cap04.tb_clientes;
    
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor # Selecione da tabela P, C e V (nomeadas abaixo)
FROM cap04.tb_pedidos AS P
INNER JOIN cap04.tb_clientes AS C ON P.id_cliente = C.id_cliente # Entre na coluna tb_clientes e chame-a de C -> retorne os valores onde a condição for verdadeira
INNER JOIN cap04.tb_vendedor AS V ON P.id_vendedor = V.id_vendedor;  # Entre na coluna tb_vendedor e chame-a de V -> retorne os valores onde a condição for verdadeira
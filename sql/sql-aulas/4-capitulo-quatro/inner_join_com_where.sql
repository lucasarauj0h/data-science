# Query para retornar o id do pedido, e o nome do cliente
# Inner Join

SELECT * FROM cap04.tb_clientes;

SELECT P.id_pedido, C.nome_cliente # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P, cap04.tb_clientes AS C # Renomenado as colunas
WHERE P.id_pedido = C.id_cliente # Retorne os dados aonde a comparação for verdadeira
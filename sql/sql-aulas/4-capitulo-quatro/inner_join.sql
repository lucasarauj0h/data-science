# Query para retornar o id do pedido, e o nome do cliente
# Inner Join

SELECT * FROM cap04.tb_clientes;

SELECT P.id_pedido, C.nome_cliente # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P # nomeando a coluna
INNER JOIN cap04.tb_clientes AS C # Entre na coluna tb_clientes e chame-a de C
	ON P.id_pedido = C.id_cliente # Retorne os dados aonde a comparação for verdadeira
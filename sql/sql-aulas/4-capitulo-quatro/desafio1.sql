# Retorne a data do pedido, o nome do cliente, todos os vendedores, com ou sem venda associada, e ordernar o resultado pelo nome do cliente 
# LEFT JOIN -> Indica que queremos todos os dados da tabela da esquerda mesmo sem correspondentes na esquerda


SELECT 
	CASE 
		WHEN P.data_pedido IS NULL THEN "Sem Pedido"
			ELSE P.data_pedido
	END AS data_pedido,
	CASE 
		WHEN C.nome_cliente IS NULL THEN "Sem Pedido"
			ELSE C.nome_cliente
	END AS nome_cliente,
	V.nome_vendedor
FROM cap04.tb_vendedor AS V # FROM é a Tabela da Esquerda
LEFT JOIN cap04.tb_pedidos AS P
USING(id_vendedor)
LEFT JOIN cap04.tb_clientes AS C USING(id_cliente)
ORDER BY nome_cliente; 
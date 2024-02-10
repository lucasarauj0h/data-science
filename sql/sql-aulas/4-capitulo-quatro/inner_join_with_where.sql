# Query para retornar o id do pedido, nome do cliente e o nome do vendedor
# where

SELECT * FROM cap04.tb_clientes;
    
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor # Selecione da tabela P, C e V (nomeadas abaixo)
FROM cap04.tb_pedidos AS P, cap04.tb_clientes AS C, cap04.tb_vendedor AS V
WHERE  P.id_cliente = C.id_cliente 
	AND P.id_vendedor = V.id_vendedor;

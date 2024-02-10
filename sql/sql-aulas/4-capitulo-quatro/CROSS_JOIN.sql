# CROSS JOIN
SELECT C.nome_cliente, P.id_pedido
FROM cap04.tb_clientes C
CROSS JOIN cap04.tb_pedidos P  # Para cada cliente da tab a esquerda, traga todos os pedidos (join)
# Soma dos pedidos
SELECT SUM(valor_pedido) AS total
FROM cap05.tb_pedidos;

# Soma dos pedidos por cidade
SELECT SUM(valor_pedido) AS total, cidade_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C
WHERE  C.id_cliente = P.id_cliente
GROUP BY cidade_cliente;
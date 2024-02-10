# Soma dos pedidos
SELECT SUM(valor_pedido) AS total
FROM cap05.tb_pedidos;

# Soma dos pedidos por cidade
SELECT SUM(valor_pedido) AS total, cidade_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C
WHERE  C.id_cliente = P.id_cliente
GROUP BY cidade_cliente;

# Soma dos pedidos por estado
SELECT SUM(valor_pedido) AS total, estado_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C
WHERE  C.id_cliente = P.id_cliente
GROUP BY estado_cliente;

# Soma (total) do valor dos pedidos por cidade e estado
SELECT SUM(valor_pedido) AS total, cidade_cliente, estado_cliente
FROM cap05.TB_PEDIDOS P, cap05.TB_CLIENTES C
WHERE P.id_cliente = C.id_cliente
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;
# Número de pedidos de clientes do CE

SELECT COUNT(P.id_cliente) AS qntd_pedidos
FROM cap05.tb_pedidos P, cap05.tb_clientes C
WHERE P.id_cliente = C.id_cliente AND estado_cliente = 'CE'
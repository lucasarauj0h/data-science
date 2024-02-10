# Numero de clientes que fizeram pedidos

SELECT count(DISTINCT id_cliente) AS qntd_clientes FROM cap05.tb_pedidos;
# Soma(total) do valor dos pedidos por cidade e estado com RIGHT JOIN e CASE
SELECT 
	CASE 
		WHEN FLOOR(SUM(valor_pedido)) IS NULL THEN 0
		ELSE FLOOR(SUM(valor_pedido))
	end AS total, 
	cidade_cliente, 
	estado_cliente
FROM cap05.TB_PEDIDOS P RIGHT JOIN cap05.TB_CLIENTES C
ON P.id_cliente = C.id_cliente
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;
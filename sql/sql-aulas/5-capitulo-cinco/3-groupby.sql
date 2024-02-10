# calcule a media de valor_pedido 
SELECT AVG(valor_pedido) as media FROM cap05.tb_pedidos;

# calcule a media de valor_pedido por cidade mesmo que não tenha compra
SELECT 
	CASE
		WHEN ROUND(AVG(valor_pedido),2) IS NULL THEN 0
        ELSE ROUND(AVG(valor_pedido),2)
	END as media, 
        cidade_cliente
FROM cap05.tb_pedidos P
RIGHT JOIN cap05.tb_clientes AS C ON P.id_cliente = C.id_cliente # realizando join
GROUP BY cidade_cliente # agrupe por cidade_cliente
ORDER BY media DESC;
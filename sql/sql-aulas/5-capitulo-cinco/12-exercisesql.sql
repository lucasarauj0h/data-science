# Algum vendedor participou de vendas em que a média do valor_pedido por estado do cliente foi superior a 800?

# Agregação feita no group by, precisa ser após o group by usando having
SELECT estado_cliente, nome_vendedor, CEILING(AVG(valor_pedido)) AS media
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_vendedor V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor	
GROUP BY estado_cliente, nome_vendedor
HAVING media > 800
ORDER BY nome_vendedor

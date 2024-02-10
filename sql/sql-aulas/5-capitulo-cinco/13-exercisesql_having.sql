# Qual estado teve mais de 5 pedidos?

# Agregação feita no group by, precisa ser após o group by usando having
SELECT estado_cliente, COUNT(P.id_pedido) AS contagem
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_vendedor V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor	
GROUP BY estado_cliente
HAVING contagem >= 5
ORDER BY contagem DESC;
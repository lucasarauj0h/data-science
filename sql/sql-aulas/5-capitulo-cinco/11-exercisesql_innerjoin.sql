# Algum vendedor participou de vendas cujo valor pedido tenha sido superior a 600 no estado de SP?

SELECT nome_cliente, cidade_cliente, valor_pedido, nome_vendedor
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'SP' 
AND valor_pedido > 600
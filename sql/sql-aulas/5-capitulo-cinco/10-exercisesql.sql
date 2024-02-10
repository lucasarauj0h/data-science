# Algum vendedor participou de vendas cujo valor pedido tenha sido superior a 600 no estado de SP?

SELECT valor_pedido, nome_vendedor, estado_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C, cap05.tb_vendedor V
WHERE P.id_cliente = C.id_cliente AND estado_cliente = 'SP' AND P.id_vendedor = V.id_vendedor AND valor_pedido > 600
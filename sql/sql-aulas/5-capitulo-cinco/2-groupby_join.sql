# calcule a media de valor_pedido 
SELECT AVG(valor_pedido) as media FROM cap05.tb_pedidos;

# calcule a media de valor_pedido por cidade
SELECT ROUND(AVG(valor_pedido),2) as media, cidade_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C 
WHERE P.id_cliente = C.id_cliente # realizando join
GROUP BY cidade_cliente # agrupe por cidade_cliente
ORDER BY media DESC;

# com inner join 
SELECT ROUND(AVG(valor_pedido),2) as media, cidade_cliente
FROM cap05.tb_pedidos P
JOIN cap05.tb_clientes AS C ON P.id_cliente = C.id_cliente # realizando join
GROUP BY cidade_cliente # agrupe por cidade_cliente
ORDER BY media DESC;
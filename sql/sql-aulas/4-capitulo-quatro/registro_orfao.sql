# Vamos inserir um registro na tabela de pedidos que será "órfão" e queremos retornar todos os dados de ambas as tabelas mesmo sem correspondência
INSERT INTO `cap04`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`)
VALUES (1004, 10, 6, now(), 23);

# Left Join
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
LEFT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Right Join
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
RIGHT OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;


# Full Outer Join (alguns SGBDs não implementam essa junção)
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C 
FULL OUTER JOIN cap04.TB_PEDIDOS AS P 
ON C.id_cliente = P.id_cliente;
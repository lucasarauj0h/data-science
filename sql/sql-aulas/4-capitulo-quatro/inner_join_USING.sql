# Query para retornar o id do pedido e o nome do cliente 
# Inner Join
    
SELECT P.id_pedido, C.nome_cliente  # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P
INNER JOIN cap04.tb_clientes AS C ON P.id_cliente = C.id_cliente;

# Quando busco fazer intersecção, não há problema em retirar o inner (significa intersecção)
SELECT P.id_pedido, C.nome_cliente  # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P
JOIN cap04.tb_clientes AS C ON P.id_cliente = C.id_cliente;

# Quando as colunas tem o mesmo nome em ambas as tabelas (como nosso caso) não é necessário o comparador, desde que use a clausula USING
SELECT P.id_pedido, C.nome_cliente  # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P
JOIN cap04.tb_clientes AS C
USING(id_cliente);
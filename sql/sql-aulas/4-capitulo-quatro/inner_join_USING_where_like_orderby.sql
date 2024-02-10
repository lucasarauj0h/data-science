# Query para retornar o id do pedido e o nome do cliente 
# Inner Join com WHERE e ORDER BY

SELECT P.id_pedido, C.nome_cliente  # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P
JOIN cap04.tb_clientes AS C
USING(id_cliente)
WHERE C.nome_cliente LIKE 'Bob%' # LIKE -> Onde o texto contenha BOB % > (pós a % não importa o valor)
ORDER BY P.id_pedido DESC; # DESC -> Decrescente 

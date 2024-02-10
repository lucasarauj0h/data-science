# Quero retornar todos os clientes com ou sem pedidos associados 
# LEFT JOIN -> Indica que queremos todos os dados da tabela da esquerda mesmo sem correspondentes na esquerda


SELECT C.nome_cliente, P.id_pedido # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_clientes AS C # FROM é a Tabela da Esquerda
LEFT JOIN cap04.tb_pedidos AS P
USING(id_cliente);

# INVERTENDO AS ORDENS DAS COLUNAS

SELECT C.nome_cliente, P.id_pedido # Selecione da tabela P e C (nomeadas abaixo)
FROM cap04.tb_pedidos AS P # FROM é a Tabela da Esquerda
LEFT JOIN cap04.tb_clientes AS C
USING(id_cliente)
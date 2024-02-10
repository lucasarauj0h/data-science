# Inserir mais um registro na tabela de clientes
INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (6, "Madona", "Rua 45", "Campos", "RJ");

# Retornar clientes que sejam da mesma cidade
SELECT A.nome_cliente, B.cidade_cliente
FROM cap04.tb_clientes A, cap04.tb_clientes B
WHERE A.id_cliente <> B.id_cliente # ID's diferentes
	AND A.cidade_cliente = B.cidade_cliente # Cidades iguais
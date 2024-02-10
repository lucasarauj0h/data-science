SELECT COUNT(id_cliente) AS contagem, cidade_cliente # Fazendo a contagem de id_cliente, exibindo a cidade_cliente
FROM cap05.tb_clientes
GROUP BY cidade_cliente # agrupando a contagem por cidade_cliente
ORDER BY contagem DESC;
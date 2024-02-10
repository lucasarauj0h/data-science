# Script 07 - C

CREATE TABLE cap08.TB_CLIENTES_LOC (
  nome_cliente text,
  faturamento double DEFAULT NULL,
  numero_funcionarios int DEFAULT NULL
);

# Carregue o dataset5.csv na tabela anterior a partir do MySQL Workbench

CREATE TABLE cap08.TB_CLIENTES_INT (
  nome_cliente text,
  faturamento double DEFAULT NULL,
  numero_funcionarios int DEFAULT NULL,
  localidade_sede text
);

# Carregue o dataset6.csv na tabela anterior a partir do MySQL Workbench

SELECT * FROM cap08.TB_CLIENTES_LOC;
SELECT * FROM cap08.TB_CLIENTES_INT;

# Retornar todos os clientes e suas localidades. Clientes locais estão nos EUA.

# Erro:
SELECT A.nome_cliente, A.localidade_sede AS localidade_sede
FROM cap08.TB_CLIENTES_INT AS A
UNION
SELECT B.nome_cliente
FROM cap08.TB_CLIENTES_LOC AS B;

# Correto:
SELECT A.nome_cliente, A.localidade_sede AS localidade_sede
FROM cap08.TB_CLIENTES_INT AS A
UNION
SELECT B.nome_cliente, "USA" AS localidade_sede
FROM cap08.TB_CLIENTES_LOC AS B;

# O cliente 'Ganjaflex' aparece nas duas tabelas de clientes?
SELECT nome_cliente, faturamento, localidade_sede 
FROM cap08.TB_CLIENTES_INT 
WHERE nome_cliente = 'Ganjaflex'
UNION
SELECT nome_cliente, faturamento, 'USA' AS localidade_sede 
FROM cap08.TB_CLIENTES_LOC 
WHERE nome_cliente = 'Ganjaflex'; 

# Quais os clientes internacionais que aparecem na tabela de clientes locais?
SELECT nome_cliente
FROM cap08.TB_CLIENTES_INT
WHERE nome_cliente IN (SELECT nome_cliente FROM cap08.TB_CLIENTES_LOC);

SELECT nome_cliente
FROM cap08.TB_CLIENTES_INT
WHERE TRIM(nome_cliente) IN (SELECT TRIM(nome_cliente) FROM cap08.TB_CLIENTES_LOC);

# Qual a média de faturamento por localidade? 
# Os clientes locais estão nos EUA e o resultado deve ser ordenado pela média de faturamento
SELECT ROUND(AVG(A.faturamento),2) AS media_faturamento, A.localidade_sede AS localidade_sede
FROM cap08.TB_CLIENTES_INT AS A
GROUP BY localidade_sede
UNION
SELECT ROUND(AVG(B.faturamento),2) AS media_faturamento, "USA" AS localidade_sede
FROM cap08.TB_CLIENTES_LOC AS B
GROUP BY localidade_sede
ORDER BY media_faturamento;

# Use as tabelas TB_PIPELINE_VENDAS e TB_VENDEDORES
# Retorne o total do valor de venda de todos os agentes de vendas e os sub-totais por escritório regional
# Retorne o resultado somente das vendas concluídas com sucesso
SELECT COALESCE(B.regional_office, "Total") AS "Escritório Regional",
       COALESCE(A.sales_agent, "Total") AS "Agente de Vendas",
       SUM(A.close_value) AS Total
FROM cap08.TB_PIPELINE_VENDAS AS A, cap08.TB_VENDEDORES AS B
WHERE A.sales_agent = B.sales_agent
AND A.deal_stage = "Won"
GROUP BY B.regional_office, A.sales_agent WITH ROLLUP;

# Use as tabelas TB_PIPELINE_VENDAS e TB_VENDEDORES
# Retorne o gerente, o escritório regional, o cliente, o número de vendas e os sub-totais do número de vendas 
# Faça isso apenas para as vendas concluídas com sucesso
SELECT COALESCE(A.manager, "Total") AS Gerente,
       COALESCE(A.regional_office, "Total") AS "Escritório Regional",
       COALESCE(B.account, "Total") AS Cliente,
       COUNT(B.close_value) AS numero_vendas
FROM cap08.TB_VENDEDORES AS A, cap08.TB_PIPELINE_VENDAS AS B
WHERE (B.sales_agent = A.sales_agent)
AND deal_stage = "Won"
GROUP BY A.manager, A.regional_office, B.account WITH ROLLUP;

# Nível Ninja das Galáxias :)
# Use as tabelas TB_PIPELINE_VENDAS e TB_VENDEDORES
# Retorne o gerente, o escritório regional, o cliente, o número de vendas e os sub-totais do número de vendas 
# Faça isso apenas para as vendas concluídas com sucesso
# Use CTE
WITH temp_table AS 
(
SELECT A.manager,
       A.regional_office,
       B.account,
       B.deal_stage
FROM cap08.TB_VENDEDORES AS A, cap08.TB_PIPELINE_VENDAS AS B
WHERE (B.sales_agent = A.sales_agent)
)
SELECT COALESCE(manager, "Total") AS Gerente, 
       COALESCE(regional_office, "Total") AS "Escritório Regional",
       COALESCE(account, "Total") AS Cliente,
       COUNT(*) AS numero_vendas
FROM temp_table
WHERE deal_stage = "Won"
GROUP BY manager, regional_office, account WITH ROLLUP;

CREATE TABLE cap08.TB_PEDIDOS_PRODUTOS (
  sales_agent text,
  account text,
  product text,
  order_value int DEFAULT NULL,
  create_date text
);

# Carregue o dataset7.csv na tabela anterior a partir do MySQL Workbench

SELECT * FROM cap08.TB_PEDIDOS_PRODUTOS ORDER BY account;

SELECT * 
FROM cap08.TB_PEDIDOS_PRODUTOS 
WHERE account = 'Acme Corporation'
ORDER BY CAST(create_date AS DATE);

SELECT account, 
       CAST(create_date AS DATE) AS data_pedido, 
       ROUND(AVG(order_value),2) AS media_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
GROUP BY account, data_pedido
ORDER BY data_pedido;

SELECT account, 
       CAST(create_date AS DATE) AS data_pedido,
       AVG(order_value) OVER() AS media_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
ORDER BY data_pedido;

SELECT account, 
       CAST(create_date AS DATE) AS data_pedido,
       AVG(order_value) OVER(PARTITION BY account ORDER BY CAST(create_date AS DATE)) AS media_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
ORDER BY data_pedido;

SELECT account, 
       CAST(create_date AS DATE) AS data_pedido,
       order_value, 
       FIRST_VALUE(order_value) OVER (PARTITION BY account ORDER BY CAST(create_date AS DATE)) AS primeira_media_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
ORDER BY data_pedido;

SELECT account, 
       CAST(create_date AS DATE) AS data_pedido,
       order_value, 
       LEAD(order_value, 1, -1) OVER (PARTITION BY account ORDER BY CAST(create_date AS DATE)) AS lead_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
ORDER BY data_pedido;

SELECT account, 
       CAST(create_date AS DATE) AS data_pedido,
       order_value, 
       LAG(order_value, 1, -1) OVER (PARTITION BY account ORDER BY CAST(create_date AS DATE)) AS lag_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
ORDER BY data_pedido;

# Nível Ninja das Galáxias :)
# Calcule a diferença entre o valor do pedido do dia e do dia anterior.
WITH temp_table AS 
(
SELECT account, 
       CAST(create_date AS DATE) AS data_pedido,
       order_value, 
       LAG(order_value, 1, 0) OVER (PARTITION BY account ORDER BY CAST(create_date AS DATE)) AS lag_valor_pedido
FROM cap08.TB_PEDIDOS_PRODUTOS
WHERE account = 'Acme Corporation'
ORDER BY data_pedido
)
SELECT account,
       data_pedido,
       order_value,
       lag_valor_pedido,
       (order_value - lag_valor_pedido) AS diff
FROM temp_table;












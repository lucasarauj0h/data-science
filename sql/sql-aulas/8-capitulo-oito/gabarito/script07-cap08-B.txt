# Script 07 - B

# Cria a tabela
CREATE TABLE cap08.TB_PIPELINE_VENDAS (
  `Account` text,
  `Opportunity_ID` text,
  `Sales_Agent` text,
  `Deal_Stage` text,
  `Product` text,
  `Created_Date` text,
  `Close_Date` text,
  `Close_Value` text DEFAULT NULL
);

# Carregue o dataset3.csv na tabela anterior a partir do MySQL Workbench

# Cria a tabela
CREATE TABLE cap08.TB_VENDEDORES (
  `Sales_Agent` text,
  `Manager` text,
  `Regional_Office` text,
  `Status` text
);

# Carregue o dataset4.csv na tabela anterior a partir do MySQL Workbench

# 1- Total de vendas
SELECT COUNT(*) 
FROM cap08.TB_PIPELINE_VENDAS;

# 2- Valor total vendido
SELECT SUM(close_value) AS total_valor_venda
FROM cap08.TB_PIPELINE_VENDAS;

SELECT SUM(CAST(close_value AS UNSIGNED)) AS total_valor_venda
FROM cap08.TB_PIPELINE_VENDAS;

# 3- Número de vendas concluídas com sucesso
SELECT COUNT(*) AS num_vendas_sucesso
FROM cap08.TB_PIPELINE_VENDAS
WHERE deal_stage = "Won";
 
# 4- Média do valor das vendas concluídas com sucesso
SELECT ROUND(AVG(CAST(close_value AS UNSIGNED)),2) AS media
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won";

# 5- Valos máximo vendido
SELECT MAX(CAST(close_value AS UNSIGNED)) AS valor_maximo
FROM cap08.TB_PIPELINE_VENDAS;

# 6- Valor mínimo vendido entre as vendas concluídas com sucesso
SELECT MIN(CAST(close_value AS UNSIGNED)) AS valor_minimo
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won";

# 7- Valor médio das vendas concluídas com sucesso por agente de vendas
SELECT sales_agent, ROUND(AVG(CAST(close_value AS UNSIGNED)),2) AS valor_medio
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY sales_agent
ORDER BY valor_medio DESC;
 
# 8- Valor médio das vendas concluídas com sucesso por gerente do agente de vendas
SELECT tbl1.manager, ROUND(AVG(CAST(tbl2.close_value AS UNSIGNED)),2) AS valor_medio
FROM cap08.TB_VENDEDORES AS tbl1
JOIN cap08.TB_PIPELINE_VENDAS AS tbl2 ON (tbl1.sales_agent = tbl2.sales_agent)
WHERE tbl2.deal_stage = "Won"
GROUP BY tbl1.manager;

# 9- Total do valor de fechamento da venda por agente de venda e por conta das vendas concluídas com sucesso
SELECT sales_agent, account, SUM(CAST(close_value AS UNSIGNED)) AS total
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY sales_agent, account
ORDER BY sales_agent, account;

# 10- Número de vendas por agente de venda para as vendas concluídas com sucesso e valor de venda superior a 1000

# Há uma função para filtro chamada FILTER(), mas que não está disponível no MySQL
# https://modern-sql.com/feature/filter

# ! Não funciona no MySQL
SELECT sales_agent,
       COUNT(tbl.close_value) AS total,
       COUNT(tbl.close_value)
FILTER(WHERE tbl.close_value > 1000) AS `Acima de 1000`
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY tbl.sales_agent;

# Solução no MySQL
SELECT sales_agent,
       COUNT(tbl.close_value) AS total
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
AND tbl.close_value > 1000
GROUP BY tbl.sales_agent;
 
# 11- Número de vendas e a média do valor de venda por agente de vendas
SELECT sales_agent,
       COUNT(tbl.close_value) AS contagem,
       ROUND(AVG(CAST(tbl.close_value AS UNSIGNED)),2) AS media
FROM cap08.TB_PIPELINE_VENDAS AS tbl
GROUP BY tbl.sales_agent
ORDER BY contagem DESC;

# 12- Quais agentes de vendas tiveram mais de 30 vendas?
SELECT sales_agent,
       COUNT(tbl.close_value) AS num_vendas_sucesso
FROM cap08.TB_PIPELINE_VENDAS AS tbl
GROUP BY tbl.sales_agent
HAVING COUNT(tbl.close_value) > 30;




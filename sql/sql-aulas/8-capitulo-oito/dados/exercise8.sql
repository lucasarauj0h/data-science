# Script 07 - A

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

# Responda os itens abaixo com Linguagem SQL
SELECT * FROM cap08.tb_vendedores;
SELECT * FROM cap08.tb_pipeline_vendas;

# 1- Total de vendas
SELECT COUNT(*) as qntd_vendas FROM cap08.tb_pipeline_vendas;

# 2- Valor total vendido
SELECT SUM(CAST(close_value AS UNSIGNED)) as valor_total_vendas FROM cap08.tb_pipeline_vendas;

# 3- Número de vendas concluídas com sucesso
SELECT COUNT(*) as qntd_vendas, Deal_Stage AS stage
FROM cap08.tb_pipeline_vendas
GROUP BY stage;

# 4- Média do valor das vendas concluídas com sucesso
SELECT ROUND(AVG(CAST(close_value AS UNSIGNED)),2) as media_vendas, Deal_Stage AS stage
FROM cap08.tb_pipeline_vendas
GROUP BY stage
HAVING stage = 'Won';

# 5- Valos máximo vendido
SELECT MAX(CAST(close_value AS UNSIGNED)) as max_vendido FROM cap08.tb_pipeline_vendas;

# 6- Valor mínimo vendido entre as vendas concluídas com sucesso
SELECT MIN(CAST(close_value AS UNSIGNED)) as valor_total_vendas 
FROM cap08.tb_pipeline_vendas
WHERE Deal_Stage = "Won";

# 7- Valor médio das vendas concluídas com sucesso por agente de vendas
SELECT ROUND(AVG(CAST(close_value AS UNSIGNED)),2) as media_vendas, Sales_Agent, Deal_Stage
FROM cap08.tb_pipeline_vendas
GROUP BY Sales_Agent, Deal_Stage
HAVING Deal_Stage = 'Won';

# 8- Valor médio das vendas concluídas com sucesso por gerente do agente de vendas
SELECT ROUND(AVG(CAST(close_value AS UNSIGNED)),2) as media_vendas, Manager, Deal_Stage
FROM cap08.tb_pipeline_vendas P
JOIN cap08.TB_VENDEDORES V ON V.Sales_Agent = P.Sales_Agent 
GROUP BY Manager, Deal_Stage
HAVING Deal_Stage = 'Won';

# 9- Total do valor de fechamento da venda por agente de venda e por conta das vendas concluídas com sucesso
SELECT SUM(CAST(close_value AS UNSIGNED)) AS total, sales_agent, account
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY sales_agent, account
ORDER BY sales_agent, account;

# 10- Número de vendas por agente de venda para as vendas concluídas com sucesso e valor de venda superior a 1000
SELECT sales_agent, COUNT(close_value) AS qntd_vendas
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won" AND CAST(close_value AS UNSIGNED) > 1000
GROUP BY sales_agent
ORDER BY sales_agent;

# 11- Número de vendas e a média do valor de venda por agente de vendas
SELECT sales_agent, COUNT(close_value) AS qntd_vendas, ROUND(AVG(CAST(close_value AS UNSIGNED)),2) as media_valor
FROM cap08.TB_PIPELINE_VENDAS AS tbl
GROUP BY sales_agent
ORDER BY sales_agent;


# 12- Quais agentes de vendas tiveram mais de 30 vendas?
SELECT sales_agent, COUNT(close_value) AS qntd_vendas, ROUND(AVG(CAST(close_value AS UNSIGNED)),2) as media_valor
FROM cap08.TB_PIPELINE_VENDAS AS tbl
GROUP BY sales_agent
HAVING count(tbl.sales_agent) > 30
ORDER BY sales_agent;


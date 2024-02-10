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

# 1- Total de vendas

# 2- Valor total vendido

# 3- Número de vendas concluídas com sucesso

# 4- Média do valor das vendas concluídas com sucesso

# 5- Valos máximo vendido

# 6- Valor mínimo vendido entre as vendas concluídas com sucesso

# 7- Valor médio das vendas concluídas com sucesso por agente de vendas

# 8- Valor médio das vendas concluídas com sucesso por gerente do agente de vendas

# 9- Total do valor de fechamento da venda por agente de venda e por conta das vendas concluídas com sucesso

# 10- Número de vendas por agente de venda para as vendas concluídas com sucesso e valor de venda superior a 1000

# 11- Número de vendas e a média do valor de venda por agente de vendas

# 12- Quais agentes de vendas tiveram mais de 30 vendas?

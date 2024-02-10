# Script 01

CREATE SCHEMA `cap06` ;

CREATE TABLE cap06.TB_VENDAS (
    nome_funcionario VARCHAR(50) NOT NULL,
    ano_fiscal INT NOT NULL,
    valor_venda DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(nome_funcionario,ano_fiscal)
);

INSERT INTO cap06.TB_VENDAS(nome_funcionario, ano_fiscal, valor_venda)
VALUES('Romario',2020,2000),
      ('Romario',2021,2500),
      ('Romario',2022,3000),
      ('Zico',2020,1500),
      ('Zico',2021,1000),
      ('Zico',2022,2000),
	  ('Pele',2020,2000),
      ('Pele',2021,1500),
      ('Pele',2022,2500);

# Total de vendas
SELECT SUM(valor_venda)
FROM cap06.TB_VENDAS;

# Total de vendas por ano fiscal
SELECT ano_fiscal, SUM(valor_venda) total_venda
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal
ORDER BY ano_fiscal;

# Total de vendas por funcionário
SELECT nome_funcionario, SUM(valor_venda) total_venda
FROM cap06.TB_VENDAS
GROUP BY nome_funcionario
ORDER BY nome_funcionario;

# Total de vendas por funcionário, por ano
SELECT ano_fiscal, nome_funcionario, SUM(valor_venda) total_venda
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;

# Total de vendas por ano, por funcionário e total de vendas do ano
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;

# Essa query não faria muito sentido
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) total_vendas,
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario, valor_venda
ORDER BY ano_fiscal;

# Total de vendas por ano, por funcionário e total de vendas do funcionário
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER (PARTITION BY nome_funcionario) total_vendas_func
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;





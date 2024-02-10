# Script 04

# Este script trata da transformação dos dados de uma tabela, de linhas em colunas. 
# Essa transformação é chamada de tabelas dinâmicas (ou pivot table). 
# Frequentemente, o resultado do pivô é uma tabela de resumo na qual os dados estatísticos são apresentados na forma adequada 
# ou exigida para um relatório.

# Exemplo 1
CREATE TABLE cap08.TB_GESTORES( id INT, colID INT, nome CHAR(20) );

INSERT INTO cap08.TB_GESTORES VALUES
  (1, 1, 'Bob'),
  (1, 2, 'Silva'),
  (1, 3, 'Office Manager'),
  (2, 1, 'Mary'),
  (2, 2, 'Luz'),
  (2, 3, 'Vice Presidente');

SELECT 
  id, 
  GROUP_CONCAT( if(colID = 1, nome, NULL) ) AS 'nome',
  GROUP_CONCAT( if(colID = 2, nome, NULL) ) AS 'sobrenome',
  GROUP_CONCAT( if(colID = 3, nome, NULL) ) AS 'titulo'
FROM cap08.TB_GESTORES
GROUP BY id;

# Exemplo 2
CREATE TABLE cap08.TB_RECURSOS ( emp varchar(8), recurso varchar(8), quantidade int );

INSERT INTO cap08.TB_RECURSOS VALUES
  ('Mary', 'email', 5),
  ('Bob', 'email', 7),
  ('Juca', 'print', 2),
  ('Mary', 'sms', 14),
  ('Bob', 'sms', 2);

SELECT 
  emp,
  SUM( if(recurso = 'email', quantidade, 0) ) AS 'emails',
  SUM( if(recurso = 'print', quantidade, 0) ) AS 'printings',
  SUM( if(recurso = 'sms', quantidade, 0) )   AS 'sms msgs'
FROM cap08.TB_RECURSOS
GROUP BY emp;

SELECT 
  emp,
  GROUP_CONCAT( if(recurso = 'email', quantidade, 0) ) AS 'emails',
  GROUP_CONCAT( if(recurso = 'print', quantidade, 0) ) AS 'printings',
  GROUP_CONCAT( if(recurso = 'sms', quantidade, 0) )   AS 'sms msgs'
FROM cap08.TB_RECURSOS
GROUP BY emp;

# Exemplo 3
CREATE TABLE cap08.TB_VENDAS (empID INT, ano SMALLINT, valor_venda DECIMAL(10,2));

INSERT cap08.TB_VENDAS VALUES
(1, 2020, 12000),
(1, 2021, 18000),
(1, 2022, 25000),
(2, 2021, 15000),
(2, 2022, 6000),
(3, 2021, 20000),
(3, 2022, 24000);

SELECT                                
    COALESCE(EmpID, 'Total') AS EmpID,
    SUM( IF(ano = 2020, valor_venda, 0) ) As '2020',
    SUM( IF(ano = 2021, valor_venda, 0) ) As '2021',
    SUM( IF(ano = 2022, valor_venda, 0) ) As '2022'
FROM cap08.TB_VENDAS
GROUP BY EmpID WITH ROLLUP;

# Exemplo 4
CREATE TABLE cap08.TB_PEDIDOS (
  id_pedido INT NOT NULL,
  id_funcionario INT NOT NULL,
  id_fornecedor INT NOT NULL,
  PRIMARY KEY (id_pedido)
);

INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (1, 258, 1580);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (2, 254, 1496);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (3, 257, 1494);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (4, 261, 1650);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (5, 251, 1654);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (6, 253, 1664);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (7, 255, 1678);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (8, 256, 1616);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (9, 259, 1492);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (10, 250, 1602);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (11, 258, 1540);

SELECT
  id_fornecedor,
  COUNT(IF(id_funcionario = 250, id_pedido, NULL)) AS Emp250,
  COUNT(IF(id_funcionario = 251, id_pedido, NULL)) AS Emp251,
  COUNT(IF(id_funcionario = 252, id_pedido, NULL)) AS Emp252,
  COUNT(IF(id_funcionario = 253, id_pedido, NULL)) AS Emp253,
  COUNT(IF(id_funcionario = 254, id_pedido, NULL)) AS Emp254
FROM
  cap08.TB_PEDIDOS p
WHERE
  p.id_funcionario BETWEEN 250 AND 254
GROUP BY
  id_fornecedor;



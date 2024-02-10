# Tratamento de valor ausente

SELECT DISTINCT Resolution
FROM cap08.TB_INCIDENTES;

SELECT Resolution, COUNT(*) AS total
FROM cap08.TB_INCIDENTES
GROUP BY Resolution;

SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE Resolution IS NULL;

SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE Resolution = '';

# Null é o tipo unknown no banco de dados e empty (vazio) é o nulo em uma coluna do tipo string.
# O empty também é chamado de blank.

# A principal diferença entre nulo e vazio é que o nulo é usado para se referir a nada, enquanto o vazio é usado para 
# se referir a uma string única com comprimento zero.

SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE NULLIF(Resolution, '') IS NULL; # Convertendo o vazio para nulo 

SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE TRIM(COALESCE(Resolution, '')) = '';

SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES 
WHERE LENGTH(RTRIM(LTRIM(Resolution))) = 0;

SELECT ISNULL(NULLIF(Resolution,''))  
FROM cap08.TB_INCIDENTES;

SELECT 
    CASE 
     WHEN Resolution = '' THEN 'OTHER'
     ELSE Resolution
    END AS Resolution
FROM cap08.TB_INCIDENTES;

# Resolvendo problema na fonte

SET SQL_SAFE_UPDATES = 0;

UPDATE cap08.TB_INCIDENTES
SET Resolution = 'OTHER'
WHERE Resolution = '';

SET SQL_SAFE_UPDATES = 1;

# Script 02

# Cria a tabela
CREATE TABLE cap08.TB_CRIANCAS(nome varchar(20), idade int, peso float);

# Insere os dados
INSERT INTO cap08.TB_CRIANCAS 
VALUES ('Bob', 3, 15), ('Maria', 42, 98), ('Julia', 3, 16), ('Maximiliano', 2, 12), ('Roberto', 1, 11), ('Jamil', 2, 14), ('Alberto', 3, 17);

SELECT * FROM cap08.TB_CRIANCAS;

SELECT AVG(idade) AS media_idade, STDDEV(idade) AS desvio_padrao_idade
FROM cap08.TB_CRIANCAS;

SELECT AVG(idade) AS media_idade, STDDEV(idade) AS desvio_padrao_idade 
FROM cap08.TB_CRIANCAS 
WHERE idade < 5;

SELECT AVG(peso) AS media_peso, STDDEV(peso) AS desvio_padrao_peso
FROM cap08.TB_CRIANCAS;

SELECT AVG(peso) AS media_peso, STDDEV(peso) AS desvio_padrao_peso 
FROM cap08.TB_CRIANCAS 
WHERE idade < 5;

SELECT * FROM cap08.TB_CRIANCAS ORDER BY idade;

# Realizando a imputação para tratar os outliers presentes
# Calcula a mediana da variável idade
SET @rowindex := -1;

SELECT
   AVG(idade) AS mediana 
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex, cap08.TB_CRIANCAS.idade AS idade
    FROM cap08.TB_CRIANCAS
    ORDER BY cap08.TB_CRIANCAS.idade) AS d
WHERE d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));

SELECT * FROM cap08.TB_CRIANCAS ORDER BY peso;

# Calcula a mediana da variável peso
SET @rowindex := -1;
 
SELECT
   AVG(peso) AS mediana 
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex, cap08.TB_CRIANCAS.peso AS peso
    FROM cap08.TB_CRIANCAS
    ORDER BY cap08.TB_CRIANCAS.peso) AS d
WHERE d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));

# Resolve o problema do outlier com imputação da mediana
SET SQL_SAFE_UPDATES = 0;

UPDATE cap08.TB_CRIANCAS
SET idade = 3
WHERE idade = 42;

UPDATE cap08.TB_CRIANCAS
SET peso = 15
WHERE peso = 98;

SET SQL_SAFE_UPDATES = 1;

SELECT AVG(idade) AS media_idade, STDDEV(idade) AS desvio_padrao_idade
FROM cap08.TB_CRIANCAS;

SELECT AVG(peso) AS media_peso, STDDEV(peso) AS desvio_padrao_peso
FROM cap08.TB_CRIANCAS;

# Script 03

# Cria a tabela
CREATE TABLE cap08.TB_INCIDENTES_DUP (
  `PdId` bigint DEFAULT NULL,
  `IncidntNum` text,
  `Incident Code` text,
  `Category` text,
  `Descript` text,
  `DayOfWeek` text,
  `Date` text,
  `Time` text,
  `PdDistrict` text,
  `Resolution` text,
  `Address` text,
  `X` double DEFAULT NULL,
  `Y` double DEFAULT NULL,
  `location` text,
  `SF Find Neighborhoods 2 2` text,
  `Current Police Districts 2 2` text,
  `Current Supervisor Districts 2 2` text,
  `Analysis Neighborhoods 2 2` text,
  `DELETE - Fire Prevention Districts 2 2` text,
  `DELETE - Police Districts 2 2` text,
  `DELETE - Supervisor Districts 2 2` text,
  `DELETE - Zip Codes 2 2` text,
  `DELETE - Neighborhoods 2 2` text,
  `DELETE - 2017 Fix It Zones 2 2` text,
  `Civic Center Harm Reduction Project Boundary 2 2` text,
  `Fix It Zones as of 2017-11-06  2 2` text,
  `DELETE - HSOC Zones 2 2` text,
  `Fix It Zones as of 2018-02-07 2 2` text,
  `CBD, BID and GBD Boundaries as of 2017 2 2` text,
  `Areas of Vulnerability, 2016 2 2` text,
  `Central Market/Tenderloin Boundary 2 2` text,
  `Central Market/Tenderloin Boundary Polygon - Updated 2 2` text,
  `HSOC Zones as of 2018-06-05 2 2` text,
  `OWED Public Spaces 2 2` text,
  `Neighborhoods 2` text
);

SELECT PdId, Category, COUNT(*) as cntg
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category
HAVING cntg > 1
ORDER BY cntg DESC;

# Identificando os registros duplicados (e retornando cada linha em duplicidade)
SELECT PdId, Category
FROM cap08.TB_INCIDENTES_DUP
WHERE PdId in (SELECT PdId FROM cap08.TB_INCIDENTES_DUP GROUP BY PdId HAVING COUNT(*) > 1)
ORDER BY PdId;

# Identificando os registros duplicados (e retornando uma linha para duplicidade) com função window
SELECT *
FROM (
 SELECT primeiro_resultado.*,      
        ROW_NUMBER() OVER (PARTITION BY PdId, Category ORDER BY PdId) AS numero
 FROM cap08.TB_INCIDENTES_DUP AS primeiro_resultado) AS segundo_resultado
WHERE numero > 1;

# Identificando os registros duplicados com CTE
WITH cte_table
AS
(
 SELECT PdId, Category, ROW_NUMBER() over(PARTITION BY PdId, Category ORDER BY PdId) AS contagem 
 FROM cap08.TB_INCIDENTES_DUP
)
SELECT * FROM cte_table WHERE contagem > 1;

# Deletando os registros duplicados com CTE
SET SQL_SAFE_UPDATES = 0;

WITH cte_table
AS
(
 SELECT PdId, Category, ROW_NUMBER() over(PARTITION BY PdId, Category ORDER BY PdId) AS contagem 
 FROM cap08.TB_INCIDENTES_DUP
)
DELETE FROM cap08.TB_INCIDENTES_DUP 
USING cap08.TB_INCIDENTES_DUP 
JOIN cte_table ON cap08.TB_INCIDENTES_DUP.PdId = cte_table.PdId
WHERE cte_table.contagem > 1; 

SET SQL_SAFE_UPDATES = 1;


# Cria a tabela
CREATE TABLE cap08.TB_ALUNOS (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL
);

# Insere os dados
INSERT INTO cap08.TB_ALUNOS (nome, sobrenome, email) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');
       
SELECT * FROM cap08.TB_ALUNOS
ORDER BY email;	

SELECT email, COUNT(email) AS contagem
FROM cap08.TB_ALUNOS
GROUP BY email
HAVING contagem > 1;

SET SQL_SAFE_UPDATES = 0;

# Removendo duplicidades
USE cap08;
DELETE n1 
FROM TB_ALUNOS n1, TB_ALUNOS n2 
WHERE n1.id > n2.id 
AND n1.email = n2.email;

SET SQL_SAFE_UPDATES = 1;

# Verificando
SELECT email, COUNT(email) AS contagem
FROM cap08.TB_ALUNOS
GROUP BY email
HAVING contagem > 1;


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

# Script 05

ALTER TABLE `cap08`.`TB_VENDAS` 
ADD COLUMN `comissao` DECIMAL(10,2) NULL AFTER `valor_venda`;

SET SQL_SAFE_UPDATES = 0;

UPDATE cap08.TB_VENDAS 
SET comissao = 5
WHERE empID = 1;

UPDATE cap08.TB_VENDAS 
SET comissao = 6
WHERE empID = 2;

UPDATE cap08.TB_VENDAS 
SET comissao = 8
WHERE empID = 3;

SET SQL_SAFE_UPDATES = 1;

# Calcule o valor da comissão a ser pago para cada funcionário
SELECT empID, ROUND((valor_venda * comissao) / 100, 0) AS valor_comissao
FROM cap08.TB_VENDAS;

# Qual será o valor pago ao funcionário de empID 1 se a comissão for igual a 15%?
SELECT empID, GREATEST(15, comissao) AS comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;

SELECT empID, ROUND((valor_venda * GREATEST(15, comissao)) / 100, 0) AS valor_comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;

# Qual será o valor pago ao funcionário de empID 1 se a comissão for igual a 2%?
SELECT empID, LEAST(2, comissao) AS comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;

SELECT empID, ROUND((valor_venda * LEAST(2, comissao)) / 100, 0) AS valor_comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;

# Vendedores devem ser separados em categorias
# De 3 a 5 de comissão = Categoria 1
# De 5.1 a 7.9 = Categoria 2
# Igual ou acima de 8 = Categoria 3
SELECT 
  empID,
  valor_venda,
  CASE 
   WHEN comissao BETWEEN 2 AND 5 THEN 'Categoria 1'
   WHEN comissao BETWEEN 5.1 AND 7.9 THEN 'Categoria 2'
   WHEN comissao >= 8 THEN 'Categoria 3' 
  END AS 'Categoria'
FROM cap08.TB_VENDAS;

# Transformando os dados
CREATE TABLE cap08.TB_ACOES (dia INT, num_vendas INT, valor_acao DECIMAL(10,2));

INSERT INTO cap08.TB_ACOES VALUES 
(1, 32, 0.3),
(1, 4, 70),
(1, 44, 200),
(1, 9, 0.01),
(1, 8, 0.03),
(1, 41, 0.03),
(2, 52, 0.4),
(2, 10, 70),
(2, 53, 200),
(2, 5, 0.01),
(2, 25, 0.55),
(2, 7, 50);

# Vamos separa os dados em 3 categorias.
# Queremos os registros por dia.
# Se o valor_acao for entre 0 e 10 queremos o maior num_vendas desse range e chamaremos de Grupo 1
# Se o valor_acao for entre 10 e 100 queremos o maior num_vendas desse range e chamaremos de Grupo 2
# Se o valor_acao for maior que 100 queremos o maior num_vendas desse range e chamaremos de Grupo 3
SELECT dia,
  MAX(CASE WHEN valor_acao BETWEEN 0 AND 9 THEN num_vendas ELSE 0 END) AS 'Grupo 1',
  MAX(CASE WHEN valor_acao BETWEEN 10 AND 99 THEN num_vendas ELSE 0 END) AS 'Grupo 2',
  MAX(CASE WHEN valor_acao > 100 THEN num_vendas ELSE 0 END) AS 'Grupo 3'
FROM cap08.TB_ACOES
GROUP BY dia;

# Parsing
ALTER TABLE `cap08`.`TB_VENDAS` 
ADD COLUMN `data_venda` DATETIME NULL AFTER `comissao`;

SET SQL_SAFE_UPDATES = 0;

UPDATE cap08.TB_VENDAS 
SET data_venda = '2022-03-15'
WHERE empID = 1;

UPDATE cap08.TB_VENDAS 
SET data_venda = '2022-03-16'
WHERE empID = 2;

UPDATE cap08.TB_VENDAS 
SET data_venda = '2022-03-17'
WHERE empID = 3;

SET SQL_SAFE_UPDATES = 1;

# https://www.w3resource.com/mysql/date-and-time-functions/mysql-date_format-function.php

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%d-%b-%y') AS data_venda_p
FROM cap08.TB_VENDAS;

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%d-%b-%Y') AS data_venda_p
FROM cap08.TB_VENDAS;

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y') AS data_venda_p
FROM cap08.TB_VENDAS;

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y-%f') AS data_venda_p
FROM cap08.TB_VENDAS;

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y-%j') AS data_venda_p
FROM cap08.TB_VENDAS;

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y-%u') AS data_venda_p
FROM cap08.TB_VENDAS;

SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%d/%c/%Y') AS data_venda_p
FROM cap08.TB_VENDAS;

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













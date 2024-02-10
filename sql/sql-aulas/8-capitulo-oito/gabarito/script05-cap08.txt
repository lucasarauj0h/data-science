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






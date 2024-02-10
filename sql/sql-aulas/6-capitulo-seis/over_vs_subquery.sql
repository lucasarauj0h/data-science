SELECT * FROM cap06.tb_vendas;
# Número de vendas por ano, por funcionário e número total de vendas em todos os anos
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
    COUNT(*) OVER() num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;

# Reescrevendo a query anterior usando subquery
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
(SELECT COUNT(*) FROM cap06.TB_VENDAS) as num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;

# Diferenças: a subquery realiza outra query, o que pode causar um problema de perfomance. Portanto é mais efetivo utilizar a função window over


# Script 06

CREATE TABLE cap08.TB_ANIMAIS (
  id INT NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

INSERT INTO cap08.TB_ANIMAIS (id, nome)
VALUES (1, 'Zebra'), (2, 'Elefante'), (3, 'Girafa'), (4, 'Tigre');

CREATE TABLE cap08.TB_ZOOS (
  id INT NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

INSERT INTO cap08.TB_ZOOS (id, nome)
VALUES (1000, 'Zoo do Rio de Janeiro'), (1001, 'Zoo de Recife'), (1002, 'Zoo de Palmas');

CREATE TABLE cap08.TB_MAP_ANIMAL_ZOO (
  id_animal INT NOT NULL,
  id_zoo INT NOT NULL,
  PRIMARY KEY (`id_animal`, `id_zoo`));

INSERT INTO cap08.TB_MAP_ANIMAL_ZOO (id_animal, id_zoo)
VALUES (1, 1001), (1, 1002), (2, 1001), (3, 1000), (4, 1001);

SELECT A.nome AS animal, B.nome AS zoo
FROM cap08.TB_ANIMAIS AS A, cap08.TB_ZOOS AS B, cap08.TB_MAP_ANIMAL_ZOO AS C
WHERE A.id = C.id_animal
AND B.id = C.id_zoo
ORDER BY animal;

SELECT A.nome as animal, B.nome as zoo 
FROM cap08.TB_ANIMAIS AS A, cap08.TB_MAP_ANIMAL_ZOO AS AtoB, cap08.TB_ZOOS AS B
WHERE AtoB.id_animal = A.ID AND B.ID = AtoB.id_zoo 
UNION
SELECT C.nome as Animal, B.nome as Zoo 
FROM cap08.TB_ANIMAIS AS C, cap08.TB_MAP_ANIMAL_ZOO AS CtoB, cap08.TB_ZOOS AS B
WHERE CtoB.id_animal = C.ID AND B.ID = CtoB.id_zoo
ORDER BY animal;

INSERT INTO cap08.TB_ANIMAIS (id, nome)
VALUES (5, 'Macaco');

SELECT A.nome AS animal, COALESCE(C.nome, 'Sem Zoo') AS zoo
FROM cap08.TB_ANIMAIS AS A 
LEFT OUTER JOIN (cap08.TB_MAP_ANIMAL_ZOO AS B INNER JOIN cap08.TB_ZOOS AS C ON C.id = B.id_zoo)
ON B.id_animal = A.id
ORDER BY animal;


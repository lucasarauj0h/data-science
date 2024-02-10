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

# Carregue o dataset2.csv via MySQL Workbench

SELECT PdId, Category
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category;

SELECT PdId, Category, COUNT(*)
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category;

SELECT *
FROM cap08.TB_INCIDENTES_DUP
WHERE PdId = 11082415274000;

# Identificando os registros duplicados (e retornando uma linha para duplicidade)
SELECT PdId, Category, COUNT(*) AS numero
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category
HAVING numero > 1;

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
SELECT * FROM cte_table WHERE contagem > 1

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

# Deletando os registros duplicados com subquery
SET SQL_SAFE_UPDATES = 0;

DELETE FROM cap08.TB_INCIDENTES_DUP
WHERE 
    PdId IN (
    SELECT PdId 
    FROM (
        SELECT                         
            PdId, ROW_NUMBER() OVER (PARTITION BY PdId, Category ORDER BY PdId) AS row_num
        FROM cap08.TB_INCIDENTES_DUP) alias
    WHERE row_num > 1
);

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

USE cap08;
DELETE n1 
FROM TB_ALUNOS n1, TB_ALUNOS n2 
WHERE n1.id > n2.id 
AND n1.email = n2.email

SET SQL_SAFE_UPDATES = 1;

SELECT email, COUNT(email) AS contagem
FROM cap08.TB_ALUNOS
GROUP BY email
HAVING contagem > 1;



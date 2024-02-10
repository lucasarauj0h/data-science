# Carga de dados via linha de comando

CREATE TABLE exec5.TB_BIKES (
  `duracao_segundos` int DEFAULT NULL,
  `data_inicio` text,
  `data_fim` text,
  `numero_estacao_inicio` int DEFAULT NULL,
  `estacao_inicio` text,
  `numero_estacao_fim` int DEFAULT NULL,
  `estacao_fim` text,
  `numero_bike` text,
  `tipo_membro` text);

# Conecte no MySQL via linha de comando
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap07/Exercicio5/dados/2012-capitalbikeshare-tripdata/2012Q2-capitalbikeshare-tripdata.csv' INTO TABLE `exec5`.`TB_BIKES` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


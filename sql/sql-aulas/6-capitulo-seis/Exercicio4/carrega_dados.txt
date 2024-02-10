# Carga de dados via linha de comando

# Conecte no MySQL via linha de comando
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;

# Cria a tabela
CREATE TABLE `exec4`.`channels` (
  `channel_id` int DEFAULT NULL,
  `channel_name` text,
  `channel_type` text);

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/channels.csv' INTO TABLE `exec4`.`channels` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `exec4`.`hubs` (
  `hub_id` int DEFAULT NULL,
  `hub_name` text,
  `hub_city` text,
  `hub_state` text,
  `hub_latitude` double DEFAULT NULL,
  `hub_longitude` double DEFAULT NULL);

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/hubs.csv' INTO TABLE `exec4`.`hubs` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `exec4`.`stores` (
  `store_id` int DEFAULT NULL,
  `hub_id` int DEFAULT NULL,
  `store_name` text,
  `store_segment` text,
  `store_plan_price` int DEFAULT NULL,
  `store_latitude` text,
  `store_longitude` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/stores.csv' INTO TABLE `exec4`.`stores` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `exec4`.`drivers` (
  `driver_id` int DEFAULT NULL,
  `driver_modal` text,
  `driver_type` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/drivers.csv' INTO TABLE `exec4`.`drivers` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `exec4`.`deliveries` (
  `delivery_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `delivery_distance_meters` int DEFAULT NULL,
  `delivery_status` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/deliveries.csv' INTO TABLE `exec4`.`deliveries` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `exec4`.`payments` (
  `payment_id` int DEFAULT NULL,
  `payment_order_id` int DEFAULT NULL,
  `payment_amount` double DEFAULT NULL,
  `payment_fee` double DEFAULT NULL,
  `payment_method` text,
  `payment_status` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/payments.csv' INTO TABLE `exec4`.`payments` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `exec4`.`orders` (
  `order_id` int DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `payment_order_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `order_status` text,
  `order_amount` double DEFAULT NULL,
  `order_delivery_fee` int DEFAULT NULL,
  `order_delivery_cost` text,
  `order_created_hour` int DEFAULT NULL,
  `order_created_minute` int DEFAULT NULL,
  `order_created_day` int DEFAULT NULL,
  `order_created_month` int DEFAULT NULL,
  `order_created_year` int DEFAULT NULL,
  `order_moment_created` text,
  `order_moment_accepted` text,
  `order_moment_ready` text,
  `order_moment_collected` text,
  `order_moment_in_expedition` text,
  `order_moment_delivering` text,
  `order_moment_delivered` text,
  `order_moment_finished` text,
  `order_metric_collected_time` text,
  `order_metric_paused_time` text,
  `order_metric_production_time` text,
  `order_metric_walking_time` text,
  `order_metric_expediton_speed_time` text,
  `order_metric_transit_time` text,
  `order_metric_cycle_time` text);

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/orders.csv' INTO TABLE `exec4`.`orders` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

















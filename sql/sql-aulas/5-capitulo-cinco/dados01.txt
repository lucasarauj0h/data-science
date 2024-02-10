CREATE SCHEMA `cap05` ;


CREATE TABLE `cap05`.`TB_CLIENTES` (
  `id_cliente` INT NULL,
  `nome_cliente` VARCHAR(50) NULL,
  `endereco_cliente` VARCHAR(50) NULL,
  `cidade_cliente` VARCHAR(50) NULL,
  `estado_cliente` VARCHAR(50) NULL);


INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (1, "Bob Silva", "Rua 67", "Fortaleza", "CE");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (2, "Ronaldo Azevedo", "Rua 64", "Campinas", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (3, "John Lenon", "Rua 42", "Rio de Janeiro", "RJ");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (4, "Billy Joel", "Rua 39", "Campos", "RJ");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (5, "Lady Gaga", "Rua 45", "Porto Alegre", "RS");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (6, "Zico Nunes", "Rua 67", "Fortaleza", "CE");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (7, "Maria Aparecida", "Rua 61", "Natal", "RN");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (8, "Elton John", "Rua 22", "Ubatuba", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (9, "Dario Maravilha", "Rua 14", "Ubatuba", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (10, "Lebron James", "Rua 29", "Fortaleza", "CE");


CREATE TABLE `cap05`.`TB_PEDIDOS` (
  `id_pedido` INT NULL,
  `id_cliente` INT NULL,
  `id_vendedor` INT NULL,
  `data_pedido` DATETIME NULL,
  `id_entrega` INT NULL,
  `valor_pedido` DECIMAL(10,2) NULL);


INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1001, 1, 5, now(), 23, 100.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1002, 1, 7, now(), 24, 112.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1003, 2, 5, now(), 23, 250.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1004, 3, 5, now(), 23, 340.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1005, 4, 7, now(), 24, 1290.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1006, 9, 5, now(), 23, 89.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1007, 5, 5, now(), 23, 468.50);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1008, 1, 7, now(), 24, 572.20);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1009, 8, 5, now(), 23, 187.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1010, 7, 7, now(), 24, 579.20);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1011, 10, 5, now(), 23, 192.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1012, 8, 5, now(), 23, 140.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1013, 5, 7, now(), 28, 573.20);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1014, 6, 5, now(), 27, 191.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1015, 6, 4, now(), 22, 154.37);


CREATE TABLE `cap05`.`TB_VENDEDOR` (
  `id_vendedor` INT NULL,
  `nome_vendedor` VARCHAR(50) NULL,
  `dept_vendedor` VARCHAR(50) NULL);


INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (1, "Vendedor 1", "Eletronicos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (2, "Vendedor 2", "Vestuario");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (3, "Vendedor 3", "Eletronicos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (4, "Vendedor 4", "Moveis");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (5, "Vendedor 5", "Eletrodomesticos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (6, "Vendedor 6", "Eletrodomesticos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (7, "Vendedor 7", "Eletronicos");





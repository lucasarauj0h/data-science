-- SGBD Utilizado: SQL Server Management Studio 

-- #1- Qual o número de hubs por cidade?

SELECT hub_city, COUNT(hub_name) AS contagem
FROM dbo.hubs
GROUP BY hub_city
ORDER BY contagem DESC;

-- # 2- Qual o número de pedidos por status?

SELECT COUNT(order_id) as total, order_status
  FROM [exec4].[dbo].[orders]
  GROUP BY order_status
  ORDER BY total DESC;

-- # 3- Qual o número de lojas por cidade dos hubs?

SELECT COUNT(store_id) as contagem, hub_city
FROM dbo.hubs H, dbo.stores S
WHERE H.hub_id = S.hub_id
GROUP BY hub_city
ORDER BY contagem DESC;

-- # 4- Qual o maior e o menor valor de pagamento registrado?

SELECT MAX(payment_amount)/100 as maximo, MIN(payment_amount)/100 as minimo
  FROM [exec4].[dbo].[payments];

-- # 5- Qual tipo de driver (driver_type) fez o maior número de entregas?

SELECT COUNT(delivery_id) AS total, driver_type
FROM dbo.deliveries AS de, dbo.drivers AS dr
WHERE dr.driver_id = de.driver_id
GROUP BY driver_type
ORDER BY total DESC;

-- # 6- Qual a distância média das entregas por modo de driver (driver_modal)?

SELECT ROUND(AVG(CAST(de.delivery_distance_meters AS DECIMAL(18, 2))), 2) as distancia_media, dr.driver_modal
FROM dbo.deliveries AS de
JOIN dbo.drivers AS dr ON dr.driver_id = de.driver_id
GROUP BY dr.driver_modal;


-- # 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?

SELECT ROUND(AVG(o.order_amount) / 100, 2) as media_valor_pedido, s.store_name
FROM dbo.orders as o
JOIN dbo.stores as s ON o.store_id = s.store_id
WHERE o.order_amount IS NOT NULL
GROUP BY s.store_name
ORDER BY media_valor_pedido DESC;

-- # 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?

SELECT COUNT(order_id) as total, COALESCE(store_name, 'sem loja') AS lojas
FROM dbo.orders o LEFT JOIN dbo.stores S ON s.store_id = o.store_id
GROUP BY store_name
ORDER BY total DESC;	-- Não há um pedido que não tenhoa loja associada 

-- # 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
SELECT ROUND(SUM(order_amount/100),2) as soma, channel_name
FROM dbo.orders o INNER JOIN dbo.channels C ON o.channel_id = c.channel_id
WHERE channel_name = 'FOOD PLACE'

-- # 10- Quantos pagamentos foram cancelados (chargeback)?

SELECT COUNT(payment_id) AS contagem, payment_status
  FROM dbo.payments
  GROUP BY payment_status
  ORDER BY contagem

-- # 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?

SELECT ROUND(AVG(order_amount/100),2) AS media_valor_pedido, payment_status
  FROM dbo.orders o INNER JOIN dbo.payments p ON o.payment_order_id = p.payment_order_id
  GROUP BY payment_status
  ORDER BY media_valor_pedido

-- # 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?

SELECT ROUND(AVG(order_amount/100),2) AS media_valor_pedido, payment_method
  FROM dbo.orders o INNER JOIN dbo.payments p ON o.payment_order_id = p.payment_order_id
  GROUP BY payment_method
  ORDER BY media_valor_pedido DESC;

SELECT payment_method, ROUND(AVG(payment_amount/100),2) AS media_pagamento
FROM dbo.payments
GROUP BY payment_method
ORDER BY media_pagamento DESC;

-- # 13- Quais métodos de pagamento tiveram valor médio superior a 100?

SELECT ROUND(AVG(order_amount/100),2) AS media_pagamento, payment_method
  FROM dbo.orders o INNER JOIN dbo.payments p ON o.payment_order_id = p.payment_order_id
  GROUP BY payment_method
  HAVING (AVG(order_amount/100)) > 100
  ORDER BY media_pagamento DESC;

-- # 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state)
-- segmento da loja (store_segment) e tipo de canal (channel_type)?

SELECT ROUND(AVG(order_amount/100),2) AS media_valor_pedido, hub_state, store_segment, channel_type
  FROM dbo.orders o INNER JOIN dbo.stores s ON o.store_id =  s.store_id 
  INNER JOIN dbo.hubs h ON h.hub_id = s.hub_id 
  INNER JOIN dbo.channels c ON c.channel_id = o.channel_id
  GROUP BY hub_state, store_segment, channel_type
  ORDER BY hub_state;

-- # 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e 
-- tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 350?
  
SELECT ROUND(AVG(order_amount/100),2) AS media_valor_pedido, hub_state, store_segment, channel_type
  FROM dbo.orders o INNER JOIN dbo.stores s ON o.store_id =  s.store_id 
  INNER JOIN dbo.hubs h ON h.hub_id = s.hub_id 
  INNER JOIN dbo.channels c ON c.channel_id = o.channel_id
  GROUP BY hub_state, store_segment, channel_type
  HAVING AVG(order_amount/100) > 350 -- NENHUM
  ORDER BY hub_state;

-- # 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
-- Demonstre os totais intermediários e formate o resultado.

SELECT ROUND(SUM(order_amount/100),2) AS total_pedido,	
-- Durante o processo de geração do with rollup (subtotais) acabam sendo gerados valores nulos para as colunas. 
-- Identificamos esses valores nulos e atribuimos um nome
	CASE WHEN GROUPING(hub_state) = 1 THEN 'Total Hub State' ELSE hub_state END AS hub_state,
    CASE WHEN GROUPING(store_segment) = 1 THEN 'Total Segmento' ELSE store_segment END AS store_segment,
    CASE WHEN GROUPING(channel_type) = 1 THEN 'Total Tipo de Canal' ELSE channel_type END AS channel_type
	FROM dbo.orders o INNER JOIN dbo.stores s ON o.store_id =  s.store_id 
    INNER JOIN dbo.hubs h ON h.hub_id = s.hub_id 
    INNER JOIN dbo.channels c ON c.channel_id = o.channel_id
    GROUP BY hub_state, store_segment, channel_type WITH ROLLUP

-- # 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD'
-- tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?

SELECT ROUND(AVG(order_amount/100),2) AS media_valor_pedido, hub_state, store_segment, channel_type
  FROM dbo.orders o INNER JOIN dbo.stores s ON o.store_id =  s.store_id 
  INNER JOIN dbo.hubs h ON h.hub_id = s.hub_id 
  INNER JOIN dbo.channels c ON c.channel_id = o.channel_id
  WHERE	order_status = 'CANCELED'
  AND store_segment = 'FOOD'
  AND channel_type = 'MARKETPLACE'
  AND hub_state = 'RJ'
  GROUP BY hub_state, store_segment, channel_type
  ORDER BY hub_state;


-- # 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, 
-- algum hub_state teve total de valor do pedido superior a 100.000?

SELECT ROUND(SUM(order_amount/100),2) AS media_valor_pedido, hub_state, store_segment, channel_type
  FROM dbo.orders o, dbo.stores s, dbo.hubs h, dbo.channels c
  WHERE	o.store_id =  s.store_id 
  AND h.hub_id = s.hub_id 
  AND c.channel_id = o.channel_id
  AND order_status = 'CANCELED'
  AND store_segment = 'GOOD'
  AND channel_type = 'MARKETPLACE'
  GROUP BY hub_state, store_segment, channel_type
  HAVING SUM(order_amount/100) > 100000
  ORDER BY hub_state;

-- # 19- Em que data houve a maior média de valor do pedido (order_amount)?
-- # Dica: Pesquise e use a função SUBSTRING().
SELECT 
-- A função substring é um 'split' do python. 
    SUBSTRING(CONVERT(VARCHAR, order_moment_created, 120), 1, 10) AS data_pedido,
    ROUND(AVG(order_amount/100), 2) AS media_pedido
FROM dbo.orders
GROUP BY SUBSTRING(CONVERT(VARCHAR, order_moment_created, 120), 1, 10)
ORDER BY media_pedido DESC;

-- # 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?
-- # Dica: Use a função SUBSTRING().
SELECT 
-- A função substring é um 'split' do python. 
    SUBSTRING(CONVERT(VARCHAR, order_moment_created, 120), 1, 10) AS data_pedido,
    MIN(order_amount) AS min_pedido
FROM dbo.orders
GROUP BY SUBSTRING(CONVERT(VARCHAR, order_moment_created, 120), 1, 10)
HAVING MIN(order_amount) = 0
ORDER BY data_pedido ASC;
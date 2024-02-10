# Solução exercício 4


# Verificando o total de registros
SELECT COUNT(*) FROM exec4.hubs;
SELECT COUNT(*) FROM exec4.channels;
SELECT COUNT(*) FROM exec4.stores;
SELECT COUNT(*) FROM exec4.drivers;
SELECT COUNT(*) FROM exec4.deliveries;
SELECT COUNT(*) FROM exec4.payments;
SELECT COUNT(*) FROM exec4.orders;


# 1- Qual o número de hubs por cidade?
SELECT hub_city, COUNT(hub_name) AS contagem
FROM exec4.hubs
GROUP BY hub_city
ORDER BY contagem DESC;


# 2- Qual o número de pedidos (orders) por status?
SELECT order_status, COUNT(order_id) AS num_pedidos
FROM exec4.orders
GROUP BY order_status;


# 3- Qual o número de lojas (stores) por cidade dos hubs?
SELECT hub_city, COUNT(store_id) AS num_lojas
FROM exec4.hubs hubs, exec4.stores stores
WHERE hubs.hub_id = stores.hub_id
GROUP BY hub_city
ORDER BY num_lojas DESC;


# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
SELECT MAX(payment_amount) FROM exec4.payments;
SELECT MIN(payment_amount) FROM exec4.payments;


# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?
SELECT driver_type, COUNT(delivery_id) AS num_entregas
FROM exec4.deliveries deliveries, exec4.drivers drivers
WHERE drivers.driver_id = deliveries.driver_id
GROUP BY driver_type
ORDER BY num_entregas DESC;


# 6- Qual a distância média das entregas por modo de driver (driver_modal)?
SELECT driver_modal, ROUND(AVG(delivery_distance_meters),2) AS distancia_media
FROM exec4.deliveries deliveries, exec4.drivers drivers
WHERE drivers.driver_id = deliveries.driver_id
GROUP BY driver_modal;


# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
SELECT store_name, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores
WHERE stores.store_id = orders.store_id
GROUP BY store_name
ORDER BY media_pedido DESC;


# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
SELECT COALESCE(store_name, "Sem Loja"), COUNT(order_id) AS contagem
FROM exec4.orders orders LEFT JOIN exec4.stores stores
ON stores.store_id = orders.store_id
GROUP BY store_name
ORDER BY contagem DESC;	


# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
SELECT ROUND(sum(order_amount),2) AS total
FROM exec4.orders orders, exec4.channels channels
WHERE channels.channel_id = orders.channel_id
AND channel_name = 'FOOD PLACE';


# 10- Quantos pagamentos foram cancelados (chargeback)?
SELECT payment_status, COUNT(payment_status) AS contagem
FROM exec4.payments payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;


# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?
SELECT payment_status, ROUND(AVG(payment_amount),2) AS contagem
FROM exec4.payments payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;


# 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
SELECT payment_method, ROUND(AVG(payment_amount),2) AS media_pagamento
FROM exec4.payments
GROUP BY payment_method
ORDER BY media_pagamento DESC;


# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
SELECT payment_method, ROUND(AVG(payment_amount),2) AS media_pagamento
FROM exec4.payments
GROUP BY payment_method
HAVING media_pagamento > 100
ORDER BY media_pagamento DESC;


# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
SELECT hub_state, store_segment, channel_type, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type
ORDER BY hub_state;


# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
SELECT hub_state, store_segment, channel_type, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type
HAVING media_pedido > 450
ORDER BY hub_state;


# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
# Demonstre os totais intermediários e formate o resultado.
SELECT 
	IF(GROUPING(hub_state), 'Total Hub State', hub_state) AS hub_state,
    IF(GROUPING(store_segment), 'Total Segmento', store_segment) AS store_segment,
    IF(GROUPING(channel_type), 'Total Tipo de Canal', channel_type) AS channel_type,
    ROUND(SUM(order_amount),2) total_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type WITH ROLLUP;


# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
SELECT hub_state, store_segment, channel_type, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
AND order_status = 'CANCELED'
AND store_segment = 'FOOD'
AND channel_type = 'MARKETPLACE'
AND hub_state = 'RJ'
GROUP BY hub_state, store_segment, channel_type;


# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
SELECT hub_state, store_segment, channel_type, ROUND(SUM(order_amount),2) AS total_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
AND order_status = 'CANCELED'
AND store_segment = 'GOOD'
AND channel_type = 'MARKETPLACE'
GROUP BY hub_state, store_segment, channel_type
HAVING total_pedido > 100000;


# 19- Em que data houve a maior média de valor do pedido (order_amount)?
# Dica: Pesquise e use a função SUBSTRING().
SELECT SUBSTRING(order_moment_created, 1, 9) AS data_pedido, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders
GROUP BY data_pedido
ORDER BY media_pedido DESC;


# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?
# Dica: Use a função SUBSTRING().
SELECT SUBSTRING(order_moment_created, 1, 9) AS data_pedido, MIN(order_amount) AS min_pedido
FROM exec4.orders orders
GROUP BY data_pedido
HAVING min_pedido = 0
ORDER BY data_pedido ASC;














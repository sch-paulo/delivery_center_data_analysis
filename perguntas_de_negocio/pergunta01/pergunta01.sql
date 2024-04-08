/*
Pergunta 1:
Quais canais de venda geram mais receita para o Delivery Center?

Considerações:
* Valor total do pedido = valor do pedido (order_amount) + receita do frete (order_delivery_fee) + custo do frete(order_delivery_cost)
* Apenas pedidos com status "FINISHED"
* Definir o top 10 maiores geradores de receita
*/

SELECT 
	c.channel_name AS canal_de_venda,
	c.channel_type AS tipo_de_canal,
	SUM(o.order_amount + o.order_delivery_fee + o.order_delivery_cost) AS total_de_receita 
FROM
	orders o
LEFT JOIN 
	channels c ON o.channel_id = c.channel_id
WHERE 
	o.order_status = 'FINISHED'
GROUP BY 
	c.channel_name, c.channel_type
ORDER BY 
	total_de_receita DESC
LIMIT 
	10;


/* Bônus:
 * Marketplace superou canais próprios em mais de 4 vezes (419%)
 */

SELECT 
	c.channel_type AS tipo_de_canal,
	SUM(o.order_amount + o.order_delivery_fee + o.order_delivery_cost) AS total_de_receita 
FROM 
	orders AS o
LEFT JOIN 
	channels AS c ON o.channel_id = c.channel_id
WHERE 
	o.order_status = 'FINISHED'
GROUP BY 
	c.channel_type
ORDER BY 
	total_de_receita DESC;
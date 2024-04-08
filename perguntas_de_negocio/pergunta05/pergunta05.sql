/* 
Pergunta 5:
Qual o ranking das top 15 lojas que mais geram receita entre fevereiro e março?

Considerações:
* Valor total do pedido = valor do pedido (order_amount) + receita do frete (order_delivery_fee) + custo do frete(order_delivery_cost)
* Apenas pedidos com status "FINISHED"
*/

SELECT 
	s.store_name AS nome_loja,	   
	s.store_segment AS segmento_loja,
	SUM(o.order_amount + o.order_delivery_fee + o.order_delivery_cost) AS total_de_receita
FROM 
	orders o 
LEFT JOIN 
	stores s ON o.store_id = s.store_id
LEFT JOIN 
	hubs h ON s.hub_id = h.hub_id 
WHERE 
	o.order_status = 'FINISHED' AND o.order_created_month BETWEEN 2 AND 3
GROUP BY 
	s.store_name, s.store_segment
ORDER BY 
	total_de_receita DESC
LIMIT 
	15;

/* Bônus:
 * Foods representam 3,25 vezes mais receita do que Goods.
 */

SELECT 
	s.store_segment AS segmento, 
	SUM(o.order_amount + o.order_delivery_fee + o.order_delivery_cost) AS total_de_receita  
FROM
	orders o 
LEFT JOIN
	stores s ON o.store_id = s.store_id
WHERE 
	o.order_status = 'FINISHED'
GROUP BY	
	s.store_segment
ORDER BY
	total_de_receita DESC;
/* 
Pergunta 2:
Qual a média de tempo de entrega por cidade?

Considerações:
* Tempo de entrega = order_moment_finished - order_moment_delivering
  -	Momento em que o pedido é finalizado menos o momento em que se inicia a entrega
* Tabela deliveries possui valores duplicados, por isso selecionamos apenas delivery_order_id únicos
* Apenas pedidos com status "FINISHED" e "DELIVERED"
* Pedidos incoerentes em que o pedido é finalizado ANTES da entrega serão desconsiderados
* Pedidos com tempos muito longos (acima de 200 minutos) podem ter sido deixados abertos mesmo após a entrega, e serão desconsiderados
* Tempo médio calculado em minutos
*/

WITH calculo_tempo_entrega AS (
	SELECT 
	    h.hub_city, 
	   (TIMESTAMPDIFF(SECOND, o.order_moment_delivering, o.order_moment_finished)/60) AS tempo_entrega
	FROM 
		orders o 
	INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		delivery_status
    	FROM 
    		deliveries
    	WHERE 
			delivery_status = 'DELIVERED'
	) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
	LEFT JOIN 
		stores s ON o.store_id = s.store_id
	LEFT JOIN 
		hubs h ON s.hub_id = h.hub_id
	WHERE 
		o.order_status = 'FINISHED'
)
SELECT 
	cte.hub_city AS cidade,	   
	COUNT(cte.tempo_entrega) AS quantidade_pedidos,	
	ROUND(AVG(cte.tempo_entrega), 2) AS tempo_medio_entrega
FROM 
	calculo_tempo_entrega AS cte
WHERE 
	cte.tempo_entrega BETWEEN 0 AND 200
GROUP BY 
	cte.hub_city
ORDER BY 
	tempo_medio_entrega;



/* Bônus:
 * Quais são os hubs que entregam mais rápido?
 */

WITH calculo_tempo_entrega AS (
	SELECT 
		h.hub_name, 
		h.hub_city, 
	   (TIMESTAMPDIFF(SECOND, o.order_moment_delivering, o.order_moment_finished)/60) AS tempo_entrega
	FROM 
		orders o 
	INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		delivery_status
    	FROM 
    		deliveries
	) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
	LEFT JOIN 
		stores s ON o.store_id = s.store_id
	LEFT JOIN 
		hubs h ON s.hub_id = h.hub_id
	WHERE 
		o.order_status = 'FINISHED' AND ud.delivery_status = 'DELIVERED'
)
SELECT 
	cte.hub_name AS nome_hub,
	cte.hub_city AS cidade, 
	COUNT(cte.tempo_entrega) AS quantidade_pedidos,   
	ROUND(AVG(cte.tempo_entrega), 2) AS tempo_medio_entrega
FROM 
	calculo_tempo_entrega AS cte
WHERE 
	cte.tempo_entrega BETWEEN 0 AND 200
GROUP BY 
	cte.hub_name, cte.hub_city
ORDER BY 
	tempo_medio_entrega;

	
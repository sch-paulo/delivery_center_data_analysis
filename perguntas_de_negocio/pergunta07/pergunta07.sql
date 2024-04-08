/* 
Pergunta 7:
Quem são os 5 entregadores com a maior média de entregas por dia, e como essa média varia mês a mês?

Considerações:
* Não contabilizar entregas com driver_id nulos 
* Não contabilizar IDs 25651 e 26223, por conterem números impraticáveis (70 a 90 entregas por dia)
* Apenas pedidos com status "FINISHED" e "DELIVERED"
*/

WITH media_entregador AS (
	SELECT 
		entregador,
		EXTRACT(MONTH FROM data) AS mes,
		ROUND(AVG(entregas_por_dia), 2) AS media_entregas_por_dia,
		RANK() OVER(PARTITION BY EXTRACT(MONTH FROM data) ORDER BY AVG(entregas_por_dia) DESC) AS rank_entregador
	FROM (
		SELECT
			ud.driver_id AS entregador,
			DATE(o.order_moment_created) AS data,
			COUNT(o.order_id) AS entregas_por_dia
		FROM 
			orders o 
		INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		driver_id, 
    		delivery_status
    	FROM 
    		deliveries    	
		) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
		LEFT JOIN 
			drivers dr ON ud.driver_id = dr.driver_id	
		WHERE 
			o.order_status = 'FINISHED' AND 
			ud.driver_id IS NOT NULL AND 
			ud.driver_id NOT IN (25651, 26223) AND 
			ud.delivery_status = 'DELIVERED'
		GROUP BY 
			ud.driver_id, 
			DATE(o.order_moment_created)
	) AS subquery
	GROUP BY
		entregador,
		EXTRACT(MONTH FROM data)
)
SELECT
	entregador,
	mes,
	media_entregas_por_dia,
	rank_entregador
FROM
	media_entregador
WHERE
	rank_entregador <= 5
ORDER BY 
	mes,
	rank_entregador
	
	
/* Média geral de todo o período */
WITH media_entregador AS (
	SELECT 
		entregador,
		ROUND(AVG(entregas_por_dia), 2) AS media_entregas_por_dia,
		RANK() OVER(ORDER BY AVG(entregas_por_dia) DESC) AS rank_entregador
	FROM (
		SELECT
			ud.driver_id AS entregador,
			DATE(o.order_moment_created) AS data,
			COUNT(o.order_id) AS entregas_por_dia
		FROM 
			orders o 
		INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		driver_id, 
    		delivery_status
    	FROM 
    		deliveries    	
		) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
		LEFT JOIN 
			drivers dr ON ud.driver_id = dr.driver_id	
		WHERE 
			o.order_status = 'FINISHED' AND 
			ud.driver_id IS NOT NULL AND 
			ud.driver_id NOT IN (25651, 26223) AND 
			ud.delivery_status = 'DELIVERED'
		GROUP BY 
			ud.driver_id, 
			DATE(o.order_moment_created)
	) AS subquery
	GROUP BY
		entregador
)
SELECT
	entregador,
	media_entregas_por_dia,
	rank_entregador
FROM
	media_entregador
WHERE
	rank_entregador <= 5
ORDER BY 
	rank_entregador
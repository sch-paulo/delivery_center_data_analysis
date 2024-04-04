/* 
Pergunta 8:
Quais são os HUBs com aumento de pedidos acima de 20% de fevereiro para março?

Considerações:
* Pedidos com status "FINISHED"
*/

WITH pedidos_fevereiro AS(
	SELECT
		h.hub_name AS nome_hub,
		h.hub_state AS estado_hub,
		COUNT(*) AS pedidos_fevereiro
	FROM 
		orders o 
	LEFT JOIN
		stores s ON o.store_id = s.store_id 
	LEFT JOIN 
		hubs h ON s.hub_id = h.hub_id 
	WHERE o.order_created_month = 2 AND o.order_status = 'FINISHED'
	GROUP BY
		h.hub_name, h.hub_state
),
pedidos_marco AS (
	SELECT
		h.hub_name AS nome_hub,
		h.hub_state AS estado_hub,
		COUNT(*) AS pedidos_marco
	FROM 
		orders o 
	LEFT JOIN
		stores s ON o.store_id = s.store_id 
	LEFT JOIN 
		hubs h ON s.hub_id = h.hub_id 
	WHERE o.order_created_month = 3 AND o.order_status = 'FINISHED'
	GROUP BY
		h.hub_name, h.hub_state
)
SELECT
	pf.nome_hub,
	pf.estado_hub,
	pf.pedidos_fevereiro,
	pm.pedidos_marco,
	pm.pedidos_marco - pf.pedidos_fevereiro AS diferenca,
	ROUND(((pm.pedidos_marco - pf.pedidos_fevereiro)/pm.pedidos_marco)*100, 2) AS diferenca_percentual
FROM
	pedidos_fevereiro pf
LEFT JOIN 
	pedidos_marco pm ON pf.nome_hub = pm.nome_hub
WHERE 
	((pm.pedidos_marco - pf.pedidos_fevereiro)/ pm.pedidos_marco) > 0.2  -- Para filtrar apenas os que tiveram aumento de 20%
ORDER BY
	diferenca_percentual DESC
	
	

/* Bônus:
 * HUBs que apresentaram queda no período
 */
	
WITH pedidos_fevereiro AS(
	SELECT
		h.hub_name AS nome_hub,
		h.hub_state AS estado_hub,
		COUNT(*) AS pedidos_fevereiro
	FROM 
		orders o 
	LEFT JOIN
		stores s ON o.store_id = s.store_id 
	LEFT JOIN 
		hubs h ON s.hub_id = h.hub_id 
	WHERE o.order_created_month = 2 AND o.order_status = 'FINISHED'
	GROUP BY
		h.hub_name, h.hub_state
),
pedidos_marco AS (
	SELECT
		h.hub_name AS nome_hub,
		h.hub_state AS estado_hub,
		COUNT(*) AS pedidos_marco
	FROM 
		orders o 
	LEFT JOIN
		stores s ON o.store_id = s.store_id 
	LEFT JOIN 
		hubs h ON s.hub_id = h.hub_id 
	WHERE o.order_created_month = 3 AND o.order_status = 'FINISHED'
	GROUP BY
		h.hub_name, h.hub_state
)
SELECT
	pf.nome_hub,
	pf.estado_hub,
	pf.pedidos_fevereiro,
	pm.pedidos_marco,
	pm.pedidos_marco - pf.pedidos_fevereiro AS diferenca,
	ROUND(((pm.pedidos_marco - pf.pedidos_fevereiro)/pm.pedidos_marco)*100, 2) AS diferenca_percentual
FROM
	pedidos_fevereiro pf
LEFT JOIN 
	pedidos_marco pm ON pf.nome_hub = pm.nome_hub
WHERE 
	(pm.pedidos_marco - pf.pedidos_fevereiro) < 0
ORDER BY
	diferenca_percentual DESC
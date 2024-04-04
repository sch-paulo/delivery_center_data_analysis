/* 
Pergunta 9:
Qual a relação entre o número de entregas realizadas e o número de pedidos, por lojista?

Considerações:
* Tabela deliveries possui valores duplicados, por isso selecionamos apenas delivery_order_id únicos
* Apenas lojas com mais de 500 entregas registradas
*/

WITH entregas_realizadas AS (
	SELECT
		s.store_name AS nome_loja,
		COUNT(o.order_id) AS entregas_realizadas
	FROM
		orders o 
	LEFT JOIN
		stores s ON o.store_id = s.store_id 
	INNER JOIN (
	    	SELECT 
	    		DISTINCT delivery_order_id,
	    		delivery_status
	    	FROM deliveries
		) AS ud ON o.delivery_order_id = ud.delivery_order_id
	WHERE 
		ud.delivery_status = 'DELIVERED'
	GROUP BY 
		s.store_name
	HAVING 
		entregas_realizadas > 500
),
entregas_nao_realizadas AS (
	SELECT
		s.store_name AS nome_loja,
		COUNT(o.order_id) AS entregas_nao_realizadas
	FROM
		orders o 
	LEFT JOIN
		stores s ON o.store_id = s.store_id 
	INNER JOIN (
	    	SELECT 
	    		DISTINCT delivery_order_id,
	    		delivery_status
	    	FROM deliveries
		) AS ud ON o.delivery_order_id = ud.delivery_order_id
	WHERE 
		ud.delivery_status = 'CANCELLED'
	GROUP BY 
		s.store_name
)
SELECT
	er.nome_loja,
	er.entregas_realizadas,
	enr.entregas_nao_realizadas,
	ROUND(enr.entregas_nao_realizadas/(er.entregas_realizadas + enr.entregas_nao_realizadas)*100, 2) AS indice_entregas_nao_realizadas
FROM
	entregas_realizadas er
INNER JOIN
	entregas_nao_realizadas enr ON er.nome_loja = enr.nome_loja
ORDER BY 
	indice_entregas_nao_realizadas DESC

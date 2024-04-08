/* 
Pergunta 3:
Quantos entregadores únicos entregaram mais de 100 pedidos no período?

Considerações:
* Tabela deliveries possui valores duplicados, por isso selecionamos apenas delivery_order_id únicos
* Filtrar apenas entregas classificadas como "DELIVERED"
* O status do pedido deve ser classificado como "FINISHED"
* Não contabilizar entregas com driver_id nulos 
* Não contabilizar IDs 25651 e 26223, por conterem números impraticáveis (70 a 90 entregas por dia)
*/

WITH pedidos_por_entregador AS (
	SELECT 
		DISTINCT ud.driver_id AS id_entregador, 
		COUNT(order_id) AS quantidade_pedidos
	FROM 
		orders o 
	INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		driver_id, 
    		delivery_status
    	FROM deliveries
    	WHERE delivery_status = 'DELIVERED'
	) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
	LEFT JOIN 
		drivers dr ON ud.driver_id = dr.driver_id 
	WHERE 
		o.order_status = 'FINISHED' AND ud.driver_id IS NOT NULL AND ud.driver_id NOT IN (25651, 26223)
	GROUP BY 
		ud.driver_id
	HAVING 
		quantidade_pedidos > 100
	ORDER BY 
		quantidade_pedidos DESC
)
SELECT 
	COUNT(id_entregador) AS top_entregadores 
FROM 
	pedidos_por_entregador ppe;

/*Quantidade de IDs únicos de entregadores*/
SELECT 
	COUNT(DISTINCT driver_id) AS total_entregadores
FROM 
	drivers
WHERE 
	driver_id IS NOT NULL AND driver_id NOT IN (25651, 26223);

/* 
 * 953 de 4822 entregadores (20%) fizeram 100 ou mais entregas
 */



/* Bônus:
 * Motoboys representam 72% das entregas realizadas, contra 28% dos entregadores de bicicleta
 * Freelancers representam 73%, enquanto os 27% restantes fica a cargo de empresas terceirizadas
 */

/* Análise do modal do entregador */
SELECT 
	dr.driver_modal AS modal_entregador, 	   
	COUNT(order_id) AS quantidade_pedidos
FROM 
	orders o 
INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		driver_id, 
    		delivery_status
    	FROM 
    		deliveries
    	WHERE 
			delivery_status = 'DELIVERED'
	) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
LEFT JOIN 
	drivers dr ON ud.driver_id = dr.driver_id 
WHERE 
	o.order_status = 'FINISHED' AND ud.driver_id IS NOT NULL 
GROUP BY 	
	dr.driver_modal
ORDER BY 
	quantidade_pedidos DESC;



/* Análise do tipo do entregador */
SELECT 
	dr.driver_type AS tipo_entregador,	   
	COUNT(order_id) AS quantidade_pedidos
FROM 
	orders o 
INNER JOIN (
    	SELECT 
    		DISTINCT delivery_order_id, 
    		driver_id, 
    		delivery_status
    	FROM 
    		deliveries
    	WHERE 
			delivery_status = 'DELIVERED'
	) AS ud
		ON o.delivery_order_id = ud.delivery_order_id
LEFT JOIN 
	drivers dr ON ud.driver_id = dr.driver_id 
WHERE 
	o.order_status = 'FINISHED' AND ud.driver_id IS NOT NULL
GROUP BY 	
	dr.driver_type
ORDER BY 
	quantidade_pedidos DESC;
	


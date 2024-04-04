/* 
Pergunta 6:
Qual o crescimento percentual mensal no número de pedidos por cidade/HUB de distribuição?

Considerações:
* Apenas pedidos com status "FINISHED"
* Filtrar HUBs com mais de 1000 pedidos totais
*/

/* Por hub */
SELECT 
    nome_hub,
    mes,
    total_pedidos,
    total_pedidos - LAG(total_pedidos) OVER (PARTITION BY nome_hub ORDER BY mes) AS diferenca_mes_anterior,
    ROUND(((total_pedidos - LAG(total_pedidos) OVER (PARTITION BY nome_hub ORDER BY mes)) / LAG(total_pedidos) OVER (PARTITION BY nome_hub ORDER BY mes)) * 100, 2) AS percentual_mudanca
FROM (
    SELECT 
        h.hub_name AS nome_hub,
        o.order_created_month AS mes, 
        COUNT(o.order_id) AS total_pedidos
    FROM 
        orders o 
    LEFT JOIN 
        stores s ON o.store_id = s.store_id 
    LEFT JOIN 
        hubs h ON s.hub_id = h.hub_id
    WHERE 
    	o.order_status = 'FINISHED'
    GROUP BY 
        h.hub_name, o.order_created_month
    HAVING total_pedidos > 1000
) AS subquery
ORDER BY 
    nome_hub, mes;
   
   
   
/* Por cidade */
SELECT 
    cidade,
    mes,
    total_pedidos,
    total_pedidos - LAG(total_pedidos) OVER (PARTITION BY cidade ORDER BY mes) AS diferenca_mes_anterior,
    ROUND(((total_pedidos - LAG(total_pedidos) OVER (PARTITION BY cidade ORDER BY mes)) / LAG(total_pedidos) OVER (PARTITION BY cidade ORDER BY mes)) * 100, 2) AS percentual_mudanca
FROM (
    SELECT 
        h.hub_city AS cidade,
        o.order_created_month AS mes, 
        COUNT(o.order_id) AS total_pedidos
    FROM 
        orders o 
    LEFT JOIN 
        stores s ON o.store_id = s.store_id 
    LEFT JOIN 
        hubs h ON s.hub_id = h.hub_id
    WHERE 
    	o.order_status = 'FINISHED'
    GROUP BY 
        h.hub_city, o.order_created_month
) AS subquery
ORDER BY 
    cidade, mes;
   
   
   
/* Por mês apenas */
SELECT 
    mes,
    total_pedidos,
    total_pedidos - LAG(total_pedidos) OVER (ORDER BY mes) AS diferenca_mes_anterior,
    ROUND(((total_pedidos - LAG(total_pedidos) OVER (ORDER BY mes)) / LAG(total_pedidos) OVER (ORDER BY mes)) * 100, 2) AS percentual_mudanca
FROM (
    SELECT 
        o.order_created_month AS mes, 
        COUNT(o.order_id) AS total_pedidos
    FROM 
        orders o 
    LEFT JOIN 
        stores s ON o.store_id = s.store_id 
    LEFT JOIN 
        hubs h ON s.hub_id = h.hub_id
    WHERE 
    	o.order_status = 'FINISHED'
    GROUP BY 
        o.order_created_month
) AS subquery
ORDER BY 
    mes;


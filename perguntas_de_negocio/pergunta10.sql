/* 
Pergunta 10:
Qual o ranking dos top 5 lojistas com mais pedidos em cada canal de venda?

Considerações:
* Apenas lojas com mais de 1000 pedidos registrados
* Apenas pedidos com status "FINISHED"
*/

WITH pedidos_por_lojista AS (
    SELECT
        s.store_name AS nome_loja,
        c.channel_name AS nome_canal,
        COUNT(o.order_id) AS total_pedidos,
        RANK() OVER (PARTITION BY c.channel_name ORDER BY COUNT(o.order_id) DESC) AS ranking
    FROM
        orders o
    LEFT JOIN
        stores s ON o.store_id = s.store_id
    LEFT JOIN 
        channels c ON o.channel_id = c.channel_id
    GROUP BY
        s.store_name, c.channel_name
    HAVING
        total_pedidos > 250
)
SELECT
    nome_canal,
    ranking,
    nome_loja,
    total_pedidos
FROM
    pedidos_por_lojista
WHERE
    ranking <= 5
ORDER BY
	nome_canal,
	ranking;


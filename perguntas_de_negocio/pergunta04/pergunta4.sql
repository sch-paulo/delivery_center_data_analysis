/* 
Pergunta 4:
Qual o valor médio de pedido por tipo de pagamento?

Considerações:
* Valor recebido = payment_amount - payment_fee (desconto)
* Apenas pedidos com status "PAID"
*/

SELECT 
	payment_method AS tipo_pagamento,	   
	ROUND(AVG(payment_amount - payment_fee), 2) AS media_pagamento,	   
	ROUND(SUM(payment_amount - payment_fee), 2) AS soma_pagamento_total
FROM 
	payments
WHERE 
	payment_status = 'PAID'
GROUP BY 
	payment_method 
ORDER BY 
	media_pagamento DESC;

with subquery as (SELECT 
	payment_method AS tipo_pagamento,	   
	ROUND(AVG(payment_amount - payment_fee), 2) AS media_pagamento,	   
	ROUND(SUM(payment_amount - payment_fee), 2) AS soma_pagamento_total
FROM 
	payments
WHERE 
	payment_status = 'PAID'
GROUP BY 
	payment_method 
ORDER BY 
	media_pagamento DESC
)
select *, (soma_pagamento_total/sum(soma_pagamento_total) over())*100 as percentual
from subquery;

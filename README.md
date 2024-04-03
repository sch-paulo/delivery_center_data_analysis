# Projeto de Análise de Dados - Delivery Center

Este projeto consiste em uma análise de dados do Delivery Center, uma plataforma que integra lojistas e marketplaces para vendas de produtos e alimentos no varejo brasileiro. 

Para tal, foi utilizado SQL para responder perguntas de negócio e o Power BI para visualização geral dos números disponíveis da empresa. Nos arquivos, você também pode conferir uma apresentação com os principais insights levantados durante a análise.

## Datasets

Os dados utilizados são representados em um modelo lógico de banco de dados no formato de tabela, incluindo informações sobre canais de venda, entregas, entregadores, HUBs, pedidos, pagamentos e lojistas.

## Perguntas de Negócio

1. Quais canais de venda geram mais receita para o Delivery Center?
2. Qual a média de tempo de entrega por região?
3. Quantos entregadores únicos entregaram mais de 100 pedidos no período?
4. Qual o valor médio de pedido por tipo de pagamento?
5. Top 15 lojas que mais geram receita entre fevereiro e março?
6. Qual o crescimento percentual mensal no número de pedidos por cidade/hub de distribuição?
7. Quem são os 5 entregadores com a maior média de entregas por dia, e como essa média varia mês a mês?
8. Quais são os hubs com aumento de pedidos acima de 20% de fevereiro para março?
9. Qual a relação entre o número de entregas realizadas e o número de pedidos, por lojista?
10. Qual o ranking dos top 10 lojistas com mais pedidos em cada canal de venda?

## Powerpoint Apresentado

A apresentação inclui insights sobre a empresa, cidades, hubs, entregas, entregadores, lojas, canais de venda e pagamentos. Além disso, um plano de ação foi proposto com medidas para melhorar o desempenho da empresa.

## Instalação
Foi utilizado a biblioteca SQLAlchemy em Python para realizar a conexão dos datasets, que estão em .csv, para o banco de dados *delivery_center* criado.

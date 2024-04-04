# Projeto de Análise de Dados - Delivery Center

<p align="center">
  <img src="https://github.com/sch-paulo/delivery_center_data_analysis/assets/132720763/a8e2b9d2-a87e-4ecb-8870-9ce5d750399a" alt="Descrição da imagem">
</p>

Este projeto consiste em uma análise de dados do Delivery Center, uma plataforma que integra lojistas e marketplaces para vendas de produtos e alimentos no varejo brasileiro. 

Para tal, foi utilizado SQL para responder perguntas de negócio e o Power BI para visualização geral dos números disponíveis da empresa. Nos arquivos, você também pode conferir uma apresentação com os principais insights levantados durante a análise.

## Conjuntos de dados

Os dados utilizados estão distribuídos em sete tabelas, com informações sobre canais de venda, entregas, entregadores, HUBs, pedidos, pagamentos e lojistas.

O modelo lógico do banco de dados é apresentado no seguinte formato:

![image](https://github.com/sch-paulo/delivery_center_data_analysis/assets/132720763/1bf4a1ff-c85a-4115-924c-c5e7b267bad1)


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

## Apresentação

A apresentação inclui insights sobre a empresa, cidades, HUBs, entregas, entregadores, lojas, canais de venda e pagamentos. Ao final, um plano de ação é proposto com medidas para melhorar o desempenho da empresa.

## Instalação
Foi utilizado a biblioteca SQLAlchemy em Python para realizar a conexão dos datasets, que estão em .csv, para o banco de dados *delivery_center* criado.

O passo a passo está demonstrado no arquivo `conexao_sql.ipynb`.

# Previsão de fraude em cartões de crédito

## Introdução 

Neste conjunto de dados, mergulhamos nas transações de cartão de crédito na Europa durante setembro de 2013. Ao longo de dois dias, foram registradas 284.807 transações, sendo apenas 492 delas consideradas fraudulentas (0,172%). As variáveis são todas numéricas, resultado de uma transformação PCA (que além de reduzir a dimensionalidade dos dados, codificou os dados sensíveis para não expor as transações realizadas durante o período), com exceção de 'Time' (tempo) e 'Amount' (valor).

## Objetivo

O principal propósito deste estudo é a criação de um modelo preditivo capaz de antecipar e identificar transações fraudulentas, utilizando o aprendizado adquirido por meio do dataset fornecido. A antecipação eficaz de fraudes é de extrema importância para as operadoras de cartões de crédito, visando a proteção dos clientes e a manutenção da integridade financeira. Ao desenvolver esse modelo, buscamos fortalecer a capacidade de identificar comportamentos não autênticos, permitindo uma detecção precoce de atividades suspeitas e, assim, mitigando potenciais prejuízos.

Mais informações sobre o dataset pode ser encontrada atráves do kaggle: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

## Metodologia 

Iniciamos com uma análise exploratória dos dados, identificando o desbalanceamento do conjunto de dados. Implementamos técnicas de balanceamento usando a biblioteca imbalanced-learn, incluindo Random Under Sampling e Random Over Sampling, mas observamos limitações em relação ao trade-off entre precisão e recall. Dentro das características do Under e Over sampling, exploramos diversas técnicas para identificar qual teria um melhor desempenho em nossa lista de dados.

Durante o projeto também realizamos análises da curva ROC (Receiver Operating Characteristic) e da AUC (Area Under the Curve) para avaliar o desempenho geral dos modelos. Essas métricas nos permitiram medir a sensibilidade e a especificidade dos modelos de maneira mais abrangente.

## Conclusão 

Nossa abordagem combinada de balanceamento de dados e ajuste de hiperparâmetros resultou em melhorias significativas na detecção de transações fraudulentas.

Para transações acima de 1 milhão de reais, identificamos que o modelo de Machine Learning - Decision Tree, utilizando Random Under Sampling através do Cluster Centroids, obteve um recall de (TP) com 98% de previsão das fraudes. Em contrapartida teve apenas 0.22% de previsão com 25% de acurácia, prevendo com eficiência as fraudes nesse segmento. Em nosso problema de negócio, isso significa que teríamos que ter uma enorme equipe para ligar ao cliente e confirmar se ocorreu uma fraude ou não com o cliente. Portanto, para contornar esse problema seria interessante limitar esse modelo para prever transações acima de 1mi (que acertaria 98% das fraudes) e para evitar ter que contratar uma equipe enorme para confirmar com o cliente se ocorreu fraude (e também melhorar a experiência do cliente sem ligações a todo momento). evitando uma sobrecarga operacional.


Para transações menores, optamos pelo modelo de Machine Learning - Random Forest, realizando um Random Over Sampling através do método ADASYN. Após ajustes de hiperparâmetros com GridSearch, o modelo alcançou 80,75% de Precisão e 86,09% de Recall, com 99,94% de acurácia. Embora preveja menos fraudes (correta e incorretamente) em comparação com transações acima de 1 mi, sua eficiência e precisão reduz a necessidade de uma equipe extensa para lidar com falsos positivos em fraudes.


Esta abordagem equilibrada visa garantir a segurança financeira dos clientes, ao mesmo tempo que otimiza a operação e a experiência do usuário.


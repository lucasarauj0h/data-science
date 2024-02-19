# Análise de dados RH da IBM com SQL (MySQL)

## Introdução

A análise de dados de Recursos Humanos (RH) desempenha um papel crucial na compreensão dos fatores que influenciam eventos como 'attrition' e 'turnover', que se referem à saída de funcionários de uma organização. Neste projeto, realizaremos uma análise dos dados fictícios de RH da IBM, por meio de consultas em SQL, com o objetivo de compreender os motivos que levam os funcionários a deixarem a empresa e como melhorar o ambiente de trabalho e a retenção de talentos. Esta análise é essencial para o desenvolvimento de estratégias eficazes de gerenciamento de recursos humanos e para otimizar o desempenho organizacional. 

### Dados 

Os dados foram retirados do [Kaggle](https://www.kaggle.com/), do dataset denominado [“IBM HR Analytics Employee Attrition & Performance”](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset/data).


## Metodologia

Para conduzir a análise, utilizaremos consultas em SQL para explorar os dados do conjunto "IBM HR Analytics Employee Attrition & Performance". Primeiramente, faremos uma exploração geral dos dados para compreender a estrutura e os tipos de variáveis disponíveis. Em seguida, realizaremos análises mais aprofundadas para identificar padrões e insights relevantes sobre os fatores que influenciam a saída de funcionários da empresa.

## Considerações Finais
Essa análise dos dados de RH da IBM revelou alguns insights sobre fatores que influenciam o atrito de funcionários. Nesse sentido, serão destacados os principais achados nesse estudo.
* Departamento de Vendas possui a maior taxa de atrito, com 20,63%, seguido pelos Recursos Humanos com 19,05%. O departamento de Pesquisa & Desenvolvimento tem a menor taxa, com 13,84%;
* A média salarial das pessoas que saíram da empresa é menor do que a média salarial dos funcionários que permaneceram;
* Aproximadamente metade dos funcionários que saíram da empresa relataram fazer horas extras. Em contrapartida, mais de 75% dos funcionários que permaneceram na empresa não fazem horas extras;
* Funcionários em níveis iniciais do trabalho podem estar mais propensos a deixar a empresa;
* Funcionários mais jovens (18–29 anos) têm a maior taxa de atrito, enquanto os colaboradores mais experientes têm uma taxa de atrito baixa;
* Viagens frequentes a negócios podem influenciar a decisão de um colaborador permanecer na empresa, sobretudo em relação aos colaboradores solteiros;
* Funcionários que moram mais longe do trabalho tendem a apresentar taxas de atrito mais altas;
* Colaboradores com baixo número de treinamentos apresentaram uma taxa de atrito mais alta;
* Uma menor taxa de envolvimento do colaborador com a empresa, gera uma maior taxa de atrito; 

### Propostas de soluções 

Nesse sentido, é importante ressaltar que, para melhorar o ambiente organizacional e reduzir a taxa de atrito, existem diversas estratégias adicionais que podem ser implementadas:
Programas de Mentoria: Estabelecer programas de mentoria que conectem funcionários mais experientes a colegas mais jovens pode criar laços profissionais e pessoais sólidos, promovendo um senso de pertencimento e crescimento na empresa;
* Benefícios e Flexibilidade: Oferecer benefícios que abordem as necessidades individuais dos funcionários, como flexibilidade no horário de trabalho, opções de trabalho remoto e benefícios de bem-estar, pode melhorar a satisfação e o equilíbrio entre trabalho e vida pessoal;
* Programas de Bônus de Salário: Implementar programas de bônus salarial, incluindo bonificação de desempenho individual, de equipe, de tempo de serviço e de indicação de novos talentos;
* Feedback e Reconhecimento Constantes: Implementar sistemas eficazes de feedback e reconhecimento para garantir que os funcionários se sintam valorizados e tenham a oportunidade de crescimento dentro da empresa;
* Realizar pesquisas de satisfação dos funcionários: Essas pesquisas podem ajudar a identificar áreas de melhoria e a tomar medidas para atender às necessidades dos funcionários;
* Criar um canal de comunicação aberto e transparente: Isso pode ajudar a construir confiança entre os funcionários e a empresa.

Além dessas recomendações, é importante que a empresa esteja atenta às mudanças no mercado de trabalho e nos desejos dos funcionários. Isso pode ajudar a identificar novas oportunidades para melhorar o ambiente de trabalho e, consequentemente, diminuir a taxa de atrito.

## Algumas tabelas das querys realizadas para os insights

#### A média salarial das pessoas que saíram da empresa é menor do que a média salarial dos funcionários que permaneceram;
  
<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query5.png"/>

#### Aproximadamente metade dos funcionários que saíram da empresa relataram fazer horas extras. Em contrapartida, mais de 75% dos funcionários que permaneceram na empresa não fazem horas extras;

- Funcionarios que permanecem na empresa
<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query10.png"/>

- Funcionarios que saíram da empresa
<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query9.png"/>

#### Funcionários em níveis iniciais do trabalho podem estar mais propensos a deixar a empresa;

<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query11.png"/>

#### Funcionários mais jovens (18–29 anos) têm a maior taxa de atrito, enquanto os colaboradores mais experientes têm uma taxa de atrito baixa;

<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query15.png"/>

#### Viagens frequentes a negócios podem influenciar a decisão de um colaborador permanecer na empresa, sobretudo em relação aos colaboradores solteiros;
  
<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query16.png"/>

#### Funcionários que moram mais longe do trabalho tendem a apresentar taxas de atrito mais altas;

<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query17.png"/>

#### Colaboradores com baixo número de treinamentos apresentaram uma taxa de atrito mais alta;

<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query19.png"/>

#### Uma menor taxa de envolvimento do colaborador com a empresa, gera uma maior taxa de atrito; 

<img src="https://github.com/lucasarauj0h/data-science/blob/main/sql/projeto-sql-rh/querys/query12.png"/>











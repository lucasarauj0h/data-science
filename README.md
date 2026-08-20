# Portfólio de Ciência de Dados

Projetos de análise de dados, machine learning, SQL e automação desenvolvidos para investigar problemas de negócio e questões sociais com Python.

## Projetos em destaque

| Projeto | Problema | Abordagem | Resultado ou conclusão principal |
| --- | --- | --- | --- |
| [Detecção de fraude em cartões](analises/credit_fraud/) | Identificar uma classe extremamente rara de transações fraudulentas | Random Forest, ADASYN, Cluster Centroids, GridSearchCV e Precision-Recall | No cenário documentado com Random Forest + ADASYN: 80,75% de precisão e 86,09% de recall |
| [Campeonato Brasileiro 2003-2023](analises/campeonato_brasileiro/) | Testar mitos e padrões do futebol brasileiro | Análise exploratória, estatística descritiva e visualização | Vantagem do mandante confirmada; efeito da ausência de torcida foi limitado nos dados analisados |
| [Performance olímpica dos países-sede](analises/olympics_perfomances/) | Investigar se sediar os Jogos está associado a mais medalhas | Engenharia de dados, mapas, visualização e testes estatísticos | Os dados sugerem vantagem dos anfitriões, com ressalvas sobre renda e investimento esportivo |
| [RH da IBM com SQL](sql/projeto-sql-rh/) | Investigar fatores associados à saída de funcionários | Consultas analíticas em MySQL | Foram identificadas diferenças por departamento, salário, horas extras, idade e viagens |

## Análises exploratórias

| Projeto | Pergunta central |
| --- | --- |
| [Campeonato Brasileiro](analises/campeonato_brasileiro/) | Os dados sustentam mitos conhecidos sobre torcida, clássicos e desempenho dos campeões? |
| [Performance olímpica](analises/olympics_perfomances/) | Sediar uma Olimpíada está associado a melhor desempenho no quadro de medalhas? |
| [ENEM e perfil socioeconômico](analises/enem_socioeconomico/) | Como renda, escolaridade dos pais e tipo de escola se relacionam com as notas? |
| [Ativos durante a pandemia](analises/ativos_durante_pandemia/) | Como preços e volatilidade de ativos brasileiros se comportaram em 2020? |
| [Acidentes fatais em São Paulo](analises/acidentes_fatais_sp/) | Quem são as vítimas e onde, quando e como os acidentes fatais acontecem? |

## Machine learning

| Projeto | Técnicas principais |
| --- | --- |
| [Detecção de fraude](analises/credit_fraud/) | Classificação desbalanceada, amostragem, ajuste de hiperparâmetros e AUC-PR |
| [Titanic](https://github.com/lucasarauj0h/titanic-previsao) | Engenharia de atributos, comparação de modelos e GridSearchCV |

## SQL

| Projeto | Conteúdo |
| --- | --- |
| [Análise de RH da IBM](sql/projeto-sql-rh/) | Consultas MySQL sobre attrition, remuneração, horas extras e perfil dos funcionários |
| [Estudos de SQL](sql/sql-aulas/) | Exercícios e casos desenvolvidos durante formações em SQL |

## Automações

| Projeto | O que faz |
| --- | --- |
| [Assistente virtual](automacoes/AssistenteVirtual/) | Reconhece comandos de voz e executa tarefas locais |
| [Envio de e-mails](automacoes/envio-emails/) | Automatiza o envio de mensagens a partir de dados estruturados |
| [Leitor de imagens](automacoes/leitor-de-imagens/) | Extrai texto de imagens por OCR |
| [Notícias](automacoes/noticias/) | Coleta notícias, abre a matéria no navegador e gera um resumo |
| [Busca por vagas](automacoes/WebScraping_API/) | Coleta vagas de análise de dados e organiza os resultados em planilha |

## Organização do repositório

```text
data-science/
├── analises/    # EDA, visualização e machine learning
├── sql/         # consultas e estudos de caso em bancos relacionais
└── automacoes/  # scripts para tarefas, coleta e integração
```

Cada projeto possui seu próprio notebook, script ou README. Os projetos em destaque contêm contexto do problema, metodologia e conclusões.

## Tecnologias aplicadas

- Python, pandas, NumPy e Jupyter.
- Matplotlib, Seaborn e visualização geoespacial.
- scikit-learn e imbalanced-learn.
- MySQL e SQL analítico.
- Beautiful Soup, Selenium, OCR e automação de tarefas.

## Reprodutibilidade e limitações

Os projetos foram produzidos em diferentes etapas de aprendizado e podem exigir ambientes distintos. Antes de executar um notebook:

1. Consulte o README do projeto escolhido.
2. Verifique a fonte e a licença dos dados.
3. Ajuste os caminhos locais dos arquivos.
4. Instale as bibliotecas importadas pelo notebook.

Resultados de análises observacionais representam associações encontradas nos dados e não devem ser interpretados automaticamente como relações causais.

No projeto de fraude, a moeda e qualquer transformação aplicada à variável `Amount` precisam ser confirmadas antes de associar limites numéricos a valores em reais.

## Status

Portfólio em evolução. A documentação é priorizada nos projetos em destaque, enquanto exercícios de cursos permanecem como registro de aprendizado.


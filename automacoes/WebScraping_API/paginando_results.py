import requests
from pprint import pprint
from collections import Counter
import pandas as pd

# 1 - Autenticando o github
access_token = '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'
headers = {
    'Authorization': 'Bearer '+access_token,
    'X-GitHub-Api-Version': '2022-11-28'
}

# 2 - Mapeando as informações
base_api = 'https://api.github.com'
user = 'Onebitcodeblog'
url = f'{base_api}/users/{user}/repos?page=2'

# 3 - Organizando os dados
repos_list = []
for page_num in range(1, 3):
    try:
        url_page = f'{url}?page={page_num}'
        response = requests.get(url, headers= headers)
        repos_list.append(response.json())
    except:
        repos_list.append(None)
        
pprint(len(repos_list))
pprint(repos_list[0][6]['name'])

# 4 - Pegando o nome de cada repositorio
name_repos = []
for page in repos_list:
    for repo in page:
        name_repos.append(repo['name'])
print(len(name_repos))
print(name_repos[:10])

# 5 - Pegando as linguagens de cada repositório
lang_repos = []
for page in repos_list:
    for repo in page:
        lang_repos.append(repo['language'])
        
print(len(lang_repos))
print(name_repos[:10],lang_repos[:10])

# 6 - contando as ocorrencias da linguagem
print(Counter(lang_repos))

# 7 - criando um dataframe
dados_obc = pd.DataFrame()
dados_obc['repo_name'] = name_repos
dados_obc['repo_lang'] = lang_repos
print(dados_obc)

# 8 - Exportando para CSV
dados_obc.to_csv('obc.csv')
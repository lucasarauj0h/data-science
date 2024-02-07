import requests
from pprint import pprint

# 1 - Mapeando as informações
base_api = 'https://api.github.com'
user = 'Onebitcodeblog'
url = f'{base_api}/users/{user}/repos'
# print(url)

# 2 - Realizando a requisição
response = requests.get(url)
print(len(response.json()))
pprint(response.json())

# Token github: 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
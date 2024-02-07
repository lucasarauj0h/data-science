import requests
from pprint import pprint

url = ('https://api.github.com/events')
response = requests.get(url)
# pprint(response.json())

# Vamos verificar a versão da api

print(requests.get('https://api.github.com/versions').json())

# Realizando a requisição com a versão especifica
headers = {
    'X-GitHub-Api-Version': '2022-11-28'
}
response2 = requests.get(url, headers=headers)

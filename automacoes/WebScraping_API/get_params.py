import requests
from pprint import pprint
# API JsonPlaceholder

url = 'https://jsonplaceholder.typicode.com/posts/'

# Adicionando um payload
payload = {
    "id": [1,2,3,4,5],
    "userId": 1
}

# 'Quero pegar 5 posts onde os posts sejam do id 1,2,3,4,5 e sejam do usuário de id 1'

# Realizando a requisição
response = requests.get(url, params=payload)
print(response)
pprint(response.json())
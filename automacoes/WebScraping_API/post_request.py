import requests
from pprint import pprint
# API JsonPlaceholder

# criando dados em formato 'json' - (dict) dados em formato json 
new_data = {
    'userId': 1,
    'id': 1,
    'title': 'Aprendendo python',
    'body': 'Manipulando Informações da API com requests'
    
}

url = 'https://jsonplaceholder.typicode.com/posts'

# Enviando os dados para a API

post_request = requests.post(
    url,
    json=new_data
)

print(post_request.status_code)


# Listar a informação 
post_response_json = post_request.json()
pprint(post_response_json)
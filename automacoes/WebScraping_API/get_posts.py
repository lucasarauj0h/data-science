import requests
from pprint import pprint
# API JsonPlaceholder

url = 'https://jsonplaceholder.typicode.com/posts/1'

# Requisição GET

response = requests.get(url)
print(response, type(response))

# Recolhendo esses dados

response_json = response.json()
pprint(response_json)
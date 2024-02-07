import requests

print(requests.__version__)

# 1 - Realizando uma requisição GET
link = 'https://www.google.com/search?q=flu'

requisicao = requests.get(link) # faça uma requisição no meu 'link'
print(requisicao) 
print(requisicao.status_code) 
# O codigo response [200] nos mostra que a requisição foi concluida com sucesso
print(requisicao.text) 

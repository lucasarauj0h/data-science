from requests import get
from bs4 import BeautifulSoup 
# Instalar ambas as bibliotecas



# 1 - Coletando as 3 ultimas notícias do site rss
def ultimas_noticias():
    url = 'https://news.google.com/rss?gl=BR&hl=pt-BR&ceid=BR:pt-419'
    site = get(url)
    noticias = BeautifulSoup(site.text, 'html.parser')

    for item in noticias.findAll('item')[:3]:
        titulo = item.title.text
        return titulo

ultimas_noticias()
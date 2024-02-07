import requests
from bs4 import BeautifulSoup
from pprint import pprint

class Site:
    def __init__(self, opcao:str):
        self.opcao = opcao
        
    def update_news(self):
        if self.opcao.lower() == 'globo':
            url = 'https://www.globo.com'
            browsers = {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 \(KHTML, like Gecko) Chrome / 86.0.4240.198Safari / 537.36"}
            
            # Fazendo uma requisição com o requests
            page = requests.get(url, headers = browsers)
            resposta = page.text
            
            soup = BeautifulSoup(resposta, 'html.parser')
            
            # Pegando todos os links disponiveis no site da globo
            noticias = soup.find_all('a')
            
            # Verificando no site, todas as noticias contem a tag 'post__title' e post-multicontent__link--title__text
            
            tg_class1 = 'post__title'
            tg_class2 = 'post-multicontent__link--title__text'
            
            # A noticia da globo começa com a estrutura h2
            news_dict_globo = {}
            for noticia in noticias:
                if noticia.h2 != None:
                    if tg_class1 in noticia.h2.get('class') or tg_class2 in noticia.h2.get('class'):
                        news_dict_globo[noticia.h2.text] = noticia.get('href')
            
            self.news = news_dict_globo
            
        if self.opcao.lower() == 'cnn':
            url = 'https://www.cnnbrasil.com.br/'
            browsers = {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 \(KHTML, like Gecko) Chrome / 86.0.4240.198Safari / 537.36"}

            # Fazendo uma requisição com o requests
            page = requests.get(url, headers = browsers)
            # print(page)
            resposta = page.text

            soup = BeautifulSoup(resposta, 'html.parser')

            # # Pegando todos os links disponiveis no site da globo
            noticias = soup.find_all('a')
            # print(noticias)
            # Verificando no site, todas as noticias contem a tag 'block__news__title'

            tg_class1 = 'block__news__title'

            # As noticia da cnn começa com a estrutura h2; h3 e h4
            news_dict_cnn = {}
            for noticia in noticias:
                if noticia.h2 != None:
                    if tg_class1 in noticia.h2.get('class'):
                        news_dict_cnn[noticia.h2.text] = noticia.get('href')
                
                if noticia.h3 != None:
                    if tg_class1 in noticia.h3.get('class'):
                        news_dict_cnn[noticia.h3.text] = noticia.get('href')
            
                if noticia.h4 != None:
                    if tg_class1 in noticia.h4.get('class'):
                        news_dict_cnn[noticia.h4.text] = noticia.get('href')                            

            self.news = news_dict_cnn
            
        if self.opcao.lower() == 'veja':
            url = 'https://veja.abril.com.br/'
            browsers = {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 \(KHTML, like Gecko) Chrome / 86.0.4240.198Safari / 537.36"}

            # Fazendo uma requisição com o requests
            page = requests.get(url, headers = browsers)
            # print(page)
            resposta = page.text

            soup = BeautifulSoup(resposta, 'html.parser')

            # Pegando todos os links disponiveis no site da globo
            noticias = soup.find_all('a')
            # pprint(noticias)
            # Verificando no site, todas as noticias contem a tag 'block__news__title'

            tg_class1 = 'title'

            # A noticia da veja começa com a estrutura h2; h3 e h4
            news_dict_veja = {}
            for noticia in noticias:
                
                if noticia.h2 != None:
                    if tg_class1 in noticia.h2.get('class'):
                        news_dict_veja[noticia.h2.text] = noticia.get('href')
                
                if noticia.h3 != None:
                    if tg_class1 in noticia.h3.get('class'):
                        news_dict_veja[noticia.h3.text] = noticia.get('href')

                if noticia.h4 != None:
                    if tg_class1 in noticia.h4.get('class'):
                        news_dict_veja[noticia.h4.text] = noticia.get('href') 
            self.news =  news_dict_veja
                        
        if self.opcao.lower() == 'r7':
            
            url = 'https://www.r7.com/'
            browsers = {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 \(KHTML, like Gecko) Chrome / 86.0.4240.198Safari / 537.36"}

            # Fazendo uma requisição com o requests
            page = requests.get(url, headers = browsers)
            # print(page)
            resposta = page.text

            soup = BeautifulSoup(resposta, 'html.parser')

            # Pegando todos os links disponiveis no site da globo
            noticias = soup.find_all('a')
            # pprint(noticias)
            # Verificando no site, todas as noticias contem a tag 'block__news__title'
            target_class_1 = 'r7-flex-title-h3__link'
            target_class_2 = 'r7-flex-title-h4__link'
            target_class_3 = 'r7-flex-title-h5__link'
            target_class_4 = 'r7-flex-title-h6__link'
            # pprint(noticias)
            news_dict_r7 = {}
            for noticia in noticias:
                # print(noticia)
                # print(noticia.get('title'))
                # print(noticia.get('class'))
                # print(noticia.get('href'))
                if noticia.get('class') != None:
                    if target_class_3 in noticia.get('class') or target_class_4 in noticia.get('class') or target_class_2 in noticia.get('class') or target_class_1 in noticia.get('class'):
                        news_dict_r7[noticia.get('title')] = noticia.get('href')
            
            self.news = news_dict_r7
                       
self = Site('globo')

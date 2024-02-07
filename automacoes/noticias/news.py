from scraping_sites.site import *
import os
from threading import Thread # Permitir multiplas execução de códigos
import time
from datetime import datetime
import sys
import pickle
import webbrowser
from math import ceil 
from pytimedinput import timedInput
from resumir import resume

class News:
    def __init__(self):
        self.dict_site = {}
        self.all_sites = ['veja', 'r7', 'cnn', 'globo']
        
        self.screen = 0
        self.kill = False
        
        self.page = 1
        
        # Armazenando os sites listados, juntamente com as noticias.
        self.news = self._read_file('news') if 'news' in os.listdir() else []
        self._update_file(self.news, 'news')
        self.sites = self._read_file('sites') if 'sites' in os.listdir() else []
        self._update_file(self.sites, 'sites')
        
        # Instanciando as noticias
        for site in self.all_sites:
            self.dict_site[site] = Site(site)
            
        # Utilizando o modulo Thread para atualizar as noticias a parte.
        self.news_thread = Thread(target=self.update_news)
        self.news_thread.setDaemon(True) # Se o programa em python for fechado, a thread continuará rodando
        self.news_thread.start()
        
    
    def _update_file(self, lista, mode='news'):
        with open(mode, 'wb') as fp:
            pickle.dump(lista, fp)

    def _read_file(self, mode='news'):
        with open(mode, 'rb') as fp:
            n_list = pickle.load(fp)
            return n_list
            
    def _receive_command(self, valid_commands, timeout=30):
        command, timed = timedInput('>>', timeout)
        while command.lower() not in valid_commands and not timed:
            print("Comando inválido. Digite novamente\n")
            command, timed = timedInput('>>', timeout)
        command = 0 if command == '' else command
        return command
        
        
        
    def main_loop(self):
        while True:
            os.system('cls' if os.name == 'nt' else 'clear')
            match self.screen:
                # Case 0 -> Tela principal
                case 0:
                    print('SEJA BEM VINDO AO MUNDO PORTAL DAS NOTICIAS')
                    print('Por favor, escolha algum item do menu')
                    print('')
                    print('1. Ultimas Notícias\n2. Adicionar site\n3. Remover site\n4. Fechar o programa')
                    
                    print(f"\nTotal de notícias armazenadas: {len(self.news)}\n")
                    
                    self.screen = int(self._receive_command(['1', '2', '3', '4'], 10))
                    
                # Listando as noticias
                case 1:
                    
                    self.display_news()
                    command = self._receive_command(['p', 'a', 'l', 'v'], 10)
                    match command:
                        case 'p':
                            if self.page < self.max_page: self.page += 1
                        
                        case 'a':
                                if self.page > 1: self.page -= 1
                        
                        case 'v':
                            self.screen = 0
                            continue
                    
                        case 'l':
                            link = int(input('>> Insira o numero da materia que deseja abrir: '))
                            if link < 1 or link > len(self.filtered_news):
                                print('Materia inexistente!')
                            else:
                                resume(self.filtered_news[link-1])
                                webbrowser.open(self.filtered_news[link-1]['link'])
                                # if platform == "linux" or platform == "linux2": # Linux
                                #     chrome_path = '/usr/bin/google-chrome %s'
                                # elif platform == "darwin": # OS X
                                #     chrome_path = 'open -a /Applications/Google\ Chrome.app %s'
                                # elif platform == "win32": # Windows
                                #     chrome_path = r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
                                # webbrowser.get(f"\"{chrome_path}\" %s").open(link)
                
                # Adicionando sites
                case 2:
                    os.system('cls' if os.name == 'nt' else 'clear')
                    print('Digite o numero do site que deseja adicionar para a lista de sites ativos.\nPressione 0 para voltar para o menu.')
                    print("\tSITES ATIVOS ===============\n")
                    # Verificando sites ativos
                    for i in self.sites:
                        print('\t', i)
                    
                    # Verificando sites inativos
                    print("\tSITES INATIVOS ===============\n")
                    offline_sites = [i for i in self.all_sites if i not in self.sites]
                    for i in range(len(offline_sites)):
                        print(f'\t{i+1}. {offline_sites[i]}')
                    site= int(self._receive_command([str(i) for i in range(len(offline_sites)+1)], 50))
                    
                    if site == 0:
                        self.screen=0
                        continue
                    self.sites += [offline_sites[site-1]]
                    self._update_file(self.sites, 'sites')

                # Removendo sites        
                case 3:
                    os.system('cls' if os.name == 'nt' else 'clear')
                    print('Digite o numero do site para remove-lo. Caso queira voltar para o Menu, digite 0\n')
                    for i in range(len(self.sites)):
                        print(f'\t{i+1}. {self.sites[i]}')
                    site= int(self._receive_command([str(i) for i in range(len(self.sites)+1)], 50))
                    if site == 0:
                        self.screen=0
                        continue

                    del self.sites[site-1]
                    self._update_file(self.sites, 'sites')
                               
                case 4:
                    self.kill = True
                    sys.exit()
                    

        
        
    def display_news(self):
        os.system('cls' if os.name == 'nt' else 'clear')
        print( f'Último update: {datetime.now().strftime("%d-%m-%Y %H:%M:%S")}')
        
        # Listando as noticias
        self.filtered_news = [i for i in self.news if i['fonte'] in self.sites]     
        self.max_page = 20 if ceil(len(self.filtered_news) / 10) > 20 else ceil(len(self.filtered_news) / 10)
        # self.max_page = 20
        
        if self.page > self.max_page: self.page = 1
        
        constante = (self.page - 1)*10
        
        
        
        for i, article in enumerate(self.filtered_news[constante:constante+10]):
            print (f'{constante+i+1}. {article["data"].strftime("%d-%m-%Y %H:%M")} - {article["fonte"].upper()} - {article["materia"]}\n')
        print(f'page {self.page}/{self.max_page}')
        
        # Rodapé
        print('================================================================\n')
        print('Comandos:')
        print('P - Proxima Pagina | A - Pagina Anterior | L - Abrir materia no navegador | V - Voltar')
        
    def update_news(self):
        os.system('cls' if os.name == 'nt' else 'clear')
        while not self.kill:
            # print('update')
            for site in self.all_sites:
                self.dict_site[site].update_news()

                for key, value in self.dict_site[site].news.items():
                    dict_aux = {}
                    dict_aux['data'] = datetime.now()
                    dict_aux['fonte'] = site
                    dict_aux['materia'] = key
                    dict_aux['link'] = value
                    
                    if len(self.news) == 0:
                        self.news.insert(0, dict_aux)
                        continue
                    
                    add_news = True
                    for news in self.news:
                        if dict_aux['materia'] == news['materia'] and dict_aux['fonte'] == news['fonte']:
                            add_news = False
                            break
                    if add_news:
                        self.news.insert(0, dict_aux)
            self.news = sorted(self.news, key=lambda d: d['data'], reverse=True)
            self._update_file(self.news, 'news')
            time.sleep(10)
                        
   
self = News()
self.main_loop()
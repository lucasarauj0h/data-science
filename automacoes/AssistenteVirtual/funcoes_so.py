import os
from datetime import datetime
import subprocess
    
def verifica_hora():
    hora = datetime.now().strftime('%H:%M') # Definindo a formatação do datetime, apenas em horas e minutos
    frase = f'Agora são: {hora}'
    return frase
    
def desligar_hora():
    os.system('shutdown /s /t 3600')
    frase = f'Agendado para desligar em uma hora'
    return frase
    
def desligar_meiahora():
    os.system('shutdown /s /t 1800')
    frase = f'Agendado para desligar em uma meia hora'
    return frase
    
def cancel_desligar():
    os.system('shutdown /a')
    frase = f'desligamento cancelado'
    return frase

def open_chrome():
    url = 'https://www.google.com'
    command = f'start chrome {url}'
    subprocess.Popen(command, shell=True)
    mensagem = f'Abrindo o Google no Chrome'
    return mensagem
    
def open_edge():
    command = 'start microsoft-edge:https://www.google.com'
    os.system(command)
    mensagem = f'Abrindo o Google no Microsoft Edge'
    return mensagem

# def open_cv():
#     urls = [
#     'https://github.com/lucasarauj0h',
#     'https://sites.google.com/aluno.ufabc.edu.br/portfolio/p%C3%A1gina-inicial',
#     'https://www.linkedin.com/in/lucasarauj0h/'
# ]

#     for url in urls:
#         command = f'start chrome {url}'     
#         subprocess.Popen(command, shell=True)
#     mensagem = f'Abrindo o portfólio de Lucas'
#     return mensagem

def open_cv():
    url = 'https://drive.google.com/file/d/1DFpFxoO6NU71fyISuJSwK94F8-D8FQ2P/view?usp=sharing'
    command = f'start chrome {url}'
    subprocess.Popen(command, shell=True)
    mensagem = f'Abrindo o currículo de Lucas Araujo'
    return mensagem

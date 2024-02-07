from gtts import gTTS
from playsound import playsound
import speech_recognition as sr
import sys
import funcoes_so
import funcoes_noticias
import funcoes_moeda
import os
import time

# 1 - função para criar audio
def criar_audio(audio, mensagem):
    tts = gTTS(mensagem, lang='pt-br')
    tts.save(audio)
    playsound(audio)
    os.remove(audio)
    
# 2 - monitorando audio 
def monitora_audio():
    recon = sr.Recognizer()
    with sr.Microphone() as source:
        while True:
            print("Diga alguma coisa")
            audio = recon.listen(source)
            time.sleep(2)
            try:
                mensagem = recon.recognize_google(audio, language='pt-br')
                mensagem = mensagem.lower()
                print('você disse: ', mensagem)
                executa_comandos(mensagem)
                
                break
            except sr.UnknownValueError:
                pass
            except sr.RequestError:
                pass
            
    return mensagem
    
# 3 - Definindo as ações da assistente virtual
def executa_comandos(acao):
    if 'fechar assistente' in acao:
        sys.exit()
    elif 'python' in acao:
        criar_audio('mensagem.mp3', 'A linguagem python é muito legal')
    elif 'horas' in acao:
        criar_audio('mensagem.mp3', funcoes_so.verifica_hora())
    elif 'desligar computador' in acao and 'uma hora' in acao:
        criar_audio('mensagem.mp3', funcoes_so.desligar_hora())
    elif 'desligar computador' in acao and 'meia hora' in acao:
        criar_audio('mensagem.mp3', funcoes_so.desligar_meiahoraora())
    elif 'cancelar desligamento' in acao:
        criar_audio('mensagem.mp3', funcoes_so.cancel_desligar())
    elif 'notícias' in acao:
        criar_audio('mensagem.mp3', funcoes_noticias.ultimas_noticias())  
    elif 'cotação' in acao and 'dólar' in acao:
        criar_audio('mensagem.mp3', funcoes_moeda.cotacao_moeda('Dólar'))
    elif 'cotação' in acao and 'euro' in acao:
        criar_audio('mensagem.mp3', funcoes_moeda.cotacao_moeda('Euro'))
    elif 'cotação' in acao and 'bitcoin' in acao:
        criar_audio('mensagem.mp3', funcoes_moeda.cotacao_moeda('Bitcoin'))
    elif 'google' in acao:
        criar_audio('mensagem.mp3', funcoes_so.open_edge())
    elif 'chrome' in acao:
        criar_audio('mensagem.mp3', funcoes_so.open_chrome()) 
    elif 'lucas' in acao:
        criar_audio('mensagem.mp3', funcoes_so.open_cv())
        
        

        
def main():
    criar_audio('wellcome.mp3', 'Olá, eu sou a Maria. Em que posso lhe ajudar?')
    while True:
        monitora_audio()
        
main()
            
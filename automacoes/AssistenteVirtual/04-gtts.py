from gtts import gTTS
from playsound import playsound

# 1 - função para criar audio
def criar_audio(mensagem):
    tts = gTTS(mensagem, lang='pt-br')
    tts.save('mensagem.mp3')
    playsound('mensagem.mp3')

# 2 - Utilização da função diretamente
# criar_audio("Aprendendo a linguagem Python para desenvolver Automação")

# 3 - Utilização da função via Input
# frase = input("Digite a frase a ser falada\n")
# criar_audio(frase)

# 4 - Utilização da função via leitura de arquivo

arquivo = open("dados/texto.txt", "r", encoding="utf-8")
conteudo = arquivo.read()
criar_audio(conteudo)
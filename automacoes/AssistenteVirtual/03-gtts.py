from gtts import gTTS
from playsound import playsound
# No GTTS ele apenas salva o audio em um arquivo, precisamos de algo para reproduzi-lo
tts = gTTS('Olá mundo! Bem vindo ao assistente virtual \
            Estamos na trilha de automação com Python.', 
            lang='pt-br'
            )
tts.save('audio.mp3')
playsound('audio.mp3')
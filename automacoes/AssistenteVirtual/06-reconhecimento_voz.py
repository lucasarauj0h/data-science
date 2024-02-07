import speech_recognition as sr
from gtts import gTTS
from playsound import playsound

# 1 - função para criar audio
def criar_audio(audio, mensagem):
    tts = gTTS(mensagem, lang='pt-br')
    tts.save(audio)
    playsound(audio)
    
criar_audio('wellcome.mp3', "Olá, vou reconhecer a sua voz.")

recon = sr.Recognizer()
with sr.Microphone() as source:
    print("Diga alguma coisa\n")
    audio = recon.listen(source)
    
frase = recon.recognize_google(audio, language='pt-br')
criar_audio('mensagem.mp3', frase)
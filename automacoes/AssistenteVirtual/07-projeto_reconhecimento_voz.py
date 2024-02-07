from random import randint
import speech_recognition as sr
from gtts import gTTS
from playsound import playsound

# 1 - função para criar audio
def criar_audio(audio, mensagem):
    tts = gTTS(mensagem, lang='pt-br')
    tts.save(audio)
    playsound(audio)
    
criar_audio('wellcome.mp3', "Escolha um número de 1 a 10")

recon = sr.Recognizer()
with sr.Microphone() as source:
    print("Diga alguma coisa\n")
    audio = recon.listen(source)

word_to_digit = {
    'um': 1,
    'dois': 2,
    'três': 3,
    'quatro': 4,
    'cinco': 5,
    'seis': 6,
    'sete': 7,
    'oito': 8,
    'nove': 9,
    'dez': 10
}



numero = recon.recognize_google(audio, language='pt-br')
resultado = randint(1,10)
print(resultado)

numero_digito = word_to_digit[numero]

if numero_digito == resultado:
    criar_audio('resultado.mp3', 'Parabéns, você acertou o número')
else:
    criar_audio('resultado.mp3', 'Infelizmente você errou. Tente novamente')

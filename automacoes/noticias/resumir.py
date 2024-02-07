# pip install sumy
# pip install goose3
# pip install numpy

from goose3 import Goose
from sumy.parsers.plaintext import PlaintextParser
from sumy.summarizers.luhn import LuhnSummarizer
from sumy.summarizers.lsa import LsaSummarizer
from sumy.nlp.tokenizers import Tokenizer
from datetime import datetime

# 1 - Coletando o artigo
def resume(link):
    # print(link)
    g = Goose()
    url = link['link']
    # print(link['link'])
    noticia = g.extract(url)
    # print(noticia.cleaned_text)

    # 2 - Trabalhando com a sumarização
    parser = PlaintextParser.from_string(
        noticia.cleaned_text,
        Tokenizer('portuguese')
    ) 
    sumarizador = LuhnSummarizer()
    resumo = sumarizador(
        parser.document,
        5 # Número de paragrafos do resumo
    )
    # print(resumo)
    frase = f'{link["data"].strftime("%d-%m-%Y %H:%M")} - {link["fonte"].upper()} - {link["materia"]}'
    for setenca in resumo:
        frase += '\n'+str(setenca)
        
    # print(frase)
    with(open("resume.txt", 'w', encoding='utf-8')) as file:
        file.write(f'{frase}\n')

     
    
           
            
from imbox import Imbox
from datetime import datetime
import pandas as pd

username = 'saculrp06@gmail.com'

# Coletando a senha para acesso ao gmail via smt
caminho = r'C:\Users\Lucas\OneDrive\Documentos\password.txt'

try:
    with open(caminho, 'r') as arquivo:
        password = arquivo.read()
except FileNotFoundError:
    print(f'O arquivo em {caminho} não foi encontrado.')
except Exception as e:
    print(f'Ocorreu um erro: {e}')
    
# Servidor do google para a requisição da leitura
host = 'imap.gmail.com'

mail = Imbox(host, username=username, password=password, ssl=True)
messages = mail.messages(sent_from = 'saculrp06@gmail.com')    

print(len(messages))

for (uid, message) in messages:
    # print(message.subject)
    # print(message.sent_from)
    # print(message.sent_to)
    # print(message.date)
    
    # Extraindo o anexo em pdf e passando para a pasta attachment
    if len(message.attachments) > 0:
        for attach in message.attachments:
            file = open('attachment/report.pdf', 'wb')
            attach['content'].seek(0)
            file.write(attach['content'].read())
            file.close
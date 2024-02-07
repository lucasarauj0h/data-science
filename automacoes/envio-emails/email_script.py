from email.message import EmailMessage
import smtplib
import ssl
import os
import mimetypes

# smt é o servidor que faz a ligação com o gmail

# Coletando a senha para acesso ao gmail via smt
caminho = r'C:\Users\Lucas\OneDrive\Documentos\password.txt'

try:
    with open(caminho, 'r') as arquivo:
        password = arquivo.read()
except FileNotFoundError:
    print(f'O arquivo em {caminho} não foi encontrado.')
except Exception as e:
    print(f'Ocorreu um erro: {e}')
    

from_email = 'saculrp06@gmail.com'
to_email = 'saculrp06@gmail.com'

# Assunto do e-mail
subject = f'CV - Lucas de Araujo Souza (Data Scientist)'
body = open('corpo.txt', 'r', encoding='utf-8').read()

# Estruturando quem enviara o email, qual destinatário e o assunto desse email.
mensagem = EmailMessage()
mensagem['From'] = from_email
mensagem['To'] = to_email
mensagem['Subject'] = subject

# Definindo o conteudo desse e-mail, e atribuindo a segurança necessária
mensagem.set_content(body, subtype='html')
safe = ssl.create_default_context()

# Definindo um anexo
# Caminho da imagem 
anexo_path = 'CV_LucasSouza.pdf'
# Carregando a imagem para um formato aceito no e-mail
mime_type, mime_subtype = mimetypes.guess_type(anexo_path)[0].split('/')
with open(anexo_path, 'rb') as ap:
    mensagem.add_attachment(ap.read(), maintype=mime_type,
                            subtype=mime_subtype, filename=anexo_path)

# Abra uma conexão com o servidor
# parametros: conexão com o gmail, porta de conexão
with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=safe) as smtp:
    smtp.login(from_email, password)
    smtp.sendmail(from_email, to_email, mensagem.as_string())



# !pip install opencv
# !pip install pytesseract
import pytesseract
import cv2

# 1 - Lendo a imagem
img = cv2.imread('img.JPG')

# 2 - Corrigindo o pytesseract para que rode no SO windows:
# Para resolução, acompanhe em: https://stackoverflow.com/questions/50951955/pytesseract-tesseractnotfound-error-tesseract-is-not-installed-or-its-not-i
caminho = r'C:\Program Files\Tesseract-OCR'
pytesseract.pytesseract.tesseract_cmd = caminho + r'\tesseract.exe'
print(pytesseract.get_languages()) # VERIFICANDO LINGUAS DISPONIVEIS (DEPOIS DE INSTALAR O PT-BR)

# 3 - Extraindo o texto da imagem
img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
text = pytesseract.image_to_string(img_gray, lang='por')

print(text)
from requests import get

def cotacao_moeda(moeda):
    if moeda == 'Dólar':
        req = get('https://economia.awesomeapi.com.br/json/last/USD-BRL')
        cotacao = req.json()
        data = cotacao['USDBRL']
        date = data['create_date'].replace(' ', ' às ')
        name = data['name'].replace('/',' para o ')
        value = data['bid']
        mensagem = f'Cotação do {name} atualmente é {value} reais'
        return mensagem
    elif moeda == 'Euro':
        req = get('https://economia.awesomeapi.com.br/json/last/EUR-BRL')        
        cotacao = req.json()
        data = cotacao['EURBRL']
        date = data['create_date'].replace(' ', ' às ')
        name = data['name'].replace('/',' para o ')
        value = data['bid']
        mensagem = f'Cotação do {name} atualmente é {value} reais'
        return mensagem  
    elif moeda == 'Bitcoin':
        req = get('https://economia.awesomeapi.com.br/json/last/BTC-BRL')       
        cotacao = req.json()
        data = cotacao['BTCBRL']
        date = data['create_date'].replace(' ', ' às ')
        name = data['name'].replace('/',' para o ')
        value = data['bid']
        mensagem = f'Cotação do {name} atualmente é {value} reais'    
        return mensagem
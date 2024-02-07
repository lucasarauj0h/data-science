from bs4 import BeautifulSoup
import requests 
import pandas as pd

# 1 - Coletando vagas em python
# print(jobs)

companys = []
skills = []
published_date = []

repos_list = []

for page_num in range(1, 20):
    response = requests.get(f'https://www.timesjobs.com/candidate/job-search.html?from=submit&luceneResultSize=25&txtKeywords=python&postWeek=60&searchType=personalizedSearch&actualTxtKeywords=python&searchBy=0&rdoOperator=OR&pDate=I&sequence=2&startPage={page_num}')
    print(response.status_code)
    print(page_num)
    soup = BeautifulSoup(response.text, 'lxml')
    jobs = soup.find_all('li', class_= 'clearfix job-bx wht-shd-bx')
    for job in jobs:
        name_company = job.find('h3', class_="joblist-comp-name").text.strip()
        # print(name_company)
        skill = job.find('span', class_='srp-skills').text.replace(' ', '').strip()
        # print(skill)
        pub_date = job.find('span', class_='sim-posted').span.text[7:]
        # print(pub_date)
        
        # 3 - Exportando informaçõe para CSV
        companys.append(name_company)
        skills.append(skill)
        published_date.append(pub_date)

python_jobs = pd.DataFrame()
python_jobs['companys'] = companys
python_jobs['skills'] = skills
python_jobs['published_date'] = published_date

print(python_jobs)
python_jobs.to_csv('python_vagas')
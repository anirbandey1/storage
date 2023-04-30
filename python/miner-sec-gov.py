import requests
from bs4 import BeautifulSoup
import json

# url = "https://www.sec.gov/news/press-release/2023-83"
url_press_release:str = "https://www.sec.gov/news/press-release/"

headers:dict = {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246"}

articles:list = []

for article_number in range(1,20,1):
   
    year:str = "2023"
    url:str = f"{url_press_release}{year}-{article_number}"

    print(url)

    req = requests.get(url=url,headers=headers)
    soup = BeautifulSoup(req.content,"html.parser")

    article_body = soup.find('div', attrs={'class':'article-body'}).text
    article_title = soup.find('h1', attrs={'class':'article-title'}).text
    article_date = soup.find('p', attrs={'class':'article-location-publishdate'}).text

    article_date = article_date.replace('\n','').strip()
    article_body = article_body.replace('\n','')

    article_obj = {"article_date":article_date,"article_title":article_title, "article_body":article_body}
    articles.append(article_obj)



article_obj_json = json.dumps(articles)

with open("sec-data.json","w") as f:
    f.write(article_obj_json)
    f.close()



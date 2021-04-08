import requests
from bs4 import BeautifulSoup
import csv
import time

f = open("wedding_naver.csv", "w", encoding='utf-8-sig', newline='')
wr = csv.writer(f)

page = 1
try:
    for page in range(1, 5000, 10):
        raw = requests.get("https://search.naver.com/search.naver?where=news&sm=tab_jum&query=결혼&start="+str(page),
                           headers={"User-Agent":"Mozilla/5.0"})
        html = BeautifulSoup(raw.text, 'html.parser')

        #컨테이너 수집
        articles = html.select("ul.list_news > li")

        #기사 데이터 수집
        for ar in articles:
            title = ar.select_one("a.news_tit").text
            summary = ar.select_one("a.api_txt_lines.dsc_txt_wrap").text


            title = title.replace(",", "")
            summary = summary.replace(",", "")
            
            wr.writerow([title,summary])
            time.sleep(0.05)
except Exception as e:    # 모든 예외의 에러 메시지를 출력할 때는 Exception을 사용
    print('예외가 발생했습니다.', e)
f.close()

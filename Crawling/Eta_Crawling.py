from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import re
import csv
from datetime import datetime, timedelta
from selenium.common.exceptions import TimeoutException
from webdriver_manager.chrome import ChromeDriverManager
# 창없는 크롬으로 크롤링
options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_argument('window-size=360x740')

# 로그인
driver = webdriver.Chrome(ChromeDriverManager().install())
driver.set_window_size(360, 740)
driver.get('https://handong.everytime.kr/login')
id = ''
pw = ''
driver.execute_script("document.getElementsByName('userid')[0].value=\'" + id + "\'")
time.sleep(0.5)
driver.execute_script("document.getElementsByName('password')[0].value=\'" + pw + "\'")
time.sleep(0.5)
driver.find_element_by_xpath('//*[@id="container"]/form/p[3]/input').click() #엔터 없이 바로 연결

def make_link():
    page = 1
    links = []
    start_time = time.time()
    while True:
        # 전체게시판 "결혼" 검색 주소
        driver.get('https://everytime.kr/search/all/%EC%B6%9C%EC%82%B0/p/'+str(page))
        try:
            # id가 "writeArticleButton"인 element가 로딩될때까지 200초 대기
            #WebDriverWait(driver, 300).until(EC.presence_of_all_elements_located((By.ID, "writeArticleButton")))
            WebDriverWait(driver, 300).until(EC.presence_of_all_elements_located((By.CLASS_NAME, "pagination")))
        except TimeoutException:
            # 실패시 타임아웃 출력 
            print('time out')
            continue
        # HTTP get request 
        req = driver.page_source
        
        # BeautifulSoup으로 html소스를 python객체로 변환하기
        soup = BeautifulSoup(req, 'html.parser')
        # findAll : 태그에 들어있는 텍스트만 선택해서 고유명사로 이루어진 파이썬 리스트 추출
        ############ 정규 표현식 공부
        linkList = soup.findAll("a", href=re.compile("(\/\d{6}\/v\/)"))
        
        # 마지막 페이지인지 확인
        if len(linkList) < 20:
            break

        # 테스트용
        #if page == 3:
        #    break

        for link in linkList:
            links.append(link.attrs['href'])
        print(page)

        # 한번에 한페이지씩 크롤링하기 위해 추가
        while True:
            if not links:
                break
            crawling(links.pop()) #함수이름(밑에 정의)

        if time.time() - start_time > 3600:
            driver.delete_all_cookies()
            driver.get('https://handong.everytime.kr/login')
            print('session clear')
            driver.find_element_by_name('userid').send_keys(id)
            driver.find_element_by_name('password').send_keys(pw)
            driver.find_element_by_class_name('submit').click()
            start_time = time.time()

        page += 1


def crawling(link):
    driver.get('https://handong.everytime.kr' + str(link))
    try:
        WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "#container > "
                                                                                              "div.articles > article"
                                                                                              " > a.article")))
    except TimeoutException:
        print('time out_crawling')
        return
    req = driver.page_source
    soup = BeautifulSoup(req, 'html.parser')
    title_time = soup.find('div', {'class': 'profile'}).find('time').text
    # ~분전이라고 표시되는 게시물이 존재함
    if '분' in title_time:
        time_to_int = int(re.findall('\d+', title_time)[0])
        now = datetime.now()
        after = now + timedelta(minutes=-time_to_int)
        title_time = str(after.month)+'/'+str(after.day)+' '+str(after.hour)+':'+str(after.minute)
    elif '방금' in title_time:
        now = datetime.now()
        title_time = str(now.month)+'/'+str(now.day)+' '+str(now.hour)+':'+str(now.minute)

    # 제목 
    title = soup.find('div', {'class': 'wrap articles'}).article.h2#.text
    writeCSV('title', title, title_time)
    # 내용
    content = soup.find('div', {'class': 'wrap articles'}).article.a.p.text
    writeCSV('content', content)
    # 댓글
    for commentObj in soup.find('div', {'class': 'comments'}).children:
        try:
            comment = commentObj.find('p').text
            comment_time = commentObj.find('time').text
            if '분' in comment_time:
                time_to_int = int(re.findall('\d+', comment_time)[0])
                now = datetime.now()
                after = now + timedelta(minutes=-time_to_int)
                comment_time = str(after.month) + '/' + str(after.day) + ' ' + str(after.hour) + ':' + str(after.minute)
            elif '방금' in comment_time:
                now = datetime.now()
                comment_time = str(now.month) + '/' + str(now.day) + ' ' + str(now.hour) + ':' + str(now.minute)

            writeCSV('comment', comment, comment_time)
        except AttributeError:
            pass

    print(link)

# csv작성하는 함수
def writeCSV(text_type, content, date=None):
    f = open('love_eta_week15(2).csv', 'a', encoding='utf-8-sig', newline='')
    wr = csv.writer(f)
    if date is None:
        wr.writerow([text_type, content])
        time.sleep(0.1)
    else:
        wr.writerow([text_type, content, date])
        time.sleep(0.1)

make_link()
print('끝')
driver.close()

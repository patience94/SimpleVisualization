# SimpleVisualization

### Description


2020-2학기 수업 과제 프로젝트로 진행했던 간단한 시각화 작업이다. 국가통계포털에서 OECD 합계출산율, 국내 합계출산율, 출생아수, 주요 인구지표 등의 통계데이터와 '네이버'와 '에브리타임' clawling을 진행하여 수집한 데이터를 가지고 각종 시각화를 진행했었다. 통계데이터를 가지고 ggplot2로 다양한 그래프를 만들었고, clawling한 데이터를 가지고선 워드클라우드와 감성분석을 진행했다. clawling 파일을 실행하면 결과물은 csv로 생성되는데, 이를 txt 파일로 저장하여 워드클라우드 및 감성분석을 진행하는데 사용하였다. 워드클라우드는 최빈단어와 전처리가 원활히 되지 않은 단어들을 제거하여 진행하였다. 감성분석에 사용된 감성사전은 군산대에서 2018년에 제작된 것이다. 

이번 프로젝트는 물론 단순한 시각화 작업에 머물고 있다는 큰 한계점을 가지고 있다. 그러나 비록 더 깊은 차원에서 분석이나 새로운 모델링은 없다하더라도, 시각화된 데이터를 통해서 얻는 인사이트가 존재한다. 프로젝트를 진행하면서 인상깊었던 것 중 하나는 인구가 감소만큼이나 점점 노년인구의 비중이 커지고 있다는 것 또한 눈에 띄는 변화라는 것이다. 대한민국과 각 개인은 이에 대응할 준비가 필요할 것이다. 이런 인구구조의 변화는 경제활동, 여가 등의 생산적인 일에 적극적인 노년층을 의미하는 '액티브 시니어 (active senior)'라는 트렌드와 함께 '시니어 비즈니스' 시장을 키우는 주요한 요인이 될 것이다. 미국이나 일본같은 선진국은 이런 인구구조의 변화, 트렌드에 맞추어 다양한 시니어 비즈니스 모델을 개발하고 있고, 시니어들의 재취업이나 창업을 지원하는데 많은 노력을 가하고 있다. 물론 대한민국에서도 이런 트렌드에 맞춰 새로운 비즈니스 모델과 일자리 등을 만들고 있으나, 정부 주도형이 대부분이고 사회적으로 액티브 시니어의 인식 또한 부족한 편이다. 이런 구조적 변화, 사회적 현상에 대해서 이해하고 빠르게 인식의 변화를 가지는 것은 앞으로의 변화에 큰 메리트가 될 것이다.

또한 이번 프로젝트는 세계최초 1% 이하의 출산율을 기록한 대한민국에 상황에 대해서 객관적으로 고찰할 수 있는 프로젝트였다. 2020년 대한민국 주민등록인구가 통계 작성 이후 처음으로 자연 감소했다. 이러한 상황은 오래전부터 예견되었지만, 문제의 심각성을 직시하지 않고 외면하고 있었기 때문에 나타난 결과이다. 계속해서 감소하는 출산율과 인구수를 확인하며, 정부에겐 현 정책에 대한 고려를, 개인에겐 사회구조적 문제에 대한 관심과 문제해결을 위한 적극적 참여를 요구됨을 확인하였다.



### Detail


#### 대한민국 연도별 출산아수 & 합계출산율 그래프
![image](https://user-images.githubusercontent.com/55008408/114946482-37912f00-9e86-11eb-9fc8-09596182a9ac.png)

#### 지역별 출생수 그래프
![image](https://user-images.githubusercontent.com/55008408/114946553-60b1bf80-9e86-11eb-8bf5-972673858cb8.png)

#### 인구 1000명당 지역별 출생아 그래프
![image](https://user-images.githubusercontent.com/55008408/114946691-a1113d80-9e86-11eb-967f-5cad21b62d8a.png)

#### OECD 10개국 출산율 비교
![image](https://user-images.githubusercontent.com/55008408/114947094-75db1e00-9e87-11eb-863a-0ce5299e3e21.png)

#### OECD 10개국 출산율 비교 (강조)
![image](https://user-images.githubusercontent.com/55008408/114947070-6b208900-9e87-11eb-88e3-8c9b2bd9d8d6.png)

#### OECD 국가 합계 출산율
![image](https://user-images.githubusercontent.com/55008408/114947201-a91dad00-9e87-11eb-83d0-5df4309fc4c1.png)

#### 네이버 '결혼' 키워드 크롤링 데이터 빈도분석
![image](https://user-images.githubusercontent.com/55008408/114953844-47b00b00-9e94-11eb-842a-cb4974f47ec2.png)

#### 네이버 '결혼' 키워드 크롤링 데이터 워드클라우드
![image](https://user-images.githubusercontent.com/55008408/114953885-5dbdcb80-9e94-11eb-8f15-de888e97ed59.png)

#### 네이버 '결혼' 키워드 크롤링 데이터 감성분석
![image](https://user-images.githubusercontent.com/55008408/114953897-657d7000-9e94-11eb-9fde-37c930815be7.png)

#### 네이버 '육아' 키워드 크롤링 데이터 빈도분석
![image](https://user-images.githubusercontent.com/55008408/114953963-847c0200-9e94-11eb-96ec-6af326379c78.png)

#### 네이버 '육아' 키워드 크롤링 데이터 워드클라우드
![image](https://user-images.githubusercontent.com/55008408/114953971-8776f280-9e94-11eb-9687-bee90d4a8c90.png)

#### 네이버 '육아' 키워드 크롤링 데이터 감성분석
![image](https://user-images.githubusercontent.com/55008408/114953976-8a71e300-9e94-11eb-8c2e-7b7d2c5495f0.png)

#### 네이버 '저출산' 키워드 크롤링 데이터 빈도분석
![image](https://user-images.githubusercontent.com/55008408/114953982-8e056a00-9e94-11eb-95c5-e7981b837194.png)

#### 네이버 '저출산' 키워드 크롤링 데이터 워드클라우드
![image](https://user-images.githubusercontent.com/55008408/114953991-9362b480-9e94-11eb-84ff-d11c0629f5de.png)

#### 네이버 '저출산' 키워드 크롤링 데이터 감성분석
![image](https://user-images.githubusercontent.com/55008408/114953997-978ed200-9e94-11eb-8ece-d938d9e5dec4.png)

#### 한동대 에브리타임 '결혼' 키워드 크롤링 데이터 빈도분석
![image](https://user-images.githubusercontent.com/55008408/114954071-b42b0a00-9e94-11eb-96d3-222ea350fc87.png)

#### 한동대 에브리타임 '결혼' 키워드 크롤링 데이터 워드클라우드
![image](https://user-images.githubusercontent.com/55008408/114954076-b68d6400-9e94-11eb-844d-ad779cedac5a.png)

#### 한동대 에브리타임 '결혼' 키워드 크롤링 데이터 감성분석
![image](https://user-images.githubusercontent.com/55008408/114954081-b8efbe00-9e94-11eb-95a2-fb617b5ea612.png)

#### 대한민국 총인구변화
![한국총인구변화](https://user-images.githubusercontent.com/55008408/114954834-539ccc80-9e96-11eb-97ce-8201a13d5fa1.gif)

#### 1970년 대한민국 인구구성비
![image](https://user-images.githubusercontent.com/55008408/114954901-79c26c80-9e96-11eb-8f1e-cbc3f98cc5fb.png)

#### 2000년 대한민국 인구구성비
![image](https://user-images.githubusercontent.com/55008408/114954983-9f4f7600-9e96-11eb-96d9-c4a017da749c.png)

#### 2020년 대한민국 인구구성비
![image](https://user-images.githubusercontent.com/55008408/114954986-a1193980-9e96-11eb-9510-db4b5a5be9a4.png)

#### 2050년 대한민국 인구구성비
![image](https://user-images.githubusercontent.com/55008408/114954994-a2e2fd00-9e96-11eb-8aa0-d90ca77a692a.png)

<hr>

### Reference


##### 합계출산율(OECD) ,<KOSIS 국가통계포털>
https://kosis.kr/statHtml/statHtml.do?orgId=101&tblId=DT_2KAA207_OECD

##### 출생아수(시도/시/군/구), <KOSIS 국가통계포털>
https://kosis.kr/statHtml/statHtml.do?orgId=101&tblId=INH_1B81A01&conn_path=I3

##### 주요 인구지표(성비,인구성장률,인구구조,부양비 등) / 전국, <KOSIS 국가통계포털>
https://kosis.kr/statHtml/statHtml.do?orgId=101&tblId=DT_1BPA002

##### 출생아수와 합계출산율, <KOSIS 국가통계포털>
https://kosis.kr/statHtml/statHtml.do?mode=tab&orgId=101&tblId=DT_POPULATION_06

##### R-graph-gallery
https://www.r-graph-gallery.com/index.html

##### 감성분석
https://rpubs.com/Evan_Jung/sentiment_analysisR

##### 군산대 감성사전
https://github.com/park1200656/KnuSentiLex

##### 네이버 기사 크롤링 
https://book.coalastudy.com/data_crawling/



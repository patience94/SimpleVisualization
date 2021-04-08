# WordCloud Mode top 20
install.packages('KoNLP')
install.packages('hash')
install.packages('stringr')
install.packages('tau')
install.packages('Sejong')
install.packages('RSQLite')
install.packages('wordCloud2')
install.packages('tm')
install.packages('Snowballc')
install.packages('glue')

library(KoNLP)
library(tidyverse)
library(hash)
library(stringr)
library(tau)
library(Sejong)
library(RSQLite)
library(wordcloud2)
library(tm)
library(SnowballC)
library(glue)

useNIADic()

# 함수만들기
makeWordFreq <- function(filename){
  doc <- glue("./Crawling_data/", filename, ".txt", sep="")
  txt <- readLines(doc)
  txt <- extractNoun(txt)
  txt<- Corpus(VectorSource(txt))
  txt <- txt %>%  tm_map(stripWhitespace) %>% 
    tm_map(removePunctuation) %>% 
    tm_map(removeNumbers)
  txt_table <- TermDocumentMatrix(txt)
  txt_table <- as.matrix(txt_table)
  txt_v <- sort(rowSums(txt_table), decreasing = T)
  txt_df <- data.frame(word=names(txt_v), freq = txt_v)
  txt_df <- txt_df %>% filter(str_length(word)>=2)
  return(txt_df)
}

makeTop20 <- function(txt_df, rm_list=c()) {
  ggplot(txt_df %>% filter(!(word %in% rm_list)) %>% head(20),
         aes(reorder(word, freq), freq)) + 
    geom_bar(stat="identity", width = 0.5, fill="tomato2") + 
    geom_text(aes(label = freq), hjust = -0.1) +
    xlab("") + ylab("") +
    ggtitle("빈도수 top 20") +
    coord_flip() + 
    theme(axis.title.y = element_text(size=16, face=2),
          axis.text.x = element_text(size=10, face=2, angle=30),
          axis.text.y = element_text(size=10, face=2))
}

makeWordCloud <- function(txt_df, rm_list=c()) {
  txt_df <- txt_df %>% filter(!(word %in% rm_list))
  wordcloud2(txt_df)
}

# 네이버 "저출산" 크롤링 데이터
lowbirth <- makeWordFreq('low_birth_naver')
makeTop20(lowbirth, c("c저출산","하기"))
makeWordCloud(lowbirth, c("c저출산","하기","저출산"))

# 네이버 "결혼" 크롤링 데이터
wed_n <- makeWordFreq('wedding_naver')
makeTop20(wed_n, c("c결혼"))
makeWordCloud(wed_n,  c('육아','결혼','c결혼','하게','날','chika','치어','비연','c결혼식','이병헌과','조민아가',
                        '한민재가','들이','번째','때문','조민아는','엄용수가','c배우','c개그맨','주년','인스타그램에',
                        '인스타그램을','한민재는','한민재가','c그룹','가운데','개월','결혼식','하자','누구','와이',
                        'ckia','m당','kia','clh','would','c이','c조민아','c가수','c이민','만큼','서지','년차','c순풍',
                        '박하','미만','구라','지숙과','c이날','c대구','이하','박성','c강소','강소','c엄용수','당초',
                        'c단독','시분','c그','c사유','이번','월일'))

# 네이버 "육아" 크롤링 데이터
parenting <- makeWordFreq('parenting_naver')
makeTop20(parenting, c('c육아', 'c육아휴직'))
makeWordCloud(parenting, c('육아','결혼','개월','때문','들이','c육아','이날','c육아휴직','하게','이번','개소',
                           '하기','이태','c슈돌','c포스코','c동상이몽','c신박','가운데','c남성','인스타그램에',
                           '이하','호점','장신영♥강경준','c배우','c대우건설','c신한금융희망재단','c남양유업',
                           '호점을','털어놨다','c울산시','c아내','c아빠'))

# 에브리타임 "결혼" 크롤링 데이터
wed_eta <- makeWordFreq('wedding_eta')
makeTop20(wed_eta,  c("하게","해서","들이","때문", "ㅋㅋㅋㅋㅋ","c나","c저"))
makeWordCloud(wed_eta, c('육아','결혼','ㅋㅋㅋㅋㅋ','c나','하게','하기','c서','때문','진짜','누구',
                         'cㅋㅋㅋㅋㅋ','c삭제','c저','해서','하시','들이','c결혼','댓글입니다','글쓴이',
                         '여러분','저희','경우','ㅋㅋㅋㅋ','c사랑','c이','여기','하나님께','class',
                         '누군가','근데','이것','하나님을','c진짜','그것','하나','하나님이','large','생각',
                         '사람','character','c글','c한','ㅠㅠㅠㅠㅠ','ㅠㅠㅠ','the','ㅎㅎ','c너','ㅠㅠ','안하','
                           c뭐','c남자','어디','ㅋㅋㅋ','해도','그걸','나중','거기','가지','c말','c음','이번',
                         '그때','그거','애초','c형','c사람'))
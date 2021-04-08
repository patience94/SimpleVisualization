# Sentiment Analysis
install.packages("tidyverse")
install.packages("KoNLP")
install.packages("glue")
install.packages("SentimentAnalysis")
install.packages("tm")
install.packages("reshape2")

library(KoNLP)
library(tidyverse)
library(glue)
library(SentimentAnalysis)
library(tm)
library(reshape2)

useNIADic()

# 함수만들기
# Courpus 변환
makeCorpus <- function(filename) {
  doc <- glue("./Crawling_data/", filename, ".txt", sep="")
  txt <- readLines(doc)
  corp <- Corpus(VectorSource(txt))
  corp <- corp %>%  tm_map(stripWhitespace) %>% 
    tm_map(removePunctuation) %>% 
    tm_map(removeNumbers)
  return(corp)
}

# Dataframe 생성
makeDataFrame <- function(filename){
  doc <- glue("./Crawling_data/", filename, ".txt", sep="")
  doc <- readLines(doc)
  docs <- str_replace_all(doc, "[^0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣[:space:]]", " ")
  docs <- str_replace_all(docs, "[\n\t]", " ")
  docs <- str_trim(docs)
  docs <- str_replace_all(docs, "\\s+", " ")
  df <- as.data.frame(docs)
  return(df)
}

doAnalysis <- function(corp, df){
  res_sentiment <- analyzeSentiment(corp,
                                    language="korean",
                                    rules=list("KoreanSentiment"=list(ruleSentiment, senti_dic_kr)),
                                    removeStopwords = F, stemming = F)
  df2 <- data.frame(round(res_sentiment, 3), df)
  df2 <- df2 %>% 
    mutate(pos_neg = if_else(KoreanSentiment > 0, "Positive", 
                             ifelse(KoreanSentiment == 0,"neutral","Negative"))) %>%
    select(pos_neg, everything())
  ggplot(df2, aes(x = factor(pos_neg), fill = factor(pos_neg))) +
    geom_bar(stat = "count", width = 0.7) + 
    xlab("") + 
    theme_minimal() +
    theme(legend.position ='none',
          axis.title.y = element_text(size=16, face=2),
          axis.title.x = element_text(size=16, face=2),
          axis.text.x = element_text(size=10, face=2),
          axis.text.y = element_text(size=10, face=2))
}

# df, corp, 준비
lowbirth_df <- makeDataFrame('low_birth_naver')
lowbirth_corp <- makeCorpus('low_birth_naver')
wedn_df <- makeDataFrame('wedding_naver')
wedn_corp <- makeCorpus('wedding_naver')
parenting_df <- makeDataFrame('parenting_naver')
parenting_corp <- makeCorpus('parenting_naver')
wedeta_df <- makeDataFrame('wedding_eta')
wedeta_corp <- makeCorpus('wedding_eta')

# 감성사전준비
senti_words_kr <- readr::read_delim("SentiWord_Dict.txt", delim='\t', col_names=c("term", "score"))
x <- duplicated(senti_words_kr$term)
senti_words_kr2 <- senti_words_kr[!x, ]
senti_dic_kr <- SentimentDictionaryWeighted(words = senti_words_kr2$term, 
                                            scores = senti_words_kr2$score)
senti_dic_kr <- SentimentDictionary(senti_words_kr2$term[senti_words_kr2$score > 0], 
                                    senti_words_kr2$term[senti_words_kr2$score < 0])


# 감성분석 그래프 만들기
doAnalysis(lowbirth_corp, lowbirth_df)
doAnalysis(wedn_corp, wedn_df)
doAnalysis(parenting_corp, parenting_df)
doAnalysis(wedeta_corp, wedeta_df)
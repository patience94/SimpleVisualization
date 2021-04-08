# making graph
install.packages("tidyverse")
install.packages('hrbrthemes')
install.packages('ggiraphExtra')
install.packages('maps')
install.packages('mapproj')
devtools::install_github("cardiomoon/kormaps2014")
install.packages('gganimate')

library(tidyverse)
library(hrbrthemes)
library(ggiraphExtra)
library(maps)
library(mapproj)
library(kormaps2014)
library(gganimate)

pop <- read.csv("./csv/population.csv")
popcity <- read.csv("./csv/popcity.csv")
stat <- read.csv("./csv/statistic.csv")
birth_late <- read.csv("./csv/birth_late.csv")
city <- read.csv("./csv/city.csv")
OECD <- read.csv("./csv/OECD.csv")

# 출산율 그래프
ggplot(stat, aes(x=년도)) +
  geom_col(aes(y = 출생아수), fill = "bisque2", size = 1) + 
  geom_line(aes(y=합계출산율*200), color = "blue", size = 2) +
  scale_y_continuous(name = "출생아수", 
                     sec.axis = sec_axis(~./200, name="합계출산율")) +
  theme_bw()+
  geom_label(x= 1981, y=4.540*200, 
             label="최고(1971년:4.540%)", size = 5) +
  annotate(geom="point", x= 1971, y=4.540*200, size=5, shape=21, fill="transparent")+
  geom_label(x= 2010, y=0.918*180, 
             label="최저(2019년:0.918%)", size = 5) +
  annotate(geom="point", x= 2019, y=0.918*200, size=5, shape=21, fill="transparent")+
  geom_label(x= 1990, y = 2.06*200, size = 5, label = "2%이하(1983년, 2.06%)")+
  annotate(geom="point", x = 1983, y = 2.06*200, size = 5, shape = 21, fill = "transparent")+
  geom_hline(yintercept=1*200, color="red", size=1) +
  ggtitle("출생아수와 합계출산율")+
  theme_ipsum()

# 지도그래프
city$code <- as.character(city$code)
city$area <- as.factor(city$area)
city <- rename(city, "출생아수" = pop)
ggChoropleth(city, 
             aes(fill = 출생아수, map_id = code, tooltip = area), 
             map = kormap1, 
             palette = "Blues",
             interactive = T)
propCity <- city %>% select(area, code, 출생아수, total) %>%
  mutate(per_1000 = 1000*출생아수/total)
ggChoropleth(propCity, 
             aes(fill = per_1000, map_id = code, tooltip = area),
             palette = "Blues",
             map = kormap1, 
             interactive = T)

# OECD 비교1
birth_late2 <- birth_late %>%
  select(연도, 한국, 미국, 영국, 프랑스, 독일, 일본, 
           이탈리아, 캐나다,  이스라엘, 스위스, 터키)
birth_late2 %>% gather(key='지역', value='출생률', -연도) -> birth_late2
birth_late2 %>%
  ggplot(aes(연도, 출생률, col=지역)) +
  geom_line(size= 1) +
  theme_ipsum() +
  ggtitle("OECD 국가와 한국 비교") +
  theme(axis.title.y = element_text(size=16),
        axis.title.x = element_text(size=16),
        axis.text = element_text(size=13, face=2),
        legend.position = c(.95, .95),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(6, 6, 6, 6))

# OECD 비교 2
birth_late2 %>%
  mutate(highlight=ifelse(지역=='한국', '한국',
                            ifelse(지역=='일본'|
                                       지역=='이스라엘'|
                                       지역=='미국'|
                                       지역=='포르투갈','comp','other'))) %>% 
  ggplot(aes(x=연도, y=출생률, group=지역, color=highlight, size=highlight)) +
  geom_line() +
  scale_color_manual(values = c("Sea green", "lightgrey", "Red")) +
  scale_size_manual(values=c(1,0.2,1.5)) +
  ggtitle("OECD 10개국과 한국 비교") +
  annotate(geom="label", x= 1980, y=3.8, size=5, label='이스라엘', color="Sea green") +
  annotate(geom="label", x= 1995, y=2.3, size=5, label='미국', color="Sea green") +
  annotate(geom="label", x= 1980, y=1.4, size=5, label='일본', color="Sea green") +
  geom_label(x=2010, y=1.6, size=5, color="Red",
             label="OECD 국가 중 출생률 최하위: 한국 (0.98%)") +
  theme_ipsum() +
  theme(legend.position="none",
        axis.title.y = element_text(size=16),
        axis.title.x = element_text(size=16),
        axis.text = element_text(size=13, face=2))

# OECD 비교 3
OECD %>% 
  ggplot(aes(x=reorder(국가별, -X2020))) +
  geom_col(aes(y=X2020), fill = "bisque2", size = 1) + 
  geom_point(aes(y=X2010), color = "blue", size = 2) +
  geom_hline(yintercept=1.63, color="red", size=1) +
  xlab("") + 
  scale_y_continuous(name = "가임 여성 만명당", 
                     breaks = seq(0.5,4,0.5),
                     limits = c(0,3.5)) +
  ggtitle("OECD 합계출산율")+
  theme_ipsum() +
  theme(axis.title.y = element_text(size=16, face=2),
        axis.text.x = element_text(size=10, face=2, angle=30),
        axis.text.y = element_text(size=10, face=2)) -> p
p + geom_bar(data=OECD[OECD$국가별=='한국',],
             aes(x=국가별, y=X2020), fill='#5CBED2', stat='identity')+
  annotate(geom="point", x= 22, y=3, size=4, shape=21, fill="blue")+
  annotate(geom="text", x= 23, y=3, size = 4,
           label = "2010")+
  annotate(geom="point", x= 18, y=3, size=4, shape=22, fill="bisque2")+
  annotate(geom="text", x= 19, y=3, size = 4,
           label = "2020") +
  annotate(geom="text", x="이스라엘", y=3.1, size = 4,
           label = "3.09")+
  annotate(geom="text", x="미국", y=1.85, size = 4,
           label = "1.73")+
  annotate(geom="text", x="일본", y=1.53, size = 4,
           label = "1.42")+
  annotate(geom="text", x="포르투갈", y=1.53, size = 4,
           label = "1.29")+
  annotate(geom="text", x="한국", y=1.1, size = 4,
           label = "0.98")+
  annotate(geom="text", x= "스페인", y=1.8, size = 5,
           label = "OECD 평균 1.63명")

# 한국 총인구 변화 그래프
options(scipen=999)
ggplot(pop, aes(x=연도, y = 총인구/10000)) +
  geom_line(size=1.5, color="#69b3a2") +
  ggtitle("1970~2067년 대한민국 인구변화") +
  theme_ipsum() +
  scale_y_continuous(name = "총인구 (단위: 만명)", 
                     breaks = seq(2000,5000,500)) +
  scale_x_continuous(name = "연도", 
                     breaks = seq(1970,2070,20)) +
  theme(axis.text = element_text(size=13, face=2),
        axis.title.y = element_text(size=16),
        axis.title.x = element_text(size=16)) +
  geom_label(x=2025, y=4000, size=8, color="Red",
             label="2030년 정점 이후로 인구수 감소\n2067년에 이르러 4000만 이하 ")

# 한국 총인구 변화 그래프 애니메이트 
options(scipen=999)
ggplot(pop, aes(x=연도, y = 총인구/10000)) +
  geom_line(size=1.5, color="#69b3a2") +
  geom_point(shape=21, color="black", fill="#69b3a2", size=3) +
  ggtitle("1970~2067년 대한민국 인구변화") +
  theme_ipsum() +
  scale_y_continuous(name = "총인구 (단위: 만명)", 
                     breaks = seq(2000,5000,500)) +
  scale_x_continuous(name = "연도", 
                     breaks = seq(1970,2070,20)) +
  theme(axis.text = element_text(size=13, face=2),
        axis.title.y = element_text(size=16),
        axis.title.x = element_text(size=16)) +
  transition_reveal(연도) 
anim_save("한국총인구변화.gif") #저장

# 연도별 인구구성비
# 1970
pie1 <- data.frame(인구구성비 = c("14세이하\n(42.5%)", "64세이하\n(54.4%)", "65세이상\n(3.1%)"),
                        prop = c(42.5, 54.4, 3.1))
pie1 <- pie1 %>% arrange(desc(인구구성비)) %>%  mutate(ypos = cumsum(prop)- 0.5*prop )
ggplot(pie1, aes(x = "", y = prop, fill = 인구구성비))+
  geom_bar(stat = "identity", width = 1, color = "white")+
  coord_polar("y", start = 0)+
  theme_void()+
  theme(legend.position="right") +
  geom_text(aes(y = ypos, label = 인구구성비), color = "white", size=5) +
  scale_fill_brewer(palette="Set1")+
  ggtitle("1970년도 인구구성비")

# 2020
pie2 <- data.frame(인구구성비 = c("14세이하\n(12.2%)", "64세이하\n(72.1%)", "65세이상\n(15.7%)"),
                        prop = c(12.2, 72.1,15.7))
pie2 <- pie2 %>% arrange(desc(인구구성비)) %>%  mutate(ypos = cumsum(prop)- 0.5*prop)
ggplot(pie2, aes(x = "", y = prop, fill = 인구구성비))+
  geom_bar(stat = "identity", width = 1, color = "white")+
  coord_polar("y", start = 0)+
  theme_void()+
  theme(legend.position="right") +
  geom_text(aes(y = ypos, label = 인구구성비), color = "white", size=5) +
  scale_fill_brewer(palette="Set1")+
  ggtitle("2020년도 인구구성비")

# 2000
pie3 <- data.frame(인구구성비 = c("14세이하\n(21.1%)", "64세이하\n(71.7%)", "65세이상\n(7.2%)"),
                        prop = c(21.1, 71.7,7.2))
pie3 <- pie3 %>% arrange(desc(인구구성비)) %>%  mutate(ypos = cumsum(prop)- 0.5*prop)
ggplot(pie3, aes(x = "", y = prop, fill = 인구구성비))+
  geom_bar(stat = "identity", width = 1, color = "white")+
  coord_polar("y", start = 0)+
  theme_void()+
  theme(legend.position="right") +
  geom_text(aes(y = ypos, label = 인구구성비), color = "white", size=5) +
  scale_fill_brewer(palette="Set1")+
  ggtitle("2000년도 인구구성비")

# 2050
pie4 <- data.frame(인구구성비 = c("14세이하\n(8.9%)", "64세이하\n(51.3%)", "65세이상\n(39.8%)"),
                        prop = c(8.9, 51.3,39.8))
pie4 <- pie4 %>% arrange(desc(인구구성비)) %>%  mutate(ypos = cumsum(prop)- 0.5*prop)
ggplot(pie4, aes(x = "", y = prop, fill = 인구구성비))+
  geom_bar(stat = "identity", width = 1, color = "white")+
  coord_polar("y", start = 0)+
  theme_void()+
  theme(legend.position="right") +
  geom_text(aes(y = ypos, label = 인구구성비), color = "white", size=5) +
  scale_fill_brewer(palette="Set1")+
  ggtitle("2050년도 인구구성비")

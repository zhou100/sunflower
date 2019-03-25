rm(list=ls())
library(haven)
require(tidyverse)
library(readr)


#(1) Include data from years 2009-14 (We only have observations 2011-2015)
bee1115 <- read_csv("Data/clean/bee1015_new.csv")

nrow(bee1115)

bee1115 = bee1115 %>% mutate(sun.dum = sunflower>900)
bee1115 = bee1115 %>% mutate(sun.dum2 = sun_acres>1)


bee1115 = bee1115 %>% mutate(bloom_dummy = ifelse(month==8|month==9,1,0))
bee1115 = bee1115 %>% mutate(month1 = ifelse(month==1,1,0))
bee1115 = bee1115 %>% mutate(month2 = ifelse(month==2,1,0))
bee1115 = bee1115 %>% mutate(month3 = ifelse(month==3,1,0))
bee1115 = bee1115 %>% mutate(month4 = ifelse(month==4,1,0))
bee1115 = bee1115 %>% mutate(month5 = ifelse(month==5,1,0))
bee1115 = bee1115 %>% mutate(month6 = ifelse(month==6,1,0))
bee1115 = bee1115 %>% mutate(month7 = ifelse(month==7,1,0))
bee1115 = bee1115 %>% mutate(month8 = ifelse(month==8,1,0))
bee1115 = bee1115 %>% mutate(month9 = ifelse(month==9,1,0))
bee1115 = bee1115 %>% mutate(month10 = ifelse(month==10,1,0))
bee1115 = bee1115 %>% mutate(month11 = ifelse(month==11,1,0))
bee1115 = bee1115 %>% mutate(month12 = ifelse(month==12,1,0))

# (2) Account for bloom period, when we expect effects of sunflower pollen to occur, in two ways:
   
#   (a) restrict analysis to data from August & September only, 
# when sunflower is in bloom 
# comparing same location with blooming vs no blooming


bee.bloom.month = bee1115 %>% filter(month==8|month==9)


linearMod_mites1 <- lm(mites ~ log(sunflower+1)   + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
linearMod_mites2 <- lm(mites ~ sun.dum  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
linearMod_mites3 <- lm(mites ~ sun.dum2  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
stargazer::stargazer(linearMod_mites1,linearMod_mites2,linearMod_mites3,type="text")



linearMod_nosema1 <- lm(nosema ~ log(sunflower+1)  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
linearMod_nosema2 <- lm(nosema ~ sun.dum  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
linearMod_nosema3 <- lm(nosema ~ sun.dum2  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
stargazer::stargazer(linearMod_nosema1,linearMod_nosema2,linearMod_nosema3,type="text")



# (b) include all months and an interaction term between acres of sunflower and month, to account for effects of location. 
allmonth_mites1 <- lm(mites ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 , data=bee1115)
allmonth_mites2 <- lm(mites ~ sun.dum*bloom_dummy  + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 , data=bee1115)
allmonth_mites3 <- lm(mites ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 , data=bee1115)
stargazer::stargazer(allmonth_mites1,allmonth_mites2,allmonth_mites3,type="text")


allmonth_nosema1 <- lm(nosema ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip , data=bee1115)
allmonth_nosema2 <- lm(nosema ~ sun.dum*bloom_dummy  + average_mintemp + average_precip , data=bee1115)
allmonth_nosema3 <- lm(nosema ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip , data=bee1115)
stargazer::stargazer(allmonth_nosema1,allmonth_nosema2,allmonth_nosema3,type="text")



bee.1415 <- read_dta("Data/bee data new 14-15 v.5.25.dta")

bee.1415.df = as.data.frame(bee.1415) %>% 
  filter(!is.na(sunflower) & !is.na(nosemaloadperbeeinmillions) & !is.na(mitesfound))   


bee.1415.df = bee.1415.df %>% 
  mutate(month8=if_else( month==8,1,0)) %>%
  mutate(month9=if_else( month==9,1,0)) 


bee.1415.join = bee.1415.df %>% 
  mutate(nosema = nosemaloadperbeeinmillions) %>%
  mutate(mites=mitesfound) %>%
  mutate( colonysize=as.numeric(coloniesinapiary)) %>%
  dplyr::select(sunflower,month,colonysize,month8,month9,year,nosema,mites,state,totalarea,average_mintemp,average_precip) %>% 
  arrange(year) 


bee1415.new = bee.1415.join %>% filter (!is.na(colonysize))
bee1415.new = bee1415.new %>% mutate(sun.dum = sunflower>900)
bee1415.new = bee1415.new %>% mutate(sun.dum2 = sunflower>4046.86)


bee1415.new = bee1415.new %>% mutate(bloom_dummy = ifelse(month==8|month==9,1,0))
bee1415.new = bee1415.new %>% mutate(month1 = ifelse(month==1,1,0))
bee1415.new = bee1415.new %>% mutate(month2 = ifelse(month==2,1,0))
bee1415.new = bee1415.new %>% mutate(month3 = ifelse(month==3,1,0))
bee1415.new = bee1415.new %>% mutate(month4 = ifelse(month==4,1,0))
bee1415.new = bee1415.new %>% mutate(month5 = ifelse(month==5,1,0))
bee1415.new = bee1415.new %>% mutate(month6 = ifelse(month==6,1,0))
bee1415.new = bee1415.new %>% mutate(month7 = ifelse(month==7,1,0))
bee1415.new = bee1415.new %>% mutate(month8 = ifelse(month==8,1,0))
bee1415.new = bee1415.new %>% mutate(month9 = ifelse(month==9,1,0))
bee1415.new = bee1415.new %>% mutate(month10 = ifelse(month==10,1,0))
bee1415.new = bee1415.new %>% mutate(month11 = ifelse(month==11,1,0))
bee1415.new = bee1415.new %>% mutate(month12 = ifelse(month==12,1,0))


bee.bloom.month1415 = bee1415.new %>% filter(month==8|month==9)

linearMod_mites1 <- lm(mites ~ log(sunflower+1)   + average_mintemp + average_precip+colonysize, data=bee.bloom.month1415)
linearMod_mites2 <- lm(mites ~ sun.dum  + average_mintemp + average_precip +colonysize, data=bee.bloom.month1415)
linearMod_mites3 <- lm(mites ~ sun.dum2  + average_mintemp + average_precip+colonysize, data=bee.bloom.month1415)
stargazer::stargazer(linearMod_mites1,linearMod_mites2,linearMod_mites3,type="text")



linearMod_nosema1 <- lm(nosema ~ log(sunflower+1)  + average_mintemp + average_precip + as.factor(month)+colonysize, data=bee.bloom.month1415)
linearMod_nosema2 <- lm(nosema ~ sun.dum  + average_mintemp + average_precip + as.factor(month)+colonysize, data=bee.bloom.month1415)
linearMod_nosema3 <- lm(nosema ~ sun.dum2  + average_mintemp + average_precip + as.factor(month)+colonysize, data=bee.bloom.month1415)
stargazer::stargazer(linearMod_nosema1,linearMod_nosema2,linearMod_nosema3,type="text")



# (b) include all months and an interaction term between acres of sunflower and month, to account for effects of location. 
allmonth_mites1 <- lm(mites ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip+colonysize , data=bee1415.new)
allmonth_mites2 <- lm(mites ~ sun.dum*bloom_dummy  + average_mintemp + average_precip +colonysize, data=bee1415.new)
allmonth_mites3 <- lm(mites ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip+colonysize , data=bee1415.new)
stargazer::stargazer(allmonth_mites1,allmonth_mites2,allmonth_mites3,type="text")


allmonth_nosema1 <- lm(nosema ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip+colonysize , data=bee1415.new)
allmonth_nosema2 <- lm(nosema ~ sun.dum*bloom_dummy  + average_mintemp + average_precip+colonysize , data=bee1415.new)
allmonth_nosema3 <- lm(nosema ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip +colonysize, data=bee1415.new)
stargazer::stargazer(allmonth_nosema1,allmonth_nosema2,allmonth_nosema3,type="text")















bee.bloom.month.subset = bee.bloom.month %>% filter(sunflower>0)
bee1115.subset = bee1115 %>% filter(sunflower>0)

linearMod_mites1 <- lm(mitesfound ~ sun.dum*month8 + as.numeric(coloniesinapiary) + average_mintemp + average_precip + as.factor(month), data=bee.1415.df)
summary(linearMod_mites1)
linearMod_mites2 <- lm(mitesfound ~ log(sunflower+1)*month8  + as.numeric(coloniesinapiary) + average_mintemp + average_precip + as.factor(month), data=bee.1415.df)
summary(linearMod_mites2)
linearMod_mites3<- lm(mitesfound ~ sun.dum2 + as.numeric(coloniesinapiary) + average_mintemp + average_precip + as.factor(month), data=bee.1415.df)
summary(linearMod_mites3)
 


linearMod_mites3 <- lm(mites ~   + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month.subset)
summary(linearMod_mites3)


linearMod_mites1 <- lm(mites ~ sun.dum*month8   + average_mintemp + average_precip + as.factor(month), data=bee1115.subset)
summary(linearMod_mites1)


linearMod_mites2 <- lm(mites ~ log(sunflower+1)*month9   + average_mintemp + average_precip + as.factor(month), data=bee1115.subset)
summary(linearMod_mites2)


linearMod_mites3 <- lm(mites ~ sun.dum2  + average_mintemp + average_precip + as.factor(month), data=bee1115.subset)
summary(linearMod_mites3)
 
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


# (2) Account for bloom period, when we expect effects of sunflower pollen to occur, in two ways:
   
#   (a) restrict analysis to data from August & September only, 
# when sunflower is in bloom 
# comparing same location with blooming vs no blooming


bee.bloom.month = bee1115 %>% filter(month==8|month==9)



linearMod_mites1 <- lm(mites ~ sun.dum  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
summary(linearMod_mites1)


linearMod_mites2 <- lm(mites ~ log(sunflower+1)   + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
summary(linearMod_mites2)


linearMod_mites3 <- lm(mites ~ sun.dum2  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
summary(linearMod_mites3)


linearMod_nosema <- lm(nosema ~ sun.dum  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
summary(linearMod_nosema)

linearMod_nosema2 <- lm(nosema ~ log(sunflower+1)  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
summary(linearMod_nosema2)

linearMod_nosema3 <- lm(nosema ~ sun.dum2  + average_mintemp + average_precip + as.factor(month), data=bee.bloom.month)
summary(linearMod_nosema3)

 
# (b) include all months and an interaction term between acres of sunflower and month, to account for effects of location. 
allmonth_mites1 <- lm(mites ~ sun.dum*bloom_dummy  + average_mintemp + average_precip + as.factor(month), data=bee1115)
summary(allmonth_mites1)


allmonth_mites2 <- lm(mites ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip + as.factor(month), data=bee1115)
summary(allmonth_mites2)


allmonth_mites3 <- lm(mites ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip + as.factor(month), data=bee1115)
summary(allmonth_mites3)


allmonth_nosema <- lm(nosema ~ sun.dum*month8  + average_mintemp + average_precip + as.factor(month), data=bee1115)
summary(allmonth_nosema)

allmonth_nosema2 <- lm(nosema ~ log(sunflower+1)*bloom_dummy   + average_mintemp + average_precip + as.factor(month), data=bee1115)
summary(allmonth_nosema2)

allmonth_nosema3 <- lm(nosema ~ sun.dum2*month  + average_mintemp + average_precip + as.factor(month), data=bee1115)
summary(allmonth_nosema3)



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
 
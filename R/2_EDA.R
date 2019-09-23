rm(list=ls())
library(haven)
require(tidyverse)
library(readr)


#(1) Include data from years 2009-14 (We only have observations 2011-2015)
bee1115 <- read_csv("Data/dataset_4miles.csv")


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

############################################################################+
# Mites regressions (bloom months)
############################################################################
require(MASS)
require(pscl)
linearMod_mites_2miles <- lm(log(mites+1) ~ log(sf_4miles_acres+1)   + average_mintemp + average_precip   + as.factor(month) + as.factor(year)+as.factor(state), data=bee.bloom.month)
linearMod_mites_4miles <- lm(log(mites+1) ~ log(sf_2miles_acres+1)   + average_mintemp + average_precip   + as.factor(month) + as.factor(year)+as.factor(state), data=bee.bloom.month)

stargazer::stargazer(linearMod_mites_2miles,linearMod_mites_4miles,type="text")






linearMod_mites2 <- glm(log(mites+1)  ~ log(sf_4miles_acres+1)   + average_mintemp + average_precip  + as.factor(month) + as.factor(year)+as.factor(state), family="poisson",data=bee.bloom.month)
linearMod_mites3 <- glm.nb(log(mites+1)  ~ log(sf_4miles_acres+1)   + average_mintemp + average_precip  + as.factor(month) + as.factor(year)+as.factor(state),data=bee.bloom.month)
 

# save predicted values 
pred.mites.ols = as.data.frame(predict(linearMod_mites1))
pred.mites.poisson = as.data.frame(predict(linearMod_mites2, type="response"))
pred.mites.nb = as.data.frame(predict(linearMod_mites3, type="response"))

# formating 
mites.actual = as.data.frame(log(bee.bloom.month$mites+1)) %>% na.omit()
names(mites.actual) = "mites_actual"
names(pred.mites.ols) = "mites_ols_pred"
names(pred.mites.poisson) = "mites_poisson_pred"
names(pred.mites.nb) = "mites_nb_pred"


# Generate scatter plots 
d<-cbind(mites.actual,pred.mites.ols)
ggplot(d, aes(mites_actual, mites_ols_pred )) +
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  theme_minimal() + geom_abline(intercept = 0, slope = 1)+
  scale_color_brewer(palette="Dark2") 


d<-cbind(mites.actual,pred.mites.nb)
ggplot(d, aes(mites_actual, mites_nb_pred )) +
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  theme_minimal() + geom_abline(intercept = 0, slope = 1)+
  scale_color_brewer(palette="Dark2") 

 
d<-cbind(mites.actual,pred.mites.poisson)
ggplot(d, aes(mites_actual, mites_poisson_pred )) +
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  theme_minimal() + geom_abline(intercept = 0, slope = 1)+
  scale_color_brewer(palette="Dark2") 




############################################################
# add in state fixed effect 
############################################################
linearMod_mites1 <- lm(log(mites+1) ~ log(sunflower+1)   + average_mintemp + average_precip   + as.factor(month) + as.factor(year)+as.factor(state), data=bee.bloom.month)
linearMod_mites2 <- glm(log(mites+1)  ~ log(sunflower+1)   + average_mintemp + average_precip  + as.factor(month) + as.factor(year)+as.factor(state), family="poisson",data=bee.bloom.month)
linearMod_mites3 <- glm.nb(log(mites+1)  ~ log(sunflower+1)   + average_mintemp + average_precip  + as.factor(month) + as.factor(year)+as.factor(state),data=bee.bloom.month)

stargazer::stargazer(linearMod_mites1,linearMod_mites2,linearMod_mites3,type="text")

############################################################################+
# Nosema regressions (bloom months)
############################################################################

linearMod_nosema1 <- lm(log(nosema+1) ~ log(sunflower+1)   + average_mintemp + average_precip   + as.factor(month) + as.factor(year)+as.factor(state), data=bee.bloom.month)
linearMod_nosema2 <- glm(log(nosema+1)  ~ log(sunflower+1)   + average_mintemp + average_precip  + as.factor(month) + as.factor(year)+as.factor(state), family="poisson",data=bee.bloom.month)
linearMod_nosema3 <- glm.nb(log(nosema+1)  ~ log(sunflower+1)   + average_mintemp + average_precip  + as.factor(month) + as.factor(year)+as.factor(state),data=bee.bloom.month)

stargazer::stargazer(linearMod_nosema1,linearMod_nosema2,linearMod_nosema3,type="text")

# save predicted values 

pred.nosema.ols = as.data.frame(predict(linearMod_nosema1))
pred.nosema.poisson = as.data.frame(predict(linearMod_nosema2, type="response"))
pred.nosema.nb = as.data.frame(predict(linearMod_nosema3, type="response"))

# formating 

nosema.actual = as.data.frame(log(bee.bloom.month$nosema+1)) %>% na.omit()
names(nosema.actual) = "nosema_actual"
names(pred.nosema.ols) = "nosema_ols_pred"
names(pred.nosema.poisson) = "nosema_poisson_pred"
names(pred.nosema.nb) = "nosema_nb_pred"

# Generate scatter plots 

d<-cbind(nosema.actual,pred.nosema.ols)
ggplot(d, aes(nosema_actual, nosema_ols_pred )) +
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  theme_minimal() + geom_abline(intercept = 0, slope = 1)+
  scale_color_brewer(palette="Dark2") 


d<-cbind(nosema.actual,pred.nosema.nb)
ggplot(d, aes(nosema_actual, nosema_nb_pred )) +
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  theme_minimal() + geom_abline(intercept = 0, slope = 1)+
  scale_color_brewer(palette="Dark2") 


d<-cbind(nosema.actual,pred.nosema.poisson)
ggplot(d, aes(nosema_actual, nosema_poisson_pred )) +
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  theme_minimal() + geom_abline(intercept = 0, slope = 1)+
  scale_color_brewer(palette="Dark2") 



# (b) include all months and an interaction term between acres of sunflower and month, to account for effects of location. 
############################################################################+
# Mites regressions (all months)
############################################################################

allmonth_mites1 <- lm(mites~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year) +as.factor(state) , data=bee1115)
allmonth_mites2 <- glm(mites  ~ log(sunflower+1) *bloom_dummy  + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year)+as.factor(state) , family="poisson",data=bee1115)
allmonth_mites3 <- glm.nb(mites  ~log(sunflower+1) *bloom_dummy   + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year)+as.factor(state) , data=bee1115)
stargazer::stargazer(allmonth_mites1,allmonth_mites2,allmonth_mites3,type="text")


############################################################################+
# Nosema regressions (all months)
############################################################################

allmonth_nosema1 <- lm(nosema ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year) +as.factor(state) , data=bee1115)
allmonth_nosema2 <- glm(nosema ~log(sunflower+1) *bloom_dummy  + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year) +as.factor(state) ,family="poisson", data=bee1115)
allmonth_nosema3 <- glm.nb(nosema ~ log(sunflower+1) *bloom_dummy     + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year) +as.factor(state) , data=bee1115)
stargazer::stargazer(allmonth_nosema1,allmonth_nosema2,allmonth_nosema3,type="text")




############################################################################+
# Mites regressions (all months, limited to states growing)
############################################################################

state_acres = bee1115 %>% 
  group_by(state) %>%
  summarise(sunflower_acres = sum(sunflower)) %>%
  arrange(desc(sunflower_acres))

 # Limit to states with more sunflower growing
bee.states= state_acres %>%
  filter(sunflower_acres>60000 ) 

bee.states.data=  bee1115 %>% 
  filter(state %in% bee.states$state)
  

# regression results 
allmonth_substates_mites1 <- lm(mites~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year) +as.factor(state), data=bee.states.data)
allmonth_substates_mites2 <- glm(mites  ~ log(sunflower+1) *bloom_dummy  + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year)+as.factor(state) , family="poisson",data=bee.states.data)
allmonth_substates_mites3 <- glm.nb(mites  ~log(sunflower+1) *bloom_dummy   + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year)+as.factor(state) , data=bee.states.data)
stargazer::stargazer(allmonth_substates_mites1,allmonth_substates_mites2,allmonth_substates_mites3,type="text")


allmonth_substates_nosema1 <- lm(nosema~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year) +as.factor(state), data=bee.states.data)
allmonth_substates_nosema2 <- glm(nosema  ~ log(sunflower+1) *bloom_dummy  + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year)+as.factor(state) , family="poisson",data=bee.states.data)
allmonth_substates_nosema3 <- glm.nb(nosema  ~log(sunflower+1) *bloom_dummy   + average_mintemp + average_precip + month1 + month2 + month3 + month4 + month5+ month6 + month7 +month10 + month11 +as.factor(year)+as.factor(state) , data=bee.states.data)
stargazer::stargazer(allmonth_substates_nosema1,allmonth_substates_nosema2,allmonth_substates_nosema3,type="text")




#######################################
# Regressions on only 2014-2015 data
#######################################

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

# generate month dummies 
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


linearMod_nosemas1 <- lm(nosemas ~ log(sunflower+1)   + average_mintemp + average_precip+colonysize, data=bee.bloom.month1415)
linearMod_nosemas2 <- lm(nosemas ~ sun.dum  + average_mintemp + average_precip +colonysize, data=bee.bloom.month1415)
linearMod_nosemas3 <- lm(nosemas ~ sun.dum2  + average_mintemp + average_precip+colonysize, data=bee.bloom.month1415)
stargazer::stargazer(linearMod_nosema1,linearMod_nosema2,linearMod_nosema3,type="text")



# (b) include all months and an interaction term between acres of sunflower and month, to account for effects of location. 
allmonth_mites1 <- lm(mites ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip+colonysize , data=bee1415.new)
allmonth_mites2 <- lm(mites ~ sun.dum*bloom_dummy  + average_mintemp + average_precip +colonysize, data=bee1415.new)
allmonth_mites3 <- lm(mites ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip+colonysize , data=bee1415.new)
stargazer::stargazer(allmonth_mites1,allmonth_mites2,allmonth_mites3,type="text")


allmonth_nosema1 <- lm(log(nosema+1) ~ log(sunflower+1) *bloom_dummy + average_mintemp + average_precip+colonysize , data=bee1415.new)
allmonth_nosema2 <- lm(nosema ~ sun.dum*bloom_dummy  + average_mintemp + average_precip+colonysize , data=bee1415.new)
allmonth_nosema3 <- lm(nosema ~ sun.dum2*bloom_dummy     + average_mintemp + average_precip +colonysize, data=bee1415.new)
stargazer::stargazer(allmonth_nosema1,allmonth_nosema2,allmonth_nosema3,type="text")




 
 


 
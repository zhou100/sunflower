rm(list=ls())

library(haven)
require(tidyverse)
library(readr)

# read 09-14 data
bee.0914 <- read_dta("Data/raw/bee data 09-14 v1.12.dta")

 # 
 bee.0914.sub = bee.0914 %>% 
   filter(!is.na(mites) & !is.na(sunflower)) %>%
   dplyr::select(sampleid,y,x,sunflower,month,year,nosema,mites,state,totalarea,average_mintemp,average_precip) %>% 
   mutate(y = as.numeric(y)) %>%
   arrange(year)
 
 bee.0914.sub = bee.0914.sub %>% 
 mutate(month8=if_else( month==8,1,0)) %>%
   mutate(month9=if_else( month==9,1,0)) 
 
 # read 14-15 data
bee.1415 <- read_dta("Data/raw/bee data new 14-15 v.5.25.dta")

bee.1415.df = as.data.frame(bee.1415) %>% 
  filter(!is.na(sunflower) & !is.na(nosemaloadperbeeinmillions) & !is.na(mitesfound))   

# generate month 8/9 dummies 
bee.1415.df = bee.1415.df %>% 
  mutate(month8=if_else( month==8,1,0)) %>%
  mutate(month9=if_else( month==9,1,0)) 
  
# formatting variables 
bee.1415.join = bee.1415.df %>% 
  mutate(nosema = nosemaloadperbeeinmillions) %>%
  mutate(mites=mitesfound) %>%
  mutate( colonysize=as.numeric(coloniesinapiary)) %>%
  dplyr::select(sampleid,y,x,sunflower,month,colonysize,month8,month9,year,nosema,mites,state,totalarea,average_mintemp,average_precip) %>% 
  mutate( x= as.numeric(x)) %>%
  mutate(y = as.numeric(y)) %>%
  arrange(year)  

# combine two dataset 
bee.df = bind_rows(bee.0914.sub,bee.1415.join)

# check data types 
# sapply(bee.0913.join, class)
# sapply(bee.1415.join, class)

# change area unit into acres 
bee.df = bee.df %>% mutate(sf_2mile_percent = sunflower/totalarea)
bee.df = bee.df %>% mutate(sf_2mile_acres = sunflower/4046.86)

unique(bee.df$year)
unique(bee.df$month)

# remove missing data 
bee.df = bee.df %>% filter(!is.na(year) & !is.na(average_mintemp))

# write the data 
write.csv(bee.df,"Data/clean/bee1015_new.csv",row.names = FALSE )



################################
# Join the 4mile dataset 
################################

sf_2010 <- read_csv("Data/raw/4mile-sunflower/Export_Output_2010.csv")
sf_2011 <- read_csv("Data/raw/4mile-sunflower/Export_Output_2011.csv")
sf_2012 <- read_csv("Data/raw/4mile-sunflower/Export_Output_2012.csv")
sf_2013 <- read_csv("Data/raw/4mile-sunflower/Export_Output_2013.csv")
sf_2014 <- read_csv("Data/raw/4mile-sunflower/Export_Output_2014.csv")
sf_2015 <- read_csv("Data/raw/4mile-sunflower/Export_Output_2015.csv")

head(sf_2010)

# consistent 30 m resolution from 2010 onwards. 
# transform from 900 m2 to 0.222395 acres 

sf_4mile_2010 = sf_2010 %>%
  select(Join_Count,sampleid,x,y,bee_geoc_2,bee_geoc_3) %>%
  group_by(sampleid,x,y,bee_geoc_3,bee_geoc_2) %>%
  summarise( sf_4miles_acres = sum(Join_Count)*0.222395) %>%
  ungroup() %>%
  mutate( year = bee_geoc_3) %>%
  mutate( month = bee_geoc_2) %>%
  select(- bee_geoc_3,-bee_geoc_2)

sf_4mile_2011 = sf_2011 %>%
  select(Join_Count,sampleid,x,y,bee_geoc_2,bee_geoc_3) %>%
  group_by(sampleid,x,y,bee_geoc_3,bee_geoc_2) %>%
  summarise( sf_4miles_acres = sum(Join_Count)*0.222395) %>%
  ungroup() %>%
  mutate( year = bee_geoc_3) %>%
  mutate( month = bee_geoc_2) %>%
  select(- bee_geoc_3,-bee_geoc_2)

sf_4mile_2012 = sf_2012 %>%
  select(Join_Count,sampleid,x,y,bee_geoc_2,bee_geoc_3) %>%
  group_by(sampleid,x,y,bee_geoc_3,bee_geoc_2) %>%
  summarise( sf_4miles_acres = sum(Join_Count)*0.222395) %>%
  ungroup() %>%
  mutate( year = bee_geoc_3) %>%
  mutate( month = bee_geoc_2) %>%
  select(- bee_geoc_3,-bee_geoc_2)

sf_4mile_2013 = sf_2013 %>%
  select(Join_Count,sampleid,x,y,bee_geoc_2,bee_geoc_3) %>%
  group_by(sampleid,x,y,bee_geoc_3,bee_geoc_2) %>%
  summarise( sf_4miles_acres = sum(Join_Count)*0.222395) %>%
  ungroup() %>%
  mutate( year = bee_geoc_3) %>%
  mutate( month = bee_geoc_2) %>%
  select(- bee_geoc_3,-bee_geoc_2)

sf_4mile_2014 = sf_2014 %>%
  select(Join_Count,sampleid,x,y,bee_geoc_2,bee_geoc_3) %>%
  group_by(sampleid,x,y,bee_geoc_3,bee_geoc_2) %>%
  summarise( sf_4miles_acres = sum(Join_Count)*0.222395) %>%
  ungroup() %>%
  mutate( year = bee_geoc_3) %>%
  mutate( month = bee_geoc_2) %>%
  select(- bee_geoc_3,-bee_geoc_2)

sf_4mile_2015 = sf_2015 %>%
  select(Join_Count,sampleid,x,y,month,year) %>%
  group_by(sampleid,x,y,year,month) %>%
  summarise( sf_4miles_acres = sum(Join_Count)*0.222395) %>%
  ungroup() 

dataset_4mile = bind_rows(sf_4mile_2010,sf_4mile_2011)
dataset_4mile = bind_rows(dataset_4mile,sf_4mile_2012)
dataset_4mile = bind_rows(dataset_4mile,sf_4mile_2013)
dataset_4mile = bind_rows(dataset_4mile,sf_4mile_2014)
dataset_4mile = bind_rows(dataset_4mile,sf_4mile_2015)

bee_4mile_dataset = left_join(bee.df,dataset_4mile)


bee_4mile_dataset = bee_4mile_dataset %>% 
  mutate( sf_4miles_acres = if_else( is.na(sf_4miles_acres),0,sf_4miles_acres))  %>%
  mutate( sf_4miles_acres = if_else( sf_4miles_acres<sf_2mile_acres,sf_2mile_acres,sf_4miles_acres) )

bee_4mile_dataset

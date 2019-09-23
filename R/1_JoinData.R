rm(list=ls())

library(haven)
require(tidyverse)
library(readr)

# Create dataset

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
bee.df = bee.df %>% mutate(sunflower_2mile_percent_original = sunflower/totalarea)
bee.df = bee.df %>% mutate(sunflower_2mile_acres_original = sunflower/4046.86)

unique(bee.df$year)
unique(bee.df$month)

# remove missing data 
bee.df = bee.df %>% filter(!is.na(year) & !is.na(average_mintemp))

# write the data 
write.csv(bee.df,"Data/clean/bee1015_new.csv",row.names = FALSE )



####################################################
# Join the 2mile and 4mile sunflower acreage dataset 
####################################################

# rm(list=ls())

library(haven)
require(tidyverse)
library(readr)
sf_4mile_2010 <- read_csv("Data/raw/4mile-sunflower/4mile_2010.csv")
sf_4mile_2011 <- read_csv("Data/raw/4mile-sunflower/4mile_2011.csv")
sf_4mile_2012 <- read_csv("Data/raw/4mile-sunflower/4mile_2012.csv")
sf_4mile_2013 <- read_csv("Data/raw/4mile-sunflower/4mile_2013.csv")
sf_4mile_2014 <- read_csv("Data/raw/4mile-sunflower/4mile_2014.csv")
sf_4mile_2015 <- read_csv("Data/raw/4mile-sunflower/4mile_2015.csv")


sf_2mile_2010 <- read_csv("Data/raw/2mile-sunflower/2mile_2010.csv")
sf_2mile_2011 <- read_csv("Data/raw/2mile-sunflower/2mile_2011.csv")
sf_2mile_2012 <- read_csv("Data/raw/2mile-sunflower/2mile_2012.csv")
sf_2mile_2013 <- read_csv("Data/raw/2mile-sunflower/2mile_2013.csv")
sf_2mile_2014 <- read_csv("Data/raw/2mile-sunflower/2mile_2014.csv")
sf_2mile_2015 <- read_csv("Data/raw/2mile-sunflower/2mile_2015.csv")


head(sf_4mile_2010)

###################################### 
# Transform raw output to be acres
###################################### 

# 4 mile dataset  

sf_4mile_2015 = sf_4mile_2015 %>% mutate(  bee_geoc_3 = year) %>% mutate(  bee_geoc_2 = month)

list_4miles  = list(sf_4mile_2010,sf_4mile_2011,sf_4mile_2012,sf_4mile_2013,sf_4mile_2014,sf_4mile_2015 )

# define a function to process the raw output to be acres
# consistent 30 m resolution from 2010 onwards. 
# transform from one grid of 900 m2 to 0.222395 acres 

df_acres= function(df) {
   df_acres = df %>%
    select(Join_Count,sampleid,x,y,bee_geoc_2,bee_geoc_3) %>%
        mutate( sf_4miles_acres = Join_Count *0.222395) %>%
    mutate( year = bee_geoc_3) %>%
    mutate( month = bee_geoc_2) %>%
    select(- bee_geoc_3,-bee_geoc_2,-Join_Count)  
   return(df_acres)
}

aggregate_4mile_acres = df_acres(sf_4mile_2010)

for (df in list_4miles[2:6]){
  temp_df = df_acres(df)
  aggregate_4mile_acres = bind_rows(aggregate_4mile_acres,temp_df)
}

 
#2mile datasets

list_2miles  = list(sf_2mile_2010,sf_2mile_2011,sf_2mile_2012,sf_2mile_2013,sf_2mile_2014,sf_2mile_2015 )

df_acres_2miles= function(df) {
  df_acres = df %>%
    select(Join_Count,sampleid,x,y,month,year) %>%
    mutate( sf_2miles_acres = Join_Count *0.222395) %>%
    select(-Join_Count)  
  return(df_acres)
}

aggregate_2mile_acres = df_acres_2miles(sf_2mile_2010)

for (df in list_2miles[2:6]){
  temp_df = df_acres_2miles(df)
  aggregate_2mile_acres = bind_rows(aggregate_2mile_acres,temp_df)
}

dataset_4miles = left_join(aggregate_4mile_acres,aggregate_2mile_acres)

dataset.full = left_join(bee.df,dataset_4miles)

# replace na with 0 acres of sunflower in the 

dataset.full= dataset.full %>% 
  mutate( sf_4miles_acres=if_else(is.na(sf_4miles_acres), 0,sf_4miles_acres )) %>% 
  mutate( sf_2miles_acres=if_else(is.na(sf_2miles_acres), 0,sf_2miles_acres ))

summary(dataset.full$sf_2miles_acres)
summary(dataset.full$sunflower_2mile_acres_original)

write.csv(dataset.full,"Data/dataset_4miles.csv",row.names = FALSE)

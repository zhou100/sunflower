rm(list=ls())

library(haven)
require(tidyverse)
library(readr)

# read 09-14 data
 bee.0914 <- read_dta("Data/bee data 09-14 v1.12.dta")

 # 
 bee.0914.sub = bee.0914 %>% 
   filter(!is.na(mites) & !is.na(sunflower)) %>%
   dplyr::select(sunflower,month,year,nosema,mites,state,totalarea,average_mintemp,average_precip) %>% 
   arrange(year)
 
 bee.0914.sub = bee.0914.sub %>% 
 mutate(month8=if_else( month==8,1,0)) %>%
   mutate(month9=if_else( month==9,1,0)) 
 
 # read 14-15 data
bee.1415 <- read_dta("Data/bee data new 14-15 v.5.25.dta")

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
  dplyr::select(sunflower,month,colonysize,month8,month9,year,nosema,mites,state,totalarea,average_mintemp,average_precip) %>% 
  arrange(year)  

# combine two dataset 
bee.df = bind_rows(bee.0914.sub,bee.1415.join)

# check data types 
# sapply(bee.0913.join, class)
# sapply(bee.1415.join, class)

# change area unit into acres 
bee.df = bee.df %>% mutate(sunper = sunflower/totalarea)
bee.df = bee.df %>% mutate(sun_acres = sunflower/4046.86)

unique(bee.df$year)
unique(bee.df$month)

# remove missing data 
bee.df = bee.df %>% filter(!is.na(year) & !is.na(average_mintemp))

# write the data 
write.csv(bee.df,"Data/clean/bee1015_new.csv",row.names = FALSE )










# library(rgdal)  # for vector work; sp package should always load with rgdal. 
# library (raster)   # for metadata/attributes- vectors or rasters
# 
#  
# 
# buffer = readOGR("Output/graph/buffer_clip.shp")
# 
# plot(uass)
# 
# uass <- raster("C:/Users/Administrator/Desktop/2012_30m_cdls/2012_30m_cdls.img")
# unique(uass)
# 
# 
# uass$X2012_30m_cdls@data@attributes[[1]]$ID[uass$X2012_30m_cdls@data@attributes[[1]]$ID==6]
# 
# unique(uass$X2012_30m_cdls)


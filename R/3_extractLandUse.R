
rm(list=ls())

library(haven)
require(tidyverse)
library(readr)

# read 09-14 data
bee.0914 <- read_dta("Data/bee data 09-14 v1.12.dta")

bee.0914.coord = bee.0914 %>% dplyr::select(sampleid,x,y,month,year)
bee.0914.coord = bee.0914.coord %>% mutate( x=as.numeric(x) ) %>%  mutate( y=as.numeric(y) )

# read 1415
bee.1415 <- read_dta("Data/bee data new 14-15 v.5.25.dta")
bee.1415.coord = bee.1415 %>% dplyr::select(sampleid,x,y,month,year)
bee.1415.coord = bee.1415.coord %>% mutate( x=as.numeric(x) ) %>%  mutate( y=as.numeric(y) )


bee.data.coord = bind_rows(bee.0914.coord,bee.1415.coord)

bee.data.coord = bee.data.coord %>% filter(!is.na(x) & !is.na(y))

write.csv(bee.data.coord,"data/clean/bee_geocode.csv",row.names = FALSE)
 


library(rgdal)  # for vector work; sp package should always load with rgdal.
library (raster)   # for metadata/attributes- vectors or rasters



buffer = readOGR("Output/graph/buffer_4mile_clip.shp")

plot(buffer)

uass <- raster("C:/Users/Administrator/Desktop/2012_30m_cdls.img")

sun <- raster("C:/Users/Administrator/Desktop/sun.tif")

plot(sun)

(uass)

plot(uass[uass==6])

uass[uass!=6]=NA
uass$X2012_30m_cdls@data@attributes[[1]] 

raster::subset(uass,uass$X2012_30m_cdls@data@attributes[[1]]$ID==6)


uass$X2012_30m_cdls@data[uass$X2012_30m_cdls@data@attributes[[1]]$ID==6]

uass$X2012_30m_cdls@data@attributes[[1]]$ID[uass$X2012_30m_cdls@data@attributes[[1]]$ID==6]

unique(uass$X2012_30m_cdls)
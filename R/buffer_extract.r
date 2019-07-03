####################################################
# R code for extracting CDL data for given buffer zones  
####################################################

library(ggplot2) #Calls: fortify, ggplot
library(rgdal)   
library(sp)      
library(raster)
library(gdalUtils)
library(parallel)
library(rgeos)

# set your working directory

time0<- proc.time() #start timer
starttimezam <- proc.time() #begin processing timer

# shapefile and raster data stored under the file "gz_2010_us_050_00_20m"
# make sure that they are of the same projection system. If not, project them in arcgis.

#Read map (shapefile)
honey_4mile =readOGR("output/graph/by_year/4mile_2015_corrected.shp",layer="4mile_2015_corrected")

#raster_path
 
Land<-raster("YOUR_CDL_DATA")
 
 
clip1_land <- crop(Land, extent(county1)) #crop to extent of polygon
 
clip2_land <- rasterize(county1, clip1_land, mask=TRUE,na.rm=TRUE)  #rasterize the dataset after crop

ext <- getValues(clip2_land) # get the vlaues 

tab_ext<-table(ext) # make into table

mat_ext <- as.data.frame(tab_ext) # transform to data frame


# Do the extraction in loops 

extractor <- function(p){
  # we are using a tryCatch function for error handling
  # without it, if one of the extracts fails, the error message can overwrite all the real data from other chunks
  final = tryCatch({
    
    #plot(county1)
    clip1_land <- crop(Land, extent(county1)) #crop to extent of polygon
    clip2_land <- rasterize(county1, clip1_land, mask=TRUE,na.rm=TRUE)  #rasterize the dataset after crop
    ext <- getValues(clip2_land)
    tab_ext<-table(ext)
    mat_ext <- as.data.frame(tab_ext)
  },
  #if there is an error, return 0
  error = function(e){print(paste("error on #", p, " : ", e)); return(0)})
}

result <- data.frame() #empty result dataframe 
system.time(
  result <- do.call(rbind,mclapply(1:length(county_list), function(p) extractor(p),  mc.cores=4))
)

write.csv(result,"result_mcapply.csv") 



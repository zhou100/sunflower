####################################################
# R code for extracting the US greenland raster data 
# Based on code from Guyu Ye 
####################################################

library(ggplot2) #Calls: fortify, ggplot
library(rgdal)   
library(sp)      
library(raster)
library(gdalUtils)
library(parallel)
library(RCurl)
library(R.utils)
library(rgeos)

# set your working directory
mydir <- "/Users/yujunzhou/Downloads/"
setwd(mydir)


time0<- proc.time() #start timer
starttimezam <- proc.time() #begin processing timer

# shapefile and raster data stored under the file "gz_2010_us_050_00_20m"
# make sure that they are of the same projection system. If not, project them in arcgis.

#Read map (shapefile)
US_county=readOGR("gz_2010_us_050_00_20m",layer="state")

#raster_path
raster_path<-paste(getwd(),"gz_2010_us_050_00_20m/",sep = "/")

#raster_path<-paste(getwd(),"nlcd_2011_landcover_2011_edition_2014_10_10/",sep = "/")
rlist <- list.files(path=raster_path, 
                    pattern = "tif$",
                    full.names=TRUE)
# stack if multiple rasters, then run loop over the stacked list 
#r <- stack(rlist)

#before subset map，check for the shape
#plot(US_county)
#plot(state1)


# Demonstration using a single county 
time1 <- proc.time() #start timer
start_time<-time1
Land<-raster(rlist)
cat("read_data:","\n"); proc.time() - time1

county_list<-US_county$GEO_ID
county2<-county_list[1]
#county_list

# time split for each step for an example county
time1 <- proc.time() #start timer
county1<-US_county[US_county$GEO_ID==county2,]
plot(county1)
clip1_land <- crop(Land, extent(county1)) #crop to extent of polygon
cat("crop 1:","\n"); proc.time() - time1

time1 <- proc.time() #start timer
clip2_land <- rasterize(county1, clip1_land, mask=TRUE,na.rm=TRUE)  #rasterize the dataset after crop
#clip2_land<-mask(clip1_land,county1)
cat("rasterize:","\n"); proc.time() - time1

time1 <- proc.time() #start timer
ext <- getValues(clip2_land)
#mat <- t(mclapply(ex, FUN = mean,mc.cores = 4))
cat("getValues:","\n"); proc.time() - time1

time1 <- proc.time() #start timer
tab_ext<-table(ext)
cat("tabulate:","\n"); proc.time() - time1

time1 <- proc.time() #start timer
mat_ext <- as.data.frame(tab_ext)
grass<-mat_ext[mat_ext$ext == 71,]
count<-grass$Freq
percent<-count/length(ext)
cat("percent in this county:","\n");percent
cat("count:","\n"); proc.time() - time1

end_time<- proc.time() #end timer
cat("Entire time for one county:","\n")
summary(end_time - start_time)


extractor <- function(p){
  # we are using a tryCatch function for error handling
  # without it, if one of the extracts fails, the error message can overwrite all the real data from other chunks
  final = tryCatch({
    county_name<-county_list[p]
    county1<-US_county[US_county$GEO_ID==county_name,]
    #plot(county1)
    clip1_land <- crop(Land, extent(county1)) #crop to extent of polygon
    clip2_land <- rasterize(county1, clip1_land, mask=TRUE,na.rm=TRUE)  #rasterize the dataset after crop
    ext <- getValues(clip2_land)
    tab_ext<-table(ext)
    mat_ext <- as.data.frame(tab_ext)
    grass<-mat_ext[mat_ext$ext == 71,]
    count<-grass$Freq
    percent<-count/length(ext)
    #percent<-rbind(final,percent)
    data.frame(geoid=county_name,sum=length(ext), grassland_percent=percent)
  },
  #if there is an error, return 0
  error = function(e){print(paste("error on #", p, " : ", e)); return(0)})
}

result <- data.frame() #empty result dataframe 
system.time(
  result <- do.call(rbind,mclapply(1:length(county_list), function(p) extractor(p),  mc.cores=4))
)
write.csv(result,"result_mcapply.csv") 



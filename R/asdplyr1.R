library(plyr)
library(gpplot2)

readspec <- function(filename) {
  # A function to read and normalize column names on 
  #    spectral files from ASD devices
  
  spec <- read.table(filename, header=TRUE)
  names(spec) <- c('wavelength', 'reflectance')
  spec$experiment <- basename(filename)
  return(spec)
  
}

setwd('~/tmp/Lab1/Lab-data/group1')
# students should setwd to: 
#  /data/vol10/education/courses/Duckles_programming/Lab1/Lab-data/group1
files <- list.files(recursive=TRUE, pattern="mn.txt")

# ldply to take in a list and return a data frame
specs <- ldply(files, readspec)

# 7 bands of Landsat TM
landsat_tm <- list(c(450, 520), c(520, 600), c(630, 690), c(760, 900), c(1550, 1750), c(10400, 12500), c(2080, 2350))
landsat_etm <- list(c(450,520), c(520,600), c(630,690), c(770,900), c(1550,1750), c(10400,12500), c(2090,2350),c(520,900))
landsat_8 <- list(c(430,450),c(450,510), c(530,590), c(640, 670), c(850,880), c(1570,1650), c(2110,2290), c(500,680), c(1360,1380), c(10600,11190), c(11500,12510))


summarizebyband <- function(df, bands) {
  l <- ldply(bands, function(x) 
      return(
          data.frame(value=mean(
            subset(df, wavelength > x[1] & wavelength < x[2])$reflectance ) )
            )
          )
  return(data.frame(average=l,band=1:length(bands)))
}

ddply(specs, .(experiment), summarizebyband, landsat_tm)
ddply(specs, .(experiment), summarizebyband, landsat_etm)
ddply(specs, .(experiment), summarizebyband, landsat_8)

# Generalize to allow any operation
summarizebyband <- function(df, bands, FUN, sensor="unknown") {
  l <- ldply(bands, function(x) return(data.frame(value=FUN(subset(df, wavelength > x[1] & wavelength < x[2])$reflectance ) )))
  return(data.frame(average=l,band=1:length(bands),sensor=sensor))
}
ltm <- ddply(specs, .(experiment), summarizebyband, landsat_tm, mean,"tm")
etm <- ddply(specs, .(experiment), summarizebyband, landsat_etm, mean, "etm")
l8 <- ddply(specs, .(experiment), summarizebyband, landsat_8, mean, "l8")
toplot <- rbind(ltm,etm,l8)
ddply(specs, .(experiment), summarizebyband, landsat_tm,max)
ddply(specs, .(experiment), summarizebyband, landsat_tm,min)

ggplot(toplot, aes(x=band,y=value, color=experiment)) + geom_line(alpha=0.8) + geom_point() + facet_wrap(~sensor)

names(ltm)

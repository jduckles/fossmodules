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
landsat_tm <- list(c(450, 520), c(520, 600), c(630, 690), c(760, 900), 
                    c(1550, 1750), c(10400, 12500), c(2080, 2350))
landsat_etm <- list(c(450,520), c(520,600), c(630,690), c(770,900), 
                      c(1550,1750), c(10400,12500), c(2090,2350),c(520,900))
landsat_8 <- list(c(430,450),c(450,510), c(530,590), c(640, 670), c(850,880), 
                    c(1570,1650), c(2110,2290), c(500,680), c(1360,1380), c(10600,11190), c(11500,12510))


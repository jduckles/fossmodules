
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
spec <- read.csv('~/Dropbox/ERS2013/Module-R/Field-ASD-Data-2012Fall/25_grassland_75_pavement/25_grassland_75_pavement.mn.txt', sep='\t')
spec$expriment <- '25pctGrass75pavement'
names(spec) <- c('wavelength','intensity','experiment')


readspec <- function(filename) {
    # A function to read spectrograph files
    spec <- read.csv(filename, sep='\t')
    names(spec) <- c('wavelength', 'reflectance')
    spec$experiment <- basename(filename)
    return(spec)
}

files <- list.files(recursive=TRUE, pattern="mn.txt")

specs <- ldply(files, readspec)

# Landsat band ranges
landsat_tm <- c(450, 520, 520, 600, 630, 690, 760, 900, 1550, 1750)
landsat_etm <- c(450, 520, 520, 600, 630, 690, 770 900, 1550, 1750)

 annotate("text", x=485, y=0.99, label="1") +
    annotate("text", x=560, y=0.99, label="2") +
    annotate("text", x=615, y=0.99, label="3")
            

plot <- ggplot(specs, aes(x=wavelength, y=reflectance, color=experiment))
plot + geom_line() + ylim(0,1) 
plot + geom_line() + ylim(0,1) + geom_vline(x=landsat_tm, color="gray60", alpha=0.5) + annotate("text", x=485, y=0.99, label="1") +
    annotate("text", x=560, y=0.99, label="2") +
    annotate("text", x=615, y=0.99, label="3")

plot + facet_wrap(~experiment) +  geom_line() + geom_vline( x=landsat_tm, color='gray60', alpha=0.5) + ylim(0,1) 


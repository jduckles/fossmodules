library(raster)
library(plyr)
library(ggplot2)


month.abbr <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Nov","Dec")
month <- factor(rep(month.abbr, length=72), levels=month.abbr)
year <- rep(1:6, each=12)

summary_plots <- function(value) {
  print( qplot(x=month, y=value, group=year) + geom_line() )
}


pdf('summary_plots.pdf', width=11, height=8.5)
a_ply(ozone, c(1:2), summary_plots, .progress="text")
dev.off()

library(MASS)
deseasf <- function(value) lm(value ~ month - 1)
models <- alply(ozone, 1:2, deseasf, .progress="text")


#' Compile map of predictor range for Sentinel-2 exemplary dataset.
#'
#' @author Thomas Nauss
#' @contributer Peter Manning, Markus Fischer et al.
#'


# Set up working environment and defaults --------------------------------------
library(envimaR)
root_folder = path.expand("~/plygrnd/Kili-SES/")
source(file.path(root_folder, "Kili-SES-Playground/src/functions/000_setup.R"))



# Load data and extract value ranges for Kili-SES observation plots ------------
sen2files = list.files(envrmt$path_sentinel2, pattern = glob2rx("b*.tif"), 
                       full.names = TRUE)
sen2data = stack(sen2files)

plots = readOGR(file.path(envrmt$path_plots, "BPolygon.shp"), "BPolygon")

mapview(plots)

tdat_range = extract(sen2data, plots, df = TRUE)
saveRDS(tdat_range, file.path(envrmt$path_rds_data, "tdat_range.rds"))

tdat_range = melt(tdat_range, id.vars = "ID")

tdat_range$variable = factor(tdat_range$variable, 
                             levels = c("b2", "b3", "b4", "b5", "b6", "b7", "b8",
                                       "b8A", "b11", "b12"))

ggplot(tdat_range, aes(x=variable, y=value)) + 
  geom_violin(trim=FALSE, col = "red") + 
  labs(x = "Sentinel-2 bands", y = "Values")






minmax = function(values, ease = 0){
  curmin = min(values) * (1 - ease)
  curmax = max(values) * (1 + ease)
  return(c(curmin, curmax))
}

mapvalid = function(rastlayer, minmax){
  rastlayer[rastlayer == 0] = NA
  rastlayer[!(rastlayer >= minmax[1] & rastlayer <= minmax[2])] = NA
  return(rastlayer)
}





minmaxval = minmax(tdat_range$value[tdat_range$variable == "b2"], ease = 0.05)
b2 = mapvalid(sen2data$b2, minmaxval)
plot(b2, colNA = "black")

plot(sen2data$b2)


valrastmaps = lapply(names(sen2data), function(l){
  minmaxval = minmax(tdat_range$value[tdat_range$variable == l])
  rastmap = mapvalid(sen2data[[l]], minmaxval)
  return(rastmap)
})
valrastmaps = stack(valrastmaps)

plot(valrastmaps, colNA = "black")

valrastmaps_overlayed = overlay(valrastmaps, fun = mean)

plot(valrastmaps_overlayed, colNA = "black")

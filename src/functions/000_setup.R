# Set environment for environmental information systems analysis

root_folder = path.expand("~/plygrnd/Kili-SES/")
fcts_folder = file.path(root_folder, "Kili-SES-Playground/src/functions/")

project_folders = c("data/",
                    "data/sentinel2/",
                    "data/maped_datasets/",
                    "data/plots/",
                    "data/rds_data/",
                    "data/tmp/")

libs = c("colorspace", "ggplot2", "gpm", "maptools", "mapview", "raster", 
         "RColorBrewer", "reshape2", "rgdal", "sp", "sf", "tmap")

envrmt = createEnvi(root_folder = root_folder,
                    fcts_folder = fcts_folder,
                    folders = project_folders, 
                    path_prefix = "path_", libs = libs,
                    alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP",
                    alt_env_root_folder = "F:\\BEN\\edu")

# More settings
rasterOptions(tmpdir = envrmt$path_tmp)
mapviewOptions(basemaps = mapviewGetOption("basemaps")[c(3, 1:2, 4:5)])


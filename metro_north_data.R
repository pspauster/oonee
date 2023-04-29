library(tidyverse)
library(sf)
library(RSocrata)


metro_north_stations <- read_sf("/Users/patrickspauster/Downloads/nyu-2451-34756-shapefile")

metro_north_routes <- read_sf("/Users/patrickspauster/Downloads/nyu-2451-60065-shapefile")

lirr <- read.socrata("https://data.ny.gov/resource/2vcb-zrh4.csv") %>% 
  st_as_sf(wkt = "the_geom")

lirr_stations <- read_csv("https://data.ny.gov/api/views/wxmd-5cpm/rows.csv?accessType=DOWNLOAD") %>% 
  st_as_sf(wkt = "the_geom")

saveRDS(lirr, "Data/clean/lirr.rds")

saveRDS(lirr_stations, "Data/clean/lirr_stations.rds")

saveRDS(metro_north_stations, "Data/clean/MN_stations.rds")

saveRDS(metro_north_routes, "Data/clean/MN_routes.rds")

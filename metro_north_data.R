library(tidyverse)
library(sf)
library(RSocrata)
library(geojsonio)


metro_north_stations <- read_sf("/Users/patrickspauster/Downloads/nyu-2451-34756-shapefile")

metro_north_routes <- read_sf("/Users/patrickspauster/Downloads/nyu-2451-60065-shapefile")

lirr <- read.socrata("https://data.ny.gov/resource/2vcb-zrh4.csv") %>% 
  st_as_sf(wkt = "the_geom")

lirr_stations <- read_csv("https://data.ny.gov/api/views/wxmd-5cpm/rows.csv?accessType=DOWNLOAD") %>% 
  st_as_sf(wkt = "the_geom")

#njt_routes <- geojson_sf("/Users/patrickspauster/Downloads/Rail_Lines_of_NJ_Transit.geojson")

#njt_stations <- geojson_sf("/Users/patrickspauster/Downloads/NJ_Passenger_Rail_Stations.geojson")


saveRDS(lirr, "Data/clean/lirr.rds")

saveRDS(lirr_stations, "Data/clean/lirr_stations.rds")

saveRDS(metro_north_stations, "Data/clean/MN_stations.rds")

saveRDS(metro_north_routes, "Data/clean/MN_routes.rds")

saveRDS(njt_stations, "Data/clean/NJT_stations.rds")

saveRDS(njt_routes, "Data/clean/NJT_routes.rds")

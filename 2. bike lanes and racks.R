library(tidyverse)
library(sf)
library(RSocrata)


bike_lanes <- read_sf("C:/Users/patri/Documents/Wagner/Capstone/bike lanes")

bike_lanes_clean <- bike_lanes %>% janitor::clean_names()

saveRDS(bike_lanes_clean, "Data/clean/bike_lanes.rds") #save as an R dataset to pull in later

bike_racks <- read_sf("C:/Users/patri/Documents/Wagner/Capstone/racks")

bike_racks_clean <- bike_racks %>% janitor::clean_names()

saveRDS(bike_racks_clean, "Data/clean/bike_racks.rds") #save as an R dataset to pull in later

test <- read.socrata("https://data.cityofnewyork.us/resource/au7q-njtk.json")

#########################

# here's how to pull spatial data direct from the web without having to save down

library(geojsonio)

temp <- tempfile()
download.file("https://data.cityofnewyork.us/api/geospatial/7vsa-caz7?method=export&format=GeoJSON", temp) #on open data I just copied the geojson download link
data <- geojson_sf(temp)
unlink(temp)



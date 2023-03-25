library(tidyverse)
library(sf)
library(RSocrata)
library(geojsonsf)

bike_lanes <- read_sf("C:/Users/patri/Documents/Wagner/Capstone/bike lanes")

bike_lanes_clean <- bike_lanes %>% janitor::clean_names()

saveRDS(bike_lanes_clean, "Data/clean/bike_lanes.rds") #save as an R dataset to pull in later

bike_racks <- read_sf("C:/Users/patri/Documents/Wagner/Capstone/racks")

bike_racks_clean <- bike_racks %>% janitor::clean_names()

saveRDS(bike_racks_clean, "Data/clean/bike_racks.rds") #save as an R dataset to pull in later


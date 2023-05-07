library(tidyverse)
library(sf)
library(RSocrata)
library(geojsonsf)

subway_stations2 <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Subway Stations")

subwaystations_clean <- subway_stations2 %>% janitor::clean_names()

saveRDS(subwaystations_clean, "Data/clean/Subway_stations_clean.rds") #save as an R dataset to pull in later

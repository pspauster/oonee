library(tidyverse)
library(sf)
library(RSocrata)

bike_thefts_per_capita <- read_sf("/Users/jreed19/Desktop/Capstone/Existing Conditions/NEWSEST theft per capita.shp")

bike_thefts_per_capita_clean <- bike_thefts_per_capita %>% janitor::clean_names()

saveRDS(bike_thefts_per_capita_clean, "Data/clean/bike_thefts_per_capita_clean.rds")


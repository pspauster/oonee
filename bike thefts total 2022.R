library(tidyverse)
library(sf)
library(RSocrata)

bike_thefts_total <- read_sf("/Users/jreed19/Desktop/Capstone/Existing Conditions/theft rates by NTA full 2022.shp")

bike_thefts_total_clean <- bike_thefts_total %>% janitor::clean_names()

saveRDS(bike_thefts_total_clean, "Data/clean/bike_thefts_total_clean.rds")


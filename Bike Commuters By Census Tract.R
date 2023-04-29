library(tidyverse)
library(sf)
library(RSocrata)

bike_commuters_by_census_tract <- read_csv("/Users/jreed19/Downloads/ACSDT5Y2021.B08301_2023-04-29T165315/ACSDT5Y2021.B08301-Data.csv")

bike_commuters_by_census_tract_clean <- bike_commuters_by_census_tract %>% janitor::clean_names()

saveRDS(bike_thefts_total_clean, "Data/clean/bike_thefts_total_clean.rds")
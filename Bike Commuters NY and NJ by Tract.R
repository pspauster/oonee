library(tidyverse)
library(sf)
library(RSocrata)

bike_commuters_by_census_tract_NY_and_NJ <- read_csv("/Users/jreed19/Downloads/ACSDT5Y2021.B08301_2023-04-29T170747/ACSDT5Y2021.B08301-Data.csv")

bike_commuters_by_census_tract_NY_and_NJ_clean <- bike_commuters_by_census_tract_NY_and_NJ %>% janitor::clean_names()

saveRDS(bike_commuters_by_census_tract_NY_and_NJ_clean, "Data/clean/bike_commuters_by_census_tract_clean_NY_and_NJ.rds")
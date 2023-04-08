library(tidyverse)
library(sf)
library(RSocrata)

install.packages("geojsonsf")

library(geojsonsf)

MNR_stations_for_score <- read_rds("Data/clean/MN_stations.rds") %>% 
  mutate(score = 3) %>% 
  

  







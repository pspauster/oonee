library(tidyverse)
library(sf)
library(RSocrata)
library(dplyr)

lowincomejobs_for_score <- read_rds("Data/clean/lowincomejobs.rds") %>% 
  mutate(score = 3) 

middleincomejobs_for_score <- read_rds("Data/clean/middleincomejobs.rds") %>% 
  mutate(score = 2) 

highincomejobs_for_score <- read_rds("Data/clean/highincomejobs.rds") %>% 
  mutate(score = 1) 

bind_rows(lowincomejobs_for_score, middleincomejobs_for_score, highincomejobs_for_score)

NTAs <- read_rds("Data/clean/bike_thefts_total_clean.rds") %>% 

readRDS("Documents/GitHub/oonee/Data/clean/lowincomejobs.rds")

read_sf
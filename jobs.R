library(tidyverse)
library(sf)
library(RSocrata)
library(dplyr)
library(janitor)
install.packages('janitor')

jobs <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Jobs/low_income_jobs_2019.shp")
 
jobs_clean <- jobs %>% janitor::clean_names()

lowincomejobs <- jobs %>% select(ce01)

saveRDS(lowincomejobs, "Data/clean/lowincomejobs.rds")

middleincomejobs <- jobs %>% select(ce02)

saveRDS(middleincomejobs, "Data/clean/middleincomejobs.rds")

highincomejobs <- jobs %>% select(ce03)

saveRDS(highincomejobs, "Data/clean/highincomejobs.rds")

jobs_censustract <- read.csv("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/jobswithcensustracts.csv")

jobs_censustract_clean <- jobs_censustract %>% janitor:clean_names()

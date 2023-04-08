library(tidyverse)
library(sf)
library(RSocrata)
library(geojsonsf)

total_jobs <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/otm_08e74cad85ac418a8d18bf6dfb347218 copy 2")

total_jobs_clean <- total_jobs %>% janitor::clean_names()

saveRDS(total_jobs_clean, "Data/clean/total_jobs_clean.rds") #save as an R dataset to pull in later

Low_income_jobs <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/otm_08e74cad85ac418a8d18bf6dfb347218 copy")

Low_income_jobs_clean <- Low_income_jobs %>% janitor::clean_names()

saveRDS(Low_income_jobs_clean, "Data/clean/Low_income_jobs_clean.rds") #save as an R dataset to pull in later

library(tidyverse)
library(janitor)
library(sf)

#start off by making your own script and saving it with a number and the name of the data you're reading in
#the goal of this is to read in data, clean it, put it in spatial format, and save it to the clean data folder

#when you're done, you're going to want to "push" your changes to github so we all see the data

#start by dropping the raw data in the "raw" folder on your machine
#read in data
pod_locations <- read_csv("Data/raw/ooneepods - ooneepods.csv") 

#clean and format as shapefile
pod_locations_clean <- pod_locations %>% 
  clean_names() %>% 
  mutate(pilot = case_when(street_1 == "15 Journal Square Plaza" ~ "Permanent", #made a variable so we can sort by pilot/permanent
                           street_1 == "650 Atlantic Ave" ~ "Permanent",
                           street_1 == "89 E 42nd St" ~ "Permanent",
                           T ~ "Pilot"),
         type = case_when(street_1 == "15 Journal Square Plaza" ~ "Pod", #made a variable to sort by pod/min
                           street_1 == "650 Atlantic Ave" ~ "Pod",
                           T ~ "Mini")
         ) %>% 
  st_as_sf(coords = c("longitude", "latitude")) #this makes it into a simple features (spatial) object

saveRDS(pod_locations_clean, "Data/clean/pod_locations.rds") #save as an R dataset to pull in later
  


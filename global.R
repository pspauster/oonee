library(tidyverse)
library(sf)
library(shiny)
library(shinythemes)
library(shinydashboard)
library(leaflet)
library(leafpop)
library(DT)
library(htmlwidgets)
library(glue)
library(leaflegend) # you might need to double check your leaflegend version - this app requires 1.0.0 to use the latest functions
library(shinyWidgets)
library(shinyjs)

data_dir <- "Data/clean/"

bike_lanes <- readRDS(paste0(data_dir,"bike_lanes.rds"))

oonee_pods <- readRDS(paste0(data_dir, "pod_locations.rds"))

bike_racks <-readRDS(paste0(data_dir, "bike_racks.rds"))

jc_lanes <- readRDS(paste0(data_dir, "bike_lanes_jc.rds"))

jc_racks <- readRDS(paste0(data_dir, "bike_racks_jc.rds"))

thefts_pcap <- readRDS(paste0(data_dir, "bike_thefts_per_capita_clean.rds"))

subway_stations <- readRDS(paste0(data_dir, "Subway_stations_clean.rds")) %>% 
  st_set_crs(2263)

subway_routes <- readRDS(paste0(data_dir, "Subway_routes_clean.rds"))%>% 
  st_set_crs(2263)

PATH_stations <- readRDS(paste0(data_dir, "PATH_stations_clean.rds"))%>% 
  st_transform(4326)

PATH_routes <- readRDS(paste0(data_dir, "PATH_routes_clean.rds"))%>% 
  st_transform(4326)

LR_routes <- readRDS(paste0(data_dir, "NJ_transit_light_rail_routes_clean.rds")) %>% 
  st_transform(4326)

LR_stations <- readRDS(paste0(data_dir, "NJ_transit_light_rail_stations_clean.rds")) %>% 
  st_transform(4326)

MN_routes <- readRDS(paste0(data_dir, "MN_routes.rds"))

MN_stations <- readRDS(paste0(data_dir, "MN_stations.rds")) 

LIRR_routes <- readRDS(paste0(data_dir, "lirr.rds"))

LIRR_stations <- readRDS(paste0(data_dir, "lirr_stations.rds"))

NJT_routes <- readRDS(paste0(data_dir, "NJT_routes.rds"))

NJT_stations <- readRDS(paste0(data_dir, "NJT_stations.rds")) %>% 
  filter(str_detect(RAIL_LINE, "Light Rail") == F, str_detect(RAIL_LINE, "PATH")== F)

fourcolor <- c("yellow" ="#FEFC8C", "blue" = "#00E7FF", 
               "pink" = "#FF9AF2", "green" = "#9BDF5E")

hi_jobs <- readRDS(paste0(data_dir, "highincomejobs.rds")) %>% mutate(cat = "High income") %>% 
  rename(jobs = ce03) %>% 
  st_transform(4326)

mi_jobs <- readRDS(paste0(data_dir, "middleincomejobs.rds")) %>% mutate(cat = "Middle income") %>% 
  rename(jobs = ce02) %>% 
  st_transform(4326)

li_jobs <- readRDS(paste0(data_dir, "lowincomejobs.rds")) %>% mutate(cat = "Low income") %>% 
  rename(jobs = ce01) %>% 
  st_transform(4326)

total_jobs <- left_join(as.data.frame(hi_jobs), as.data.frame(mi_jobs), by = "geometry") %>% 
  left_join(as.data.frame(li_jobs), by = "geometry") %>% 
  mutate(cat = "Total",
        jobs = jobs.x + jobs.y + jobs) %>% 
  st_as_sf()

jobs_long <- bind_rows(hi_jobs, mi_jobs, li_jobs, total_jobs) %>% 
  filter(jobs >= 250)





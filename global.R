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

thefts_pcap <- readRDS(paste0(data_dir, "bike_thefts_per_capita_clean.rds"))

landuse <- readRDS(paste0(data_dir, "mappluto.rds"))

subway_stations <- readRDS(paste0(data_dir, "Subway_stations_clean.rds")) %>% 
  st_set_crs(2263)

subway_routes <- readRDS(paste0(data_dir, "Subway_routes_clean.rds"))%>% 
  st_set_crs(2263)

PATH_stations <- readRDS(paste0(data_dir, "PATH_stations_clean.rds"))%>% 
  st_transform(2263)%>% 
  st_cast("POINT")

PATH_routes <- readRDS(paste0(data_dir, "PATH_routes_clean.rds"))%>% 
  st_transform(2263) #%>% 
  #st_sfc("geometry") %>% 
  #st_cast("MULTIPOLYGON")







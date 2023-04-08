library(tidyverse)
library(sf)
library(RSocrata)
library(geojsonsf)

NJ_transit_bus_routes <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/NJ Transit data/Bus_Operating_Patterns_of_NJ_Transit")

NJ_transit_bus_routes_clean <- NJ_transit_bus_routes %>% janitor::clean_names()

saveRDS(NJ_transit_bus_routes_clean, "Data/clean/NJ_transit_bus_routes_clean.rds") #save as an R dataset to pull in later

NJ_transit_bus_stops <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/NJ Transit data/Bus_Stops_of_NJ_Transit_by_Line")

NJ_transit_bus_stops_clean <- NJ_transit_bus_stops %>% janitor::clean_names()

saveRDS(NJ_transit_bus_stops_clean, "Data/clean/NJ_transit_bus_stops_clean.rds") #save as an R dataset to pull in later

NJ_transit_light_rail_routes <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/NJ Transit data/Light_Rail_Lines_of_NJ_Transit")

NJ_transit_light_rail_routes_clean <- NJ_transit_light_rail_routes %>% janitor::clean_names()

saveRDS(NJ_transit_light_rail_routes_clean, "Data/clean/NJ_transit_light_rail_routes_clean.rds") #save as an R dataset to pull in later

NJ_transit_light_rail_stations <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/NJ Transit data/Light_Rail_Stations_of_NJ_Transit")

NJ_transit_light_rail_stations_clean <- NJ_transit_light_rail_stations %>% janitor::clean_names()

saveRDS(NJ_transit_light_rail_stations_clean, "Data/clean/NJ_transit_light_rail_stations_clean,.rds") #save as an R dataset to pull in later

Subway_stations <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Subway Entrances")

Subway_stations_clean <- Subway_stations %>% janitor::clean_names()

saveRDS(Subway_stations_clean, "Data/clean/Subway_stations_clean.rds") #save as an R dataset to pull in later

Subway_routes <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Subway Lines")

Subway_routes_clean <- Subway_routes %>% janitor::clean_names()

saveRDS(Subway_routes_clean, "Data/clean/Subway_routes_clean.rds") #save as an R dataset to pull in later

Bus_routes <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Baurch/bus_routes_nyc_dec2019")

Bus_routes_clean <- Bus_routes %>% janitor::clean_names()

saveRDS(Bus_routes_clean, "Data/clean/Bus_routes_clean.rds") #save as an R dataset to pull in later


Bus_stops <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Baurch/bus_stops_nyc_dec2019")

Bus_stops_clean <- Bus_stops %>% janitor::clean_names()

saveRDS(Bus_stops_clean, "Data/clean/Bus_stops_clean.rds") #save as an R dataset to pull in later

Express_bus_stops <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Baurch/express_bus_stops_nyc_dec2019")

Express_bus_stops_clean <- Bus_stops %>% janitor::clean_names()

saveRDS(Express_bus_stops_clean, "Data/clean/Express_bus_stops_clean.rds") #save as an R dataset to pull in later

Express_Bus_routes <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/Baurch/express_bus_routes_nyc_dec2019")

Express_Bus_routes_clean <- Express_Bus_routes %>% janitor::clean_names()

saveRDS(Express_Bus_routes_clean, "Data/clean/Express_Bus_routes_clean.rds") #save as an R dataset to pull in later

PATH_routes <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/nyu_2451_60069")

PATH_routes_clean <- PATH_routes %>% janitor::clean_names()

saveRDS(PATH_routes_clean, "Data/clean/PATH_routes_clean.rds") #save as an R dataset to pull in later

PATH_stations <- read_sf("/Users/evanmancini/Documents/Important Stuff/Education/NYU/Courses/8 - Spring 2023/Capstone 2/Existing Conditions Work/z_Original/PATH_Stations_Polygons_Zip_File.gdb")

PATH_stations_clean <- PATH_stations %>% janitor::clean_names()

saveRDS(PATH_stations_clean, "Data/clean/PATH_stations_clean.rds") #save as an R dataset to pull in later

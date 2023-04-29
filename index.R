library(tidyverse)
library(sf)
library(RSocrata)
library(tidycensus)

data_dir <- "Data/clean/"

ntas_to_tracts <- read.socrata("https://data.cityofnewyork.us/resource/hm78-6dwm.csv") %>% 
  mutate(geoid = as.character(geoid))
  
ntas_sf <- read.socrata("https://data.cityofnewyork.us/resource/9nt8-h7nd.csv") %>% 
  st_as_sf(wkt = T)

#transit
subway_stations <- readRDS(paste0(data_dir, "Subway_stations_clean.rds")) %>% 
  st_set_crs(st_crs(ntas_sf)) #need to swap this out for stations not entrances

NJT_stations <- readRDS(paste0(data_dir, "NJT_stations.rds")) %>% 
  filter(str_detect(RAIL_LINE, "Light Rail") == F, str_detect(RAIL_LINE, "PATH")== F) %>% 
  st_set_crs(st_crs(ntas_sf))

MN_stations <- readRDS(paste0(data_dir, "MN_stations.rds"))  %>% 
  st_set_crs(st_crs(ntas_sf))

LIRR_stations <- readRDS(paste0(data_dir, "lirr_stations.rds"))  %>% 
  st_set_crs(st_crs(ntas_sf))


ntas_counts_transit <- ntas_sf %>% 
  mutate(njt = lengths(st_intersects(ntas_sf, NJT_stations)),
         mn = lengths(st_intersects(ntas_sf, MN_stations)),
         lirr = lengths(st_intersects(ntas_sf, LIRR_stations)),
         subway = lengths(st_intersects(ntas_sf, subway_stations)), #adjust this for hubs
         transit_score = njt*3 + mn*3 + lirr*3 + subway
  )

hist(ntas_counts_transit$transit_score)


#theft
thefts_raw <- read_csv("Data/raw/NYPD_Complaint_Data_YTD FULL 2022.csv") %>% 
  st_as_sf(coords = c("Longitude", "Latitude")) %>% 
  st_set_crs(st_crs(ntas_sf))

pop20 <- get_decennial(
  geography = "tract",
  state = "New York",
  county = c("Kings", "New York", "Richmond", "Bronx", "Queens"),
  variables = "P1_001N",
  year = 2020
)

pop_nta <- ntas_to_tracts %>% 
  left_join(pop20, by = c("geoid" = "GEOID")) %>% 
  group_by(ntaname) %>% 
  summarize(population = sum(value))

nta_theft_score <- ntas_sf %>% 
  left_join(pop_nta, by = "ntaname") %>% 
  mutate(thefts = lengths(st_intersects(ntas_sf, thefts_raw)),
         thefts_per = thefts/population
  )

#jobs
hi_jobs <- readRDS(paste0(data_dir, "highincomejobs.rds")) %>% mutate(cat = "High income") %>% 
  rename(jobs = ce03) %>% 
  st_transform(4326) %>% 
  st_set_crs(st_crs(ntas_sf))

mi_jobs <- readRDS(paste0(data_dir, "middleincomejobs.rds")) %>% mutate(cat = "Middle income") %>% 
  rename(jobs = ce02)%>% 
  st_transform(4326) %>% 
  st_set_crs(st_crs(ntas_sf))

li_jobs <- readRDS(paste0(data_dir, "lowincomejobs.rds")) %>% mutate(cat = "Low income") %>% 
  rename(jobs = ce01) %>% 
  st_transform(4326) %>% 
  st_set_crs(st_crs(ntas_sf))

# a much easier way to do this would be with census tracts!
nta_jobs_scores <- ntas_sf %>% 
  st_join(hi_jobs, left = T) %>% 
  rename(hi_jobs = jobs) %>% 
  st_join(mi_jobs, left = T) %>% 
  rename(mi_jobs = jobs) %>% 
  st_join(li_jobs, left = T) %>% 
  rename(li_jobs = jobs)

nta_jobs_weighted <- nta_jobs_scores %>% 
  mutate(jobs_score = 3*li_jobs + 2*mi_jobs + hi_jobs)

#bike infrastructure
bike_lanes <- readRDS(paste0(data_dir,"bike_lanes.rds"))

bike_racks <-readRDS(paste0(data_dir, "bike_racks.rds"))

#bike commuters


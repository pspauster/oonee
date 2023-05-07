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

PATH_stations <- readRDS(paste0(data_dir, "PATH_stations_clean.rds"))%>% 
  st_set_crs(st_crs(ntas_sf))

LIRR_stations <- readRDS(paste0(data_dir, "lirr_stations.rds"))  %>% 
  st_set_crs(st_crs(ntas_sf))


nta_transit_score <- ntas_sf %>% 
  mutate(njt = lengths(st_intersects(ntas_sf, NJT_stations)),
         mn = lengths(st_intersects(ntas_sf, MN_stations)),
         lirr = lengths(st_intersects(ntas_sf, LIRR_stations)),
         path = lengths(st_intersects(ntas_sf, PATH_stations)),
         subway = lengths(st_intersects(ntas_sf, subway_stations)), #adjust this for hubs
         transit_score = njt*3 + mn*3 + lirr*3 + subway + path,
         transit_score_pct = percent_rank(transit_score)
  ) %>% 
  as.data.frame() %>% 
  select(ntaname, transit_score_pct)

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
  summarize(population = sum(value, na.rm = T))

nta_theft_score <- ntas_sf %>% 
  left_join(pop_nta, by = "ntaname") %>% 
  mutate(thefts = lengths(st_intersects(ntas_sf, thefts_raw)),
         thefts_per = thefts/population,
         theft_score_pct = percent_rank(thefts_per)
  ) %>% 
  as.data.frame() %>% 
  select(ntaname, theft_score_pct)

#jobs

jobs <- readRDS(paste0(data_dir, "jobs_with_censustracts.rds")) %>% 
  mutate(geoid = as.character(zone_id))

nta_jobs_score <- jobs %>% 
  left_join(ntas_to_tracts, jobs, by = "geoid") %>% 
  group_by(ntaname) %>% 
  summarize(jobs_score = 3*sum(inc_low, na.rm = T) + 2*sum(inc_med, na.rm = T) + sum(inc_high, na.rm = T)) %>% 
  as.data.frame() %>% 
  mutate(jobs_score_pct = percent_rank(jobs_score)) %>% 
  select(ntaname, jobs_score_pct)

#bike infrastructure
bike_lanes <- readRDS(paste0(data_dir,"bike_lanes.rds")) %>% 
  st_set_crs(st_crs(ntas_sf))

ntas_bikelanes <- st_intersection(ntas_sf, bike_lanes) %>% 
  group_by(ntaname) %>% 
  summarize(geometry = st_union(the_geom),
            bike_lane_length = st_length(geometry))

bike_racks <-readRDS(paste0(data_dir, "bike_racks.rds"))  %>% 
  st_set_crs(st_crs(ntas_sf))

racks_ntas <- ntas_sf %>% 
  mutate(no_racks = lengths(st_intersects(ntas_sf, bike_racks))
  ) %>% 
  select(ntaname, no_racks) %>% 
  as.data.frame()

nta_bike_score <- left_join(ntas_sf, as.data.frame(ntas_bikelanes), by = "ntaname") %>% 
  left_join(racks_ntas, by = "ntaname") %>% 
  mutate(bikeinfra_score_pct = percent_rank(percent_rank(bike_lane_length)/2 + percent_rank(no_racks))) %>% 
  as.data.frame() %>% 
  select(ntaname, bikeinfra_score_pct)

#bike commuters

bike_commuters <- readRDS(paste0(data_dir, "bike_commuters_by_census_tract_clean_NY_and_NJ.rds")) %>% 
  janitor::row_to_names(row_number = 1) %>% 
  janitor::clean_names() %>% 
  mutate(estimate_total_bicycle = as.integer(estimate_total_bicycle)) %>% 
  separate(geography, into = c("stub","geoid"), sep = "US")

nta_bikers_score <- left_join(ntas_to_tracts, bike_commuters, by = "geoid") %>% 
  group_by(ntaname) %>% 
  summarize(bike_commuters = sum(estimate_total_bicycle, na.rm = T)) %>% 
  mutate(bikers_score_pct = percent_rank(bike_commuters)) %>% 
  as.data.frame() %>% 
  select(ntaname, bikers_score_pct)


# compile 

index_layer <- ntas_sf %>% 
  left_join(nta_bike_score, by = "ntaname") %>% 
  left_join(nta_bikers_score, by = "ntaname") %>% 
  left_join(nta_jobs_score, by = "ntaname") %>% 
  left_join(nta_theft_score, by = "ntaname") %>% 
  left_join(nta_transit_score, by = "ntaname") %>% 
  group_by(ntaname) %>% 
  mutate(total_score = sum(bikeinfra_score_pct  , bikers_score_pct  , jobs_score_pct  , theft_score_pct  ,     
                            transit_score_pct, na.rm = T)) %>% 
  ungroup() %>% 
  arrange(desc(total_score)) %>% 
  mutate(rank = row_number())

hist(index_layer$total_score)

write_rds(index_layer, paste0(data_dir, "index.rds"))

  








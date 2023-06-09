library(tidyverse)
library(sf)
library(RSocrata)
library(arcpullr)

dest <- "/Users/patrickspauster/Downloads"
download.file("https://s-media.nyc.gov/agencies/dcp/assets/files/zip/data-tools/bytes/nyc_mappluto_22v3_1_shp.zip", paste0(dest,"/test.zip"))
unzip(zipfile = paste0(dest,"/test.zip"), exdir = paste0(dest,"/test"))
pluto_22v3 <- read_sf(paste0(dest,"/test"))

mappluto_clean <- pluto_22v3 %>% janitor::clean_names() %>% 
  mutate(landuse_clean = case_when(
    land_use == "01" ~ "Residential",
    land_use == "02" ~ "Residential",
    land_use == "03" ~ "Residential",
    land_use == "04" ~ "Mixed use",
    land_use == "05" ~ "Commercial",
    land_use == "06" ~ "Industrial",
    land_use == "07" ~ "Public facilities",
    land_use == "08" ~ "Public facilities",
    land_use == "09" ~ "Public facilities",
    land_use == "10" ~ "Vacant/Parking",
    land_use == "11" ~ "Vacant/Parking")) %>% 
  group_by(landuse_clean) %>% 
  summarize(geometry = st_union(geometry)) %>% 
  st_simplify(dTolerance = 10)
  
saveRDS(mappluto_clean, "Data/clean/mappluto.rds")

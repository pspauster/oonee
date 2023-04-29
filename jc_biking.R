library(geojsonio)

bike_lanes_jc <- geojson_sf("~/Downloads/bike-lanes-2020-division-of-transportation.geojson")
saveRDS(bike_lanes_jc, "Data/clean/bike_lanes_jc.rds") #save as an R dataset to pull in later

bike_racks_jc <- geojson_sf("~/Downloads/bike-parking-locations-division-of-transportation.geojson")
saveRDS(bike_racks_jc, "Data/clean/bike_racks_jc.rds") #save as an R dataset to pull in later

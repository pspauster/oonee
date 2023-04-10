server <- function(input, output) {
  
  pods_df <- reactive({
    oonee_pods %>%
      filter(pilot %in% input$pilot_onoff, type %in% input$pod_onoff) %>%
      st_set_crs(6623)
  })
  
  bikelanes_overlay <- reactive({
    bike_lanes_selected <- 
      bike_lanes %>% 
      filter(
        "Bike lanes" %in% input$overlay_bike
      ) %>% 
      st_set_crs(6623)
    return(bike_lanes_selected)
  })
  
  bikeracks_overlay <- reactive({
    bike_racks_selected <- 
      bike_racks %>% 
      filter(
        "Bike racks" %in% input$overlay_bike
      ) %>% 
      st_set_crs(6623)
    return(bike_racks_selected)
  })
  
  theft_pcap_quintile <- colorBin(
    c("#D1FCD4", "#8ECCB9", "#559B9E", "#566C7F", "#133F5A"), 
    thefts_pcap$ne_wthftpop, 
    bins = 5
  )
  
  theft_total_quintile <- colorBin(
    c("#D1FCD4", "#8ECCB9", "#559B9E", "#566C7F", "#133F5A"), 
    thefts_pcap$numpoints, 
    bins = 5
  )
  
  theftpcap_overlay <- reactive({
    theftpcap_selected <- 
      thefts_pcap %>% 
      filter(
        "Per capita" %in% input$overlay_theft
      ) %>% 
      st_set_crs(6623)
    return(theftpcap_selected)
  })
  
  theft_total_overlay <- reactive({
    theft_total_selected <- 
      thefts_pcap %>% 
      filter(
        "Total" %in% input$overlay_theft
      ) %>% 
      st_set_crs(6623)
    return(theft_total_selected)
  })
  
  landuse_bins <- colorFactor(topo.colors(length(landuse$landuse_clean)), landuse$landuse_clean)
  
  landuse_overlay <- reactive({
    lu_selected <- 
      landuse %>% 
      filter(
        input$landuse_onoff == T
      ) %>% 
      st_set_crs(6623)
    return(lu_selected)
  })
  
  subway_station_overlay <- reactive({
    ss_selected <- 
      subway_stations %>% 
      filter(
        "Stations" %in% input$overlay_subway
      ) %>% 
      st_set_crs(6623)
    return(ss_selected)
  })
  
  subway_route_overlay <- reactive({
    sr_selected <- 
      subway_routes %>% 
      filter(
        "Routes" %in% input$overlay_subway
      ) %>% 
      st_set_crs(6623)
    return(sr_selected)
  })
  
  path_station_overlay <- reactive({
    ps_selected <- 
      PATH_stations %>% 
       filter(
         "Stations" %in% input$overlay_subway
       ) %>% 
      st_set_crs(6623)
    return(ps_selected)
  })
  
  path_route_overlay <- reactive({
    pr_selected <- 
      PATH_routes %>% 
      filter(
        "Routes" %in% input$overlay_subway
      ) %>% 
      st_set_crs(6623)
    return(pr_selected)
  })
  
  output$map = renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -73.98867, lat = 40.71765, zoom = 12) %>%
      addCircleMarkers(data = pods_df(), radius = 1) %>% 
      addPolygons(data = bikelanes_overlay()) %>% 
      addPolygons(data = subway_route_overlay()) %>% 
      addPolygons(data = path_route_overlay()) %>% 
      addCircleMarkers(data = bikeracks_overlay(), radius = 1) %>% 
      addCircleMarkers(data = subway_station_overlay(), radius = 1) %>% 
      addCircleMarkers(data = path_station_overlay(), radius = 1) %>% 
      addPolygons(data = theftpcap_overlay(),
                  stroke = F,
                  fillOpacity = 0.3,
                  color = ~theft_pcap_quintile(ne_wthftpop)) %>% 
    addPolygons(data = theft_total_overlay(),
                stroke = F,
                fillOpacity = 0.3,
                color = ~theft_total_quintile(numpoints)) %>% 
    addPolygons(data = landuse_overlay(),
                stroke = F,
                fillOpacity = 0.3,
                color = ~landuse_bins(landuse_clean))
    })

  

}


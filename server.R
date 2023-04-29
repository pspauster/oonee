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
  
  jclanes_overlay <- reactive({
    bike_lanes_selected <- 
      jc_lanes %>% 
      filter(
        "Bike lanes" %in% input$overlay_bike
      ) %>% 
      st_set_crs(6623)
    return(bike_lanes_selected)
  })
  
  jcracks_overlay <- reactive({
    bike_racks_selected <- 
      jc_racks %>% 
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
  
  #landuse_bins <- colorFactor(topo.colors(length(landuse$landuse_clean)), landuse$landuse_clean)
  
  # landuse_overlay <- reactive({
  #   lu_selected <- 
  #     landuse %>% 
  #     filter(
  #       input$landuse_onoff == T
  #     ) %>% 
  #     st_set_crs(6623)
  #   return(lu_selected)
  # })
  
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
  
  lirr_route_overlay <- reactive({
    selected <- 
      LIRR_routes %>% 
      filter(
        "Routes" %in% input$overlay_rail
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  mn_route_overlay <- reactive({
    selected <- 
      MN_routes %>% 
      filter(
        "Routes" %in% input$overlay_rail
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  mn_station_overlay <- reactive({
    selected <- 
      MN_stations %>% 
      filter(
        "Stations" %in% input$overlay_rail
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  lirr_station_overlay <- reactive({
    selected <- 
      LIRR_stations %>% 
      filter(
        "Stations" %in% input$overlay_rail
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  lr_route_overlay <- reactive({
    selected <- 
      LR_routes %>% 
      filter(
        "Routes" %in% input$overlay_subway
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  lr_station_overlay <- reactive({
    selected <- 
      LR_stations %>% 
      filter(
        "Stations" %in% input$overlay_subway
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  njt_route_overlay <- reactive({
    selected <- 
      NJT_routes %>% 
      filter(
        "Routes" %in% input$overlay_rail
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  njt_station_overlay <- reactive({
    selected <- 
      NJT_stations %>% 
      filter(
        "Stations" %in% input$overlay_rail
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  jobs_overlay <- reactive({
    selected <- 
      jobs_long %>% 
      filter(
        cat == input$overlay_jobs,
        jobs != 0
      ) %>%
      st_set_crs(6623)
    return(selected)
  })
  
  output$map = renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.DarkMatter) %>% 
      setView(lng = -73.98867, lat = 40.71765, zoom = 12)  %>% 
      
      addPolylines(data = bikelanes_overlay(),
                  color = fourcolor[["green"]],
                  weight = 1) %>% 
      addPolylines(data = jclanes_overlay(),
                   color = fourcolor[["green"]],
                   weight = 1) %>% 
      addPolylines(data = subway_route_overlay(),
                  color = fourcolor[["blue"]],
                  weight = 1.5) %>% 
      addPolylines(data = path_route_overlay(),
                  color = fourcolor[["blue"]],
                  weight = 1.5) %>% 
      addPolylines(data = lirr_route_overlay(),
                   color = fourcolor[["blue"]],
                   weight = 2) %>% 
      addPolylines(data = mn_route_overlay(),
                   color = fourcolor[["blue"]],
                   weight = 2) %>% 
      addPolylines(data = lr_route_overlay(),
                   color = fourcolor[["blue"]],
                   weight = 1.5) %>% 
      addPolylines(data = njt_route_overlay(),
                   color = fourcolor[["blue"]],
                   weight = 2) %>% 
      
      addCircleMarkers(data = bikeracks_overlay(), radius = 0.5,
                       color = fourcolor[["green"]],
                       opacity = 0.5,
                       ) %>% 
      addCircleMarkers(data = jcracks_overlay(), radius = 0.5,
                       color = fourcolor[["green"]],
                       opacity = 0.5,
      ) %>% 
      addCircleMarkers(data = subway_station_overlay(), radius = 2,
                       color = fourcolor[["blue"]]) %>% 
      addCircleMarkers(data = mn_station_overlay(), radius = 3,
                       color = fourcolor[["blue"]]) %>% 
      addCircleMarkers(data = lirr_station_overlay(), radius = 3,
                       color = fourcolor[["blue"]]) %>% 
      addCircleMarkers(data = path_station_overlay(), radius = 2,
                       color = fourcolor[["blue"]]) %>% 
      addCircleMarkers(data = lr_station_overlay(), radius = 2,
                       color = fourcolor[["blue"]]) %>% 
      addCircleMarkers(data = njt_station_overlay(), radius = 3,
                       color = fourcolor[["blue"]]) %>% 

      addPolygons(data = theftpcap_overlay(),
                  stroke = F,
                  fillOpacity = 0.6,
                  color = ~theft_pcap_quintile(ne_wthftpop)) %>%
      addPolygons(data = theft_total_overlay(),
                stroke = F,
                fillOpacity = 0.6,
                color = ~theft_total_quintile(numpoints)) %>%
      
      addCircleMarkers(
        data = jobs_overlay(),
        opacity = 0.5,
        color = fourcolor[["pink"]],
        radius = ~sqrt(jobs/100)
      ) %>% 
      
      addCircleMarkers(data = pods_df(), radius = 6,
                       opacity = 1,
                       stroke = T,
                       #color = "#434243",
                       #color = "#FEFC8C"
                       color = fourcolor[["yellow"]],
      )

    })
  
  observe({
    proxy <- leafletProxy("map")
    
    proxy %>% clearControls()
    if ("Per capita" %in% input$overlay_theft) {
      proxy %>% 
        addLegend(data = theftpcap_overlay(), 
                  "bottomright", 
                  pal = theft_pcap_quintile, values = ~ne_wthftpop,
                  title = "Thefts per capita",
                  labFormat = labelFormat(prefix = ""),
                  opacity = 1
        )
    }
    if ("Total" %in% input$overlay_theft) {
        proxy %>% 
          addLegend(data = theftpcap_overlay(), 
                    "bottomright", 
                    pal = theft_total_quintile, values = ~numpoints,
                    title = "Total Thefts",
                    labFormat = labelFormat(prefix = ""),
                    opacity = 1
          )
    }
    
    
    

    
    
  })
  

}


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
        "Bike lanes" %in% input$overlay
      )
    return(bike_lanes_selected)
  })
  
  output$map = renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -73.98867, lat = 40.71765, zoom = 12) %>%
      addCircleMarkers(data = pods_df(), radius = 1) %>% 
      addPolygons(data = bike_lanes %>% st_set_crs(6623),
                  group = "bikelanes")
    })
  
  # observe({
  #   if (!"Bike lanes" %in% input$overlay) {
  #   leafletProxy("map", data = bike_lanes) %>%
  #     clearShapes() %>%
  #     hideGroup("bikelanes")
  #     }
  # })
  

}


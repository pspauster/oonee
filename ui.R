ui <- fluidPage(
  
  titlePanel("Oonee Network Development Tool"),
  
  sidebarLayout(
    
    sidebarPanel = sidebarPanel(
      checkboxGroupInput(
        "pilot_onoff",
        "Oonee Program",
        selected = unique(oonee_pods$pilot),
        choices = unique(oonee_pods$pilot),
        inline = TRUE
        ),
      checkboxGroupInput(
        "pod_onoff",
        "Pod Types",
        selected = unique(oonee_pods$type),
        choices = unique(oonee_pods$type),
        inline = TRUE
      ),
      checkboxGroupInput(
          "overlay_bike",
          "Bike Infrastructure", 
          selected = NULL,
          choices = c("Bike lanes", "Bike racks")
        ),
      checkboxGroupInput(
        "overlay_theft",
        "Bike Theft", 
        selected = NULL,
        choices = c("Per capita", "Total")
      ),
      checkboxGroupInput(
        "overlay_theft",
        "Bike Theft", 
        selected = NULL,
        choices = c("Per capita", "Total")
      ),
      checkboxGroupInput(
        "overlay_subway",
        "Subway/PATH", 
        selected = NULL,
        choices = c("Stations", "Routes")
      ),
      materialSwitch(
        "landuse_onoff",
        "Land Use",
        value = FALSE,
        status = "primary"
      ),
    ),
    mainPanel = mainPanel(
      leafletOutput(outputId = 'map')
    )
    
  )
)


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
          "overlay",
          "Bike Infrastructure", 
          selected = NULL,
          choices = c("Bike lanes", "Bike racks", "Bike corrals")
        ),
    ),
    mainPanel = mainPanel(
      leafletOutput(outputId = 'map')
    )
    
  )
)


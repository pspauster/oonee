ui <- fluidPage(
  
  titlePanel("Oonee Network Development Tool"),
  
  setBackgroundColor(
    color = "gray",
    gradient = c("linear", "radial"),
    direction = c("bottom", "top", "right", "left"),
    shinydashboard = FALSE
  ),
  
  sidebarLayout(
    
    sidebarPanel = sidebarPanel(
      width = 3,
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
        "overlay_subway",
        "Subway/PATH", 
        selected = NULL,
        choices = c("Stations", "Routes")
      ),
      checkboxGroupInput(
        "overlay_rail",
        "Commuter Rail",
        selected = NULL,
        choices = c("Stations", "Routes")
      ),
      selectInput(
        "overlay_jobs",
        "Jobs",
        choices = c("-","Total", "High income", "Middle income", "Low income")
      )
    ),
    mainPanel = mainPanel(
      tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
      leafletOutput(outputId = 'map'),
      width = 9,
    )
    
  )
)


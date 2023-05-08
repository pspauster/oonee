ui <- fluidPage(
  
  titlePanel("Oonee Network Development Tool"),
  
  setBackgroundColor(
    color = "#d2d2d2",
    gradient = c("linear", "radial"),
    direction = c("bottom", "top", "right", "left"),
    shinydashboard = FALSE
  ),
  
  tags$head(tags$style("h2{
                            color: black;
                                }
                        h3{
                            color: white;
                            font-size: 14px;
                                 }
                       .well {
                            background-color: gray;
                        }
                       #pilot_onoff-label {
                            color: #FEFC8C;
                       }
                       #pod_onoff-label {
                            color: #FEFC8C;
                       }
                       #overlay_bike-label {
                            color: #9BDF5E;
                       }
                       #overlay_theft-label {
                            color: #8ECCB9;
                       }
                       #overlay_subway-label {
                            color: #00E7FF;
                       }
                       #overlay_rail-label {
                            color: #00E7FF;
                       }
                       #overlay_jobs-label {
                            color: #FF9AF2;
                       }
                       #overlay_score-label {
                            color: white;
                       }                       
                      span {
                            color: white;
                            font-size: 12px;
                      }
                      h4 {
                            color: #FEFC8C;
                            font-size: 12px;
                      }
                       "
    )
  ),
  
  sidebarLayout(
    
    sidebarPanel = sidebarPanel(
      width = 4,

      div(
        tags$h4(
        "Use this interactive map to identify locations that would best support secure bicycle parking. Toggle the evaluation criteria below to see how different metrics influence bicycle parking needs and feasibility. The Network Development Index Components combine these metrics to create scores that can be used to evaluate potential locations for Oonee stations. Neighborhoods with higher scores may be more likely to host successful Oonee stations, while neighborhoods with lower scores may be more challenging."
        )
        ),
      div(
        tags$h3("Neighborhood Bike Parking Scores")
      ),
      checkboxInput(
        "overlay_total",
        "Network Development Index Total Score",
        value = T,
      ),
      checkboxGroupInput(
        "pilot_onoff",
        "Oonee Program",
        selected = unique(oonee_pods$pilot),
        choices = unique(oonee_pods$pilot),
        inline = TRUE
        ),
      checkboxGroupInput(
        "pod_onoff",
        "Station Types",
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
      ),
      checkboxGroupInput(
        "overlay_score",
        "Network Development Index Components",
        selected = NULL,
        choices = c("Transit score", "Bike infrastructure score", "Bike commuter score", "Bike theft score", "Jobs score")
      )
    ),
    mainPanel = mainPanel(
      tabsetPanel(
        tabPanel(
          "Map",
          tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}
                                             .legend span {
                                             color: black;
                                             }"),
          leafletOutput(outputId = 'map'),
          width = 9,
        ),
        tabPanel("About",
                 includeMarkdown("About.md"))
      )
    )
    
  )
)


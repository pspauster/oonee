header <- dashboardHeader()
sidebar <- dashboardSidebar(disable = T,
                            collapsed = TRUE,
                            sidebarMenu(
                              menuItem(text = "Map", tabName = "map")
                            )
)
body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "map",
      titlePanel("Oonee Network Development Tool"),
      sidebarLayout(
        sidebarPanel(
          tags$head(
            tags$style(HTML("
        input[type=number] {
              -moz-appearance:textfield;
        }
        input[type=number]::{
              -moz-appearance:textfield;
        }
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
        }
    "))
          ),
          materialSwitch(
            "oonee_pods_onoff",
            "Oonee pods",
            value = TRUE,
            status = "primary"
          ),
          materialSwitch(
            "bike_lanes_onoff",
            "Bike Lanes",
            value = FALSE,
            status = "primary"
          ),

          # checkboxGroupInput(
          #   "zone",
          #   "Zoning district:",
          #   selected = unique(map_hotels_data$main_zone),
          #   choices = unique(map_hotels_data$main_zone),
          #   inline = TRUE
          # ),
          # sliderInput(
          #   "year",
          #   "Year built:",
          #   min = 1825,
          #   max = 2020,
          #   value = c(1825, 2020),
          #   sep = "",
          #   ticks = FALSE
          # ),
          # pickerInput(
          #   "class",
          #   "Hotel class:",
          #   selected = unique(map_hotels_data$bldgclass_names),
          #   choices = unique(map_hotels_data$bldgclass_names),
          #   multiple = TRUE,
          #   options = list(`actions-box` = TRUE)
          # ),
          # sliderInput(
          #   "rooms",
          #   "Hotel room count:",
          #   min = min_rooms,
          #   max = max_rooms,
          #   value = c(min_rooms,max_rooms),
          #   sep = "",
          #   ticks = FALSE
          # ),
          # checkboxGroupInput(
          #   "stab",
          #   "Hotel has stabilized units:", 
          #   selected = unique(map_hotels_data$has_stab),
          #   choiceValues = unique(map_hotels_data$has_stab), 
          #   choiceNames = c("No rent stabilized units", "Has rent stabilized units"),
          #   inline = TRUE
          # ),
          # checkboxGroupInput(
          #   "union",
          #   "Union hotel:", 
          #   selected = unique(map_hotels_data$is_union),
          #   choiceValues = unique(map_hotels_data$is_union), 
          #   choiceNames = c("Non-union", "Union"),
          #   inline = TRUE
          # ),
          # sliderInput(
          #   "bldgheight_select",
          #   "Office building height (stories):",
          #   min = 1,
          #   max = max_height,
          #   value = c(5,max_height),
          #   sep = "",
          #   ticks = FALSE
          # ),
          # sliderInput(
          #   "bldgdepth_select",
          #   "Office building depth (ft):",
          #   min = min_depth,
          #   max = max_depth,
          #   value = c(min_depth,max_depth),
          #   step = 25,
          #   sep = "",
          #   ticks = FALSE
          # ),
          # numericRangeInput(
          #   "gi_sqft_select",
          #   "Office Gross Income per square ft ($0-$200+):",
          #   min = floor(min_gi_sf),
          #   max = ceiling(max_gi_sf),
          #   value = c(floor(min_gi_sf),ceiling(max_gi_sf)),
          #   step = 1,
          #   sep = "",
          #   width = "150px"
          # ),
          # sliderInput(
          #   "gi_sf_pct_select",
          #   "Office Percentile of Gross Income per square ft (%):",
          #   min = min_gi_sf_pct,
          #   max = max_gi_sf_pct,
          #   value = c(min_gi_sf_pct,max_gi_sf_pct),
          #   step = 1,
          #   sep = "",
          #   ticks = FALSE
          # ),
          # h2("Overlays"),
          # checkboxGroupInput(
          #   "overlay",
          #   "", 
          #   selected = NULL,
          #   choices = c("Median rent", "Art.I ch.5 area", "Community districts")
          # ),
        ),
        mainPanel(tabsetPanel(
          tabPanel("Map", leafletOutput("map_buildings", height = 800)),
          # tabPanel("About",
          #          #titlePanel("About this Map"),
          #          includeMarkdown("about_data.md")),
          # tabPanel(
          #   "Data",
          #   DT::DTOutput("details_data"),
          #   br(),
          #   downloadButton(("details_download"), glue("Download this data"))
          # )
        ))
      )
    )
  )
)

ui <- dashboardPage(header, sidebar, body, useShinyjs())
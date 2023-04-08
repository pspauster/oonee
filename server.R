server <- function(input, output) {
  
  zone_hotels <- reactive({
    hotels_filtered <- map_hotels_data %>%
      filter(
        main_zone %in% input$zone,
        bldgclass_names %in% input$class,
        yearbuilt >= input$year[1] & yearbuilt <= input$year[2],
        final_rooms >= input$rooms[1] & final_rooms <= input$rooms[2],
        has_stab %in% input$stab,
        is_union %in% input$union,
        input$hotels_onoff
      )
    return(hotels_filtered)
  })
  zone_commercial <- reactive({
    commercial_filtered <- map_commercial_data %>% 
      filter(
        main_zone %in% input$zone,
        yearbuilt >= input$year[1] & yearbuilt <= input$year[2],
        bldgdepth >= input$bldgdepth_select[1] & bldgdepth <= input$bldgdepth_select[2],
        numfloors >= input$bldgheight_select[1] & numfloors <= input$bldgheight_select[2],
        gross_inc_sqft_20 >= input$gi_sqft_select[1] & gross_inc_sqft_20 <= input$gi_sqft_select[2],
        #gi_sf_pct >= input$gi_sf_pct_select[1] & gi_sf_pct <= input$gi_sf_pct_select[2],
        input$office_onoff
      )
    return(commercial_filtered)
  })
  
  
  rent_overlay <- reactive({
    rent_selected <- 
      sbas %>% 
      filter(
        "Median rent" %in% input$overlay
      )
    return(rent_selected)
  })
  art1_overlay <- reactive({
    art1_selected <- 
      art1_area %>% filter(
        "Art.I ch.5 area" %in% input$overlay
      )
    return(art1_selected)
  })
  community_dist_overlay <- reactive({
    cd_selected <- 
      cd_outlines %>% filter(
        "Community districts" %in% input$overlay
      ) 
    return(cd_selected)
  })
  
  
  # default base map
  output$map_buildings <- renderLeaflet({
    leaflet() %>%
      setView(lng = -74.000060,
              lat = 40.730910,
              zoom = 12) %>%
      addProviderTiles(
        providers$CartoDB.Positron
      ) 
  })
  
  
  
  
  ### reactive points 
  observeEvent(c(zone_hotels(),zone_commercial()), {
    legend_pal <- colorFactor(c('#40899A','#984415'),c("Hotel","Office"), ordered=TRUE)
    buildings_markers <- leafletProxy("map_buildings") %>%
      clearMarkers() %>%
      removeControl(layerId = "buildings legend") %>% 
      addMapPane("markers", zIndex = 510) %>% 
      addCircleMarkers(
        data = zone_hotels(),
        radius = 1.5,
        color = '#40899A',
        group = 'hotel_markers',
        popup = zone_hotels()$popup_text,
        fillOpacity = 0.75,
        opacity = 0.75,
        options = pathOptions(pane = "markers")
      ) %>%
      addCircleMarkers(
        data = zone_commercial(),
        radius = 1.5,
        color = '#984415',
        opacity = 0.75,
        fillOpacity = 0.75,
        popup = zone_commercial()$popup_text,
        options = pathOptions(pane = "markers")
      )
    if (input$hotels_onoff || input$office_onoff) {
      buildings_markers %>% addLegendFactor(
        pal = legend_pal,
        values = c("Hotel","Office")[c(input$hotels_onoff, input$office_onoff)],
        shape = 'circle',
        width = 4,
        height = 4,
        position = 'bottomleft',
        layerId = "buildings legend"
      )}
  })
  
  ### reactive overlays
  observeEvent(c(
    rent_overlay(), 
    art1_overlay(),
    community_dist_overlay()
  ), {
    rent_quantile <- colorBin(
      c("#D1FCD4", "#8ECCB9", "#559B9E", "#566C7F", "#133F5A"), 
      sbas$rent_gross_med_adj, 
      bins = 5
    )
    overlay_map <- leafletProxy("map_buildings") %>% 
      addMapPane("overlays", zIndex = 410) %>% 
      clearShapes() %>%
      removeControl("rent legend") %>% 
      removeControl("ArtI legend") %>% 
      addPolygons(
        data = rent_overlay(),
        stroke = F,
        fillOpacity = 0.3,
        color = ~rent_quantile(rent_gross_med_adj),
        smoothFactor = 2,
        options = pathOptions(pane = "overlays"),
        group = "Median rent"
      ) %>% 
      addPolygons(
        data = art1_overlay(),
        color='#123F5A',
        fillOpacity = 0,
        dashArray = '3,5',
        weight = 3,
        smoothFactor = 2,
        options = pathOptions(pane = "overlays"),
        group = "Article I Ch. 5 area"
      ) %>% 
      addPolygons(
        data = community_dist_overlay(),
        weight = 2,
        fill = F,
        color = '#6E6E6E',
        smoothFactor = 2,
        options = pathOptions(pane = "overlays"),
        group = "Community District Boundaries"
      )
    if ("Median rent" %in% input$overlay) {
      overlay_map %>% 
        addLegendBin(
          pal = rent_quantile,
          fillOpacity = 0.5,
          height = 15,
          width = 15,
          opacity = 0,
          title = 'Median rent',
          position = 'bottomleft',
          layerId = "rent legend",
        )
    }
    if ("Art.I ch.5 area" %in% input$overlay) {
      overlay_map %>% 
        addLegendSymbol(
          color='#123F5A',
          shape = 'diamond',
          strokeWidth = 3,
          fillOpacity = 0,
          width = 10,
          values = "Art.I ch.5 area",
          position = 'bottomleft',
          layerId = "ArtI legend"
        )
    }
    
  })
  
  # when input change, update pct slider
  observeEvent(input$gi_sqft_select,  {
    updateSliderInput(inputId = "gi_sf_pct_select",
                      value = c(round(sum(map_commercial_data$gross_inc_sqft_20 < input$gi_sqft_select[1], na.rm = T)/length(map_commercial_data$gross_inc_sqft_20[!is.na(map_commercial_data$gross_inc_sqft_20)])*100),
                                round(sum(map_commercial_data$gross_inc_sqft_20 < input$gi_sqft_select[2], na.rm = T)/length(map_commercial_data$gross_inc_sqft_20[!is.na(map_commercial_data$gross_inc_sqft_20)])*100))) #replace value pct for that gi range
  })
  
  # when pct change, update input
  observeEvent(input$gi_sf_pct_select,  {
    updateNumericRangeInput(inputId = "gi_sqft_select",
                            value = c((quantile(map_commercial_data$gross_inc_sqft_20, input$gi_sf_pct_select[1]/100, na.rm = T)),
                                      (quantile(map_commercial_data$gross_inc_sqft_20, input$gi_sf_pct_select[2]/100, na.rm = T)))) #replace value gi range for that pctile
  })
  
  
  #hide menus conditionally
  observeEvent(input$hotels_onoff, {
    toggle("class", condition = input$hotels_onoff == 1)
    toggle("rooms", condition = input$hotels_onoff == 1)
    toggle("stab", condition = input$hotels_onoff == 1)
    toggle("union", condition = input$hotels_onoff == 1)
  })
  
  observeEvent(input$office_onoff, {
    toggle("bldgheight_select", condition = input$office_onoff == 1)
    toggle("bldgdepth_select", condition = input$office_onoff == 1)
    toggle("gi_sqft_select", condition = input$office_onoff == 1)
    toggle("gi_sf_pct_select", condition = input$office_onoff == 1)
  })
  
  
  output$details_data <- renderDT(
    bind_rows(
      zone_hotels() %>%
        st_set_geometry(NULL) %>%
        transmute(
          `BBL` = bbl,
          `Address` = address,
          `Type` = "Hotel",
          `Building Class` = bldgclass,
          `Building Class Name` = bldgclass_names,
          `CD Display` = cdnew_display,
          `CD Name` = cdname,
          `Borough`=borough,
          `Hotel Room Count` = final_rooms,
          `Zoning` = zonedist1,
          `Year Built` = yearbuilt,
          `Built FAR` = builtfar,
          `Rent Stabilized Units (Hotel)` = has_stab
        ),
      zone_commercial() %>% 
        st_set_geometry(NULL) %>%
        transmute(
          `BBL` = bbl,
          `Address` = address,
          `Type` = "Office",
          `Building Class` = bldgcl,
          `Building Class Name` = bldg_class_names,
          `CD Display` = cdnew_display,
          `CD Name` = cdname,
          `Borough`= borough,
          `Zoning` = zonedist1,
          `Year Built` = yearbuilt,
          `Height (stories)` = stories,
          `Built FAR` = builtfar,
          `Building Depth` = bldgdepth,
          `Office sq ft` = officearea,
          `Gross Income` = gross_income_20_pretty,
          `Net Income` = net_income_20_pretty,
          `Gross Income per Sq Ft` = gross_inc_sqft_20_pretty,
          `Net Income per Sqft` = net_inc_sqft_20_pretty,
        )
    ), rownames = FALSE,
    options = list(scrollX = T)
  )
  
  output$details_download <- downloadHandler(
    filename = function() {
      glue("nyc_properties_selection_{Sys.Date()}.csv")
    },
    content = function(file) {
      bind_rows(
        zone_hotels() %>%
          st_set_geometry(NULL) %>%
          transmute(
            `BBL` = bbl,
            `Address` = address,
            `Type` = "Hotel",
            `Building Class` = bldgclass,
            `Building Class Name` = bldgclass_names,
            `CD Display` = cdnew_display,
            `CD Name` = cdname,
            `Borough`= borough,
            `Hotel Room Count` = final_rooms,
            `Zoning` = zonedist1,
            `Year Built` = yearbuilt,
            `Built FAR` = builtfar,
            `Rent Stabilized Units (Hotel)` = has_stab
          ),
        zone_commercial() %>% 
          st_set_geometry(NULL) %>%
          transmute(
            `BBL` = bbl,
            `Address` = address,
            `Type` = "Office",
            `Building Class` = bldgcl,
            `Building Class Name` = bldg_class_names,
            `CD Display` = cdnew_display,
            `CD Name` = cdname,
            `Borough`= borough,
            `Zoning` = zonedist1,
            `Year Built` = yearbuilt,
            `Height (stories)` = stories,
            `Built FAR` = builtfar,
            `Building Depth` = bldgdepth,
            `Office sq ft` = officearea,
            `Gross Income` = gross_income_20_pretty,
            `Net Income` = net_income_20_pretty,
            `Gross Income per Sq Ft` = gross_inc_sqft_20_pretty,
            `Net Income per Sqft` = net_inc_sqft_20_pretty,
          )
      ) %>%
        write.csv( file, na = "", row.names=FALSE)
    }
  )
  
  
}

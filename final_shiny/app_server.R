poverty_data <- read.csv('irs.csv')
race_df <- read.csv('dt.csv')
library(ggplot2)
library(plotly)
library(tidyverse)
library(scales)
library(leaflet)

# Viz1 --------------------------------------------------------------------

mutated_data <- poverty_data %>%
  transmute(Total_exemptions = as.numeric(gsub(",","", Total.exemptions)),
         Poor_exemptions = as.numeric(gsub(",","", Poor.exemptions)),
         Poor_Exemptions_Over_Age65 = as.numeric(gsub(",","", Age.65.and.over.poor.exemptions)),
         Poor_Exemptions_Under_Age65 = as.numeric(gsub(",","", Poor.exemptions.under.age.65)),
         Poor_Child_exemptions = as.numeric(gsub(",","", Poor.child.exemptions)),
         Year = Year,
         State = Name) %>%
  select(State, Year, Total_exemptions,Poor_exemptions,
         Poor_Exemptions_Over_Age65, Poor_Exemptions_Under_Age65,
         Poor_Child_exemptions)

# Filter for avg exemptions each year
Avg_exemptions <- mutated_data %>%
  group_by(Year) %>%
  summarise(Total_exemptions = mean(sum(Total_exemptions)),
            Poor_exemptions = mean(sum(Poor_exemptions)),
            Poor_Exemptions_Over_Age65 = mean(sum(Poor_Exemptions_Over_Age65)),
            Poor_Exemptions_Under_Age65 = mean(sum(Poor_Exemptions_Under_Age65)),
            Poor_Child_exemptions = mean(sum(Poor_Child_exemptions))) %>%
  select(Year, Total_exemptions, Poor_exemptions, Poor_Exemptions_Over_Age65,
         Poor_Exemptions_Under_Age65, Poor_Child_exemptions)


# Viz2 --------------------------------------------------------------------


# Viz3 --------------------------------------------------------------------



# Render-server -----------------------------------------------------------


server <- function(input, output){

# Render-viz1 -------------------------------------------------------------

  output$Viz1 <- renderPlotly({

    filtered_data <- Avg_exemptions %>%
      filter(Year >= input$year[1] &
               Year <= input$year[2])
      # filter(State == input$state)


    plot1 <- ggplot(data = filtered_data)+
      geom_line(mapping = aes_string(x = "Year", y = input$exemptype),
                colour = "SkyBlue", size = 1.5)+
      labs(y = paste("Number Of",input$exemptype, sep = " "),
           title = paste(input$exemptype,"Over Time in the U.S"))+
      scale_y_continuous(
        labels = unit_format(unit = "M", scale = 1e-6)
      )

    ggplotly(plot1)
       })

# Render-viz2 -------------------------------------------------------------

  output$Viz2 <- renderPlotly({
    mdf <- race_df %>%
      filter(Location == input$state_var) %>%
      select(Year, input$race_var)

    grf <- ggplot(mdf) +
      geom_col(mapping = aes_string(x = mdf$Year, y = input$race_var), fill = "#385c84") +
      labs(x = "Year", y = paste("Pverty Count Represented by Race:",
                                 input$race_var, sep = " "),
           title = paste("Poverty Count of", input$race_var,
                         "Population in", input$state_var, "From 2009 to 2019", sep = " ")) +
      scale_x_continuous("Year", labels = as.character(mdf$Year),
                         breaks = mdf$Year) +
      theme(axis.text.x = element_text(angle = 65))

    ggplotly(grf)
  })

# Render-viz3 -------------------------------------------------------------

  output$Viz3 <- renderPlotly({
    
    Poverty <- poverty_data %>% 
      group_by(Year, input$state_name) %>%
      mutate(Mean_AGI = as.numeric(gsub(",","", Mean.AGI)),
             Median_AGI = as.numeric(gsub(",","", Median.AGI))) %>% 
      select(Year, input$state_name, Mean_AGI, Median_AGI)
    
    
    chart3 <- ggplot(Poverty)+
      geom_point(mapping = aes(x = Mean_AGI, y = Median_AGI, color = input$state_name))+
      labs(title = "Mean and median AGI comparison between states",
           subtitle = "From 1990 - 2018",
           x = "Mean AGI",
           y = "Median AGI")
    
    print(chart3)
    
})
  palette_fn <- colorFactor(palette = "Dark2", domain = Location[["race"]])
    
    leaflet(data = race_df) %>%
      addProviderTiles("Stamen.TonerLite") %>% # add Stamen Map Tiles
      addCircleMarkers( # add markers for each shooting
        lat = ~lat,
        lng = ~long,
        label = ~paste0(year, ", ", total), # add a hover label
        color = ~palette_fn(Location[["race"]]), # color points by race
        fillOpacity = .7,
        radius = 4,
        stroke = FALSE
      ) %>%
      addLegend( # include a legend on the plot
        position = "bottomright",
        title = "race",
        pal = palette_fn, # the palette to label
        values = Location[["race"]], # again, using double-bracket notation
        opacity = 1)
  }





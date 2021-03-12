poverty_data <- read.csv('irs.csv')
race_df <- read.csv('dt.csv')
library(ggplot2)
library(plotly)
library(tidyverse)

# Viz1 --------------------------------------------------------------------

mutated_data <- poverty_data %>%
  transmute(Number_Total_exemptions = as.numeric(gsub(",","", Total.exemptions)),
         Number_Poor_exemptions = as.numeric(gsub(",","", Poor.exemptions)),
         Number_65_over_exemptions = as.numeric(gsub(",","", Age.65.and.over.poor.exemptions)),
         Number_65_under_exemptions = as.numeric(gsub(",","", Poor.exemptions.under.age.65)),
         Number_Poor_Child_exemptions = as.numeric(gsub(",","", Poor.child.exemptions)),
         Year = Year,
         State = Name) %>%
  select(State, Year, Number_Total_exemptions, Number_Poor_exemptions,
         Number_65_over_exemptions, Number_65_under_exemptions,
         Number_Poor_Child_exemptions)

# Filter for avg exemptions each year
Avg_exemptions <- mutated_data %>%
  group_by(Year) %>%
  summarise(Number_Total_exemptions = mean(sum(Number_Total_exemptions)),
            Number_Poor_exemptions = mean(sum(Number_Poor_exemptions)),
            Number_65_over_exemptions = mean(sum(Number_65_over_exemptions)),
            Number_65_under_exemptions = mean(sum(Number_65_under_exemptions)),
            Number_Poor_Child_exemptions = mean(sum(Number_Poor_Child_exemptions))) %>% 
  select(Year, Number_Total_exemptions, Number_Poor_exemptions, Number_65_over_exemptions,
         Number_65_under_exemptions, Number_Poor_Child_exemptions)


# Viz2 --------------------------------------------------------------------

race_mcol <- race_df %>%
  rename(American.Indian_Alaska.Native = American.IndiaNAlaska.Native, Multiple.Races,
         Asian_Native.Hawaiian.and.Pacific.Islander = Asian.Native.Hawaiian.and.Pacific.Islander,
         White = White, Black = Black, Hispanic = Hispanic, Multiple.Races = Multiple.Races,
         Year = Year, Location = Location, Total = Total)

# Render-server -----------------------------------------------------------


server <- function(input, output){

# Render-viz1 -------------------------------------------------------------

  output$Viz1 <- renderPlotly({

    filtered_data <- Avg_exemptions %>%
      filter(Year >= "1989" & Year <= "2018")
      # filter(State == input$state)

    plot1 <- ggplot(data = filtered_data)+
      geom_line(mapping = aes_string(x = "Year", y = input$exemptype))

    ggplotly(plot1)
       })

# Render-viz2 -------------------------------------------------------------
  # x-axis: year
  
  # y-axis: race
  # option: state
  
  output$Viz2 <- renderPlotly({
    mdf <- race_mcol %>% 
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
  
}

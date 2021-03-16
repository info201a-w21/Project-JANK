poverty_data <- read.csv('irs.csv')
race_df <- read.csv('dt.csv')
library(ggplot2)
library(plotly)
library(tidyverse)
library(scales)
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

# Render-viz2 -------------------------------------------------------------e
  
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
  
}

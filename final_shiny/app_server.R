poverty_data <- read.csv('irs.csv')
race_df <- read.csv('dt.csv')

# Viz1 --------------------------------------------------------------------

mutated_data <- poverty_data %>% 
  transmute(Number_Total_exemptions = as.numeric(gsub(",","", Total.exemptions)),
         Number_Poor_exemptions = as.numeric(gsub(",","", Poor.exemptions)),
         Number_65_over_exemptions = as.numeric(gsub(",","", Age.65.and.over.poor.exemptions)),
         Number_65_under_exemptions = as.numeric(gsub(",","", Poor.exemptions.under.age.65)),
         Number_Poor_Child_exemptions = as.numeric(gsub(",","", Poor.child.exemptions)),
         Year = as.numeric(Year), 
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
            Number_Poor_Child_exemptions = mean(sum(Number_Poor_Child_exemptions)))
 

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
  
  output$Viz2 <- renderPlot({
    mdf <- race_df %>% 
      filter(Location == "California") %>% 
      select(Year, Black)
    
    grf <- ggplot(mdf) +
      geom_col(mapping = aes(x = Year, y = Black)) +
      labs(x = "Year", y = "black poverty count",
           title = "Poverty count by race") 
    return(grf)
  })
  
}

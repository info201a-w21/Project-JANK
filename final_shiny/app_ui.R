
poverty_data <- read.csv('irs.csv')
race_df <- read.csv('dt.csv')
# Intro-page --------------------------------------------------------------
intro_page <- tabPanel(
  "Introduction"
)


# Viz1 --------------------------------------------------------------------

filtered_states <- unique(mutated_data$State)

years <- c(min(mutated_data$Year),
           max(mutated_data$Year))

viz_one <- tabPanel(
  "Visualization 1",
  titlePanel("Trend In Exemptions Over Time"),
  sidebarLayout(
    sidebarPanel(
      # selectInput(inputId = "state", label = "Select State",
      #             choices = filtered_states, selected = "Washington"),

      radioButtons(inputId = "exemptype", label = ("Choose Exemption To View"),
                   choices = list("Total Exemptions" = "Total_exemptions", 
                                  "Poor Exemptions" = "Poor_exemptions",
                                  "Over 65yrs Poor Exemptions" = "Poor_Exemptions_Over_Age65",
                                  "Under 65yrs Poor Exemptions" = "Poor_Exemptions_Under_Age65",
                                  "Poor Child Exemptions" = "Poor_Child_exemptions"),
                   selected = "Poor_exemptions"),
      
      sliderInput(inputId = "year", label = "Year Range", min = years[1], max = years[2],
                  value = years, sep = "")),

    mainPanel(
      plotlyOutput(outputId = "Viz1"),
      p("")
    )
))


# Viz2 --------------------------------------------------------------------
race_col <- race_df %>% 
  select(White, Black, Hispanic, Asian.Native.Hawaiian.and.Pacific.Islander, 
         American.IndiaNAlaska.Native, Multiple.Races) %>% 
  rename(American.Indian_Alaska.Native = American.IndiaNAlaska.Native, Multiple.Races, 
         Asian_Native.Hawaiian.and.Pacific.Islander = Asian.Native.Hawaiian.and.Pacific.Islander,
         White = White, Black = Black, Hispanic = Hispanic, Multiple.Races = Multiple.Races)
states <- unique(race_df$Location)

viz_two <- tabPanel(
  "Visualization 2",
  
  y_input <- selectInput(
    inputId = "race_var",
    choices = colnames(race_col),            
    label = "Select a Race"
  ),
  state_input <- selectInput(
    inputId = "state_var",
    choices = states,            
    label = "Select a State Or Territory"
  ),
  titlePanel("Exam Poverty Count by Race Over the Course of 10 Years"),
  plotlyOutput("Viz2")
  
)
# x-axis: year
# y-axis: race
# option: state

# UI ----------------------------------------------------------------------



ui <- fluidPage(theme = shinytheme("darkly"),
                navbarPage("Poverty and Income Inequality",
                           intro_page,
                           viz_one,
                           viz_two#,
                           # viz_three,
                           # conclusion_page
                           )

                )

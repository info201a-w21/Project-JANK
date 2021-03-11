
# Intro-page --------------------------------------------------------------


intro_page <- tabPanel(
  "Introduction"
)


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

filtered_states <- unique(mutated_data$State)

viz_one <- tabPanel(
  "Visualization 1",
  titlePanel("Trend In Exemptions Over Time"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "state", label = "Select State",
                  choices = filtered_states, selected = "Washington"),
      
      radioButtons(inputId = "exemptype", label = ("Choose Exemption To View"),
                   choices = list("Number_Total_exemptions", "Number_Poor_exemptions","Number_65_over_exemptions",
                                  "Number_65_under_exemptions","Number_Poor_Child_exemptions"),
                   selected = "Number_Poor_Child_exemptions")),

    mainPanel(
      plotlyOutput(outputId = "Viz1")
    )
))

# Viz2 --------------------------------------------------------------------

viz_two <- tabPanel(
  "Visualization 2",
  titlePanel("What's up Dawg"),
  plotOutput("Viz2")
)


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

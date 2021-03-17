
poverty_data <- read.csv('irs.csv')
race_df <- read.csv('dt.csv')
# Intro-page --------------------------------------------------------------
intro_page <- tabPanel(
  "Introduction",

  titlePanel("Our Purpose"),
  p(" One of the biggest problems in society today and as well as the past has
  been",strong("poverty"), ". Being in poverty means that the person is", strong("not"),
  "or", strong("barely")," able to  meet the minimum needs of basic living. In the past year,
  the coronavirus pandemic occured and has effected people of all social statuses.
  people from going to their daily job and earning money."),
  p("In this project, we wanted to analyze the current trend of poverty in the US
    by using data from the US Census focusing on", a(href = "https://www.census.gov/library/publications/2020/demo/p60-270.html", "household demographics"),
    ",", a(href = "https://www2.census.gov/programs-surveys/saipe/datasets/2019/2019-school-districts/ussd19.xls", "school district income"),
    ", and", a(href = "https://www2.census.gov/programs-surveys/demo/tables/p60/268/table1.xls", "supplemental poverty measurment"), "."),
  p("We sought to answer the following questions:"),
  tags$div(
    tags$ul(
      tags$li("How has poverty changed over the course of 10 years?"),
      tags$li("How has race played a factor in this?"),
      tags$li("How has the coronavirus increased the gap between the poor and the rich?")

    )
  ),
  img("", src = "https://ichef.bbci.co.uk/news/976/cpsprodpb/106E7/production/_114930376_hi061073153.jpg")

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
      p("In this chart you are able to filter through for the type of exemption
        and the year range you would like to view, which will display the average number
        of exemptions by type in the United States. Firsly, 'Poor Exemptions'
        indicates that a household earned less than their states federal income poverty
        level. As you may notice the number of poor exemptions gradually increases from 1990's to
        roughly 2011, where it begins to slowly decline; which may be likely due to the decrease
        in unemployment. The most drastic change in the chart you see, is the spike in poor exemptions in the year 2007, which
        is surely correlated to the financial crisis, or great recession of 2007. ")
    )
))


# Viz2 --------------------------------------------------------------------
race_col <- race_df %>%
  select(White, Black, Hispanic, Asian.Native.Hawaiian.and.Pacific.Islander,
         American.IndiaNAlaska.Native, Multiple.Races)
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

# Viz3 --------------------------------------------------------------------


viz_three <- tabPanel(
  "Visualization 3",
  titlePanel("Comparison of Mean and Median AGI in Two States"),
  
  y_input <- selectInput(
    inputId = "state_name",
    choices = states,
    label = "Select a State"
  ),
  
  y_input <- selectInput(
    inputId = "state_name",
    choices = states,
    label = "Select another State to compare"
  ),
  
  plotlyOutput("Viz3")
)




# Takeaways ----------------------------------------------------------------
  
takeaways <- tabPanel(
  "Summary",
  titlePanel("Final Takeaways"),
  p("Reflecting back to the beginning of this project, our goals was to figure out these questions:"),
  tags$div(
    tags$ul(
      tags$li("How has poverty changed over the course of 10 years?"),
      tags$li("How has race played a factor in this?"),
      tags$li("How has the coronavirus increased the gap between the poor and the rich?")
    )),
  p("From the first visualization we crafted, it showed the trend of expeptions
    over time. We specifcially wanted to understand those of the poor community.
    From that graph, we can tell that there has actually been a steady decrease
    in poor expemtions since around 2012. Because of this, we can safely assume
    that more and more people are able to pay off their own taxes. This answers our first question."),
  p("From the second visualization, it showed the exam poverty rate by race in the past 10 years.
    Since our second question is race-related, we wanted to specifically see the 
    data of each race to get a clear view of any patterns. From the visual, if we center on California state,
    we can see that people of Hispanic decent were more likely to fit in the poverty category in comparison
    to those of white decent. If we look at 2013 where there is the most poverty 
    records from the white community, there are 1,551,800 reports. When looking at
    the same year but for those in the hispanic community, there are 3,340,400 reports.
    That is almost 2.2 times more than people of white decent. However, both races 
    are slowly declining which is a good sign."),
  p("Lastly, the third visualization shows the effect of the coronavirus on the
    social gap between the rich and the poor. It is widely known that the coronavirus
    had an impact on all social classes, but we didn't know the real effects on
    the gap which led us to create this visual. From the graph, we can see that ______"),
  p("All in all, poverty is still a very big issue in the US as well as other countries 
    around the world. It is a good sign to see it decreasing and hopefully it will 
    continue to decline."))


# UI ----------------------------------------------------------------------

ui <- fluidPage(theme = shinytheme("darkly"),
                navbarPage("Poverty and Income Inequality",
                           intro_page,
                           viz_one,
                           viz_two,
                           viz_three,
                           takeaways
                           )

                )


intro_page <- tabPanel(
  "Introduction"
)

viz_one <- tabPanel(
  "Visualization 1",
  titlePanel("gfgf")
)


ui <- fluidPage(theme = shinytheme("darkly"),
                navbarPage("Poverty and Income Inequality",
                           intro_page,
                           viz_one#,
                           # viz_two,
                           # viz_three,
                           # conclusion_page
                           )

                )

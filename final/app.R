library(shiny)
library(tidyverse)
library(ggplot2)
library(shinythemes)
library(plotly)

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)

#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
library(shinythemes)
library(plotly)

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)

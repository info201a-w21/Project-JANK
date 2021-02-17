poverty_data <- read.csv('covid_data_log_200922.csv')
irs_data <- read.csv("irs.csv")

# This table contains the country that has the most number of individuals
# living in poverty from each state, number of covid cases and deaths in 
# the county.

library(tidyverse)



Poverty <- Exemptions %>% 
  group_by(Year, Name) %>%
  mutate(Number_Total_exemptions = as.numeric(gsub(",","", Total.exemptions)),
         Number_Poor_exemptions = as.numeric(gsub(",","", Poor.exemptions))) %>% 
  select(Year, Name, Number_Total_exemptions, Number_Poor_exemptions)
  

  
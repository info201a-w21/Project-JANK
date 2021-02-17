library(tidyverse)

poverty_data <- read.csv('irs.csv')

year_most_poverty<- poverty_data %>% 
  group_by(Year) %>% 
  # Create a column that converts a string to numeric, replace "," with ""
  mutate(num_Total.exemptions = as.numeric(gsub(",","", Total.exemptions))) %>% 
  mutate(num_Poor.exemptions = as.numeric(gsub(",","", Poor.exemptions))) %>% 
  mutate(poverty_rate = num_Poor.exemptions/num_Total.exemptions) %>% 
  filter(poverty_rate == max(poverty_rate)) %>% 
  select(Year, Name, poverty_rate)

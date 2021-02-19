library(tidyverse)
library(dplyr)

poverty_data <- read.csv('irs.csv')

year_most_poverty<- poverty_data %>% 
  group_by(Year) %>% 
  # Create a column that converts a string to numeric, replace "," with ""
  mutate(num_Total.exemptions = as.numeric(gsub(",","", Total.exemptions))) %>% 
  mutate(num_Poor.exemptions = as.numeric(gsub(",","", Poor.exemptions))) %>% 
  mutate(percent_poverty_rate = 100 * num_Poor.exemptions/num_Total.exemptions) %>% 
  filter(percent_poverty_rate == max(percent_poverty_rate)) %>% 
  mutate_if(is.numeric, round, digits=3) %>% 
  arrange(Year) %>% 
  select(Year, Name, percent_poverty_rate)


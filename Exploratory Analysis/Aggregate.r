poverty_data <- read.csv('covid_data_log_200922.csv')

# This table contains the country that has the most number of individuals
# living in poverty from each state, number of covid cases and deaths in 
# the county.

library(tidyverse)

most_poverty_cases_deaths_log <- poverty_data %>% 
  group_by(State) %>% 
  filter(Poverty == max(Poverty, na.rm = T)) %>% 
  select(County, State, Poverty, Cases, Deaths)


  
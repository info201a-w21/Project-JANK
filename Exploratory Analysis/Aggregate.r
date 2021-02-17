<<<<<<< HEAD
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
  

  
=======
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
>>>>>>> c842fe5ad80dec93f1a3d9e99bae70f7dee2798a

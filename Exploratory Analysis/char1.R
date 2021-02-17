library(tidyverse)
poverty_data <- read.csv('irs.csv')

# find the change in number of poor exemptions in each state over year

num_poverty_data <- poverty_data %>% 
  transmute(num_poor.exemptions = as.numeric(gsub(",","", Poor.exemptions)),
            year = as.numeric(Year), state = Name) %>% 
  group_by(year) %>% 
  summarise(total_poor_exemptions = sum(num_poor.exemptions))

poor_exemption_over_year <- ggplot(num_poverty_data) +
  geom_line(mapping = aes(x = year, y = total_poor_exemptions)) +
  labs(x = "Year", y = "Number of Poor Exemtions in U.S.",
       title = "Change in Total Number of Poor Exemptions Over Time in U.S.") +
  scale_x_continuous("year", labels = as.character(num_poverty_data$year), 
                     breaks = num_poverty_data$year) +
  theme(axis.text.x = element_text(angle = 65))

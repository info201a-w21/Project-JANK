## Load Data
library(tidyverse)
irs_data <- read.csv('irs.csv') 

# Find the mean and median AGI number of the U.S. state with the most and least poverty


Poverty <- irs_data %>% 
  group_by(Year, Name) %>%
  mutate(Mean_AGI = as.numeric(gsub(",","", Mean.AGI)),
         Median_AGI = as.numeric(gsub(",","", Median.AGI))) %>% 
  select(Year, Name, Mean_AGI, Median_AGI)


compare_poverty_states <-  Poverty %>% 
  filter(Name == "Mississippi" | Name == "Connecticut")


chart3 <- ggplot(compare_poverty_states)+
  geom_point(mapping = aes(x = Mean_AGI, y = Median_AGI, color = Name))+
  labs(title = "Mean and median AGI comparison between states with most and least poverty ",
       subtitle = "From 1990 - 2018",
       x = "Mean AGI",
       y = "Median AGI")


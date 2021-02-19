library(tidyverse)

irs_data <- read.csv("irs.csv")

Poverty <- irs_data %>% 
  group_by(Year, Name) %>%
  mutate(Number_Total_exemptions = as.numeric(gsub(",","", Total.exemptions)),
         Number_Poor_exemptions = as.numeric(gsub(",","", Poor.exemptions))) %>% 
  select(Year, Name, Number_Total_exemptions, Number_Poor_exemptions)


top_5_poverty_states <-  Poverty %>% 
  filter(Name == "Mississippi" | Name == "Louisiana" | Name == "New Mexico" | 
           Name == "Kentucky" | Name == "Arkansas")


chart2 <- ggplot(data = top_5_poverty_states)+
  geom_col(mapping = aes(x = Year, y = Number_Poor_exemptions, fill = Name))+
  labs(title = "Poor Exemptions Indicating Poverty in Top 5 Poorest States ",
       subtitle = "From 1990 - 2018",
       x = "Year",
       y = "# of Poor Exemptions")+
  facet_wrap(~Name)

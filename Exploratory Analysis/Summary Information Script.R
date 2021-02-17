## Load Data
poverty.data <- read.csv('covid_data_log_200922.csv')
irs.data <- read.csv('irs.csv')

## Covert Data
most_exemption_cases_deaths <- irs.data %>% 
  group_by(Name) %>% 
  filter(Poor.exemptions == max(Poor.exemptions, na.rm = T)) %>% 
  select(Name, Year, Total.exemptions, Poor.exemptions, Mean.AGI)

## Directions:
# A file that calculates summary information to be included in your report
# (e.g nrow, ncol, max, min, avg, median, etc.)

# Max

# Min

# Avg
avg.poor.exemption <- irs.data %>% 
  group_by(Year) %>% 
  summarize(Poor.exemptions == mean(Poor.exemptions, na.rm = T))

# Median

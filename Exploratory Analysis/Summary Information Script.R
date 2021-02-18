# Load Data
irs_data <- read.csv('irs.csv')

library(tidyverse)
library(tidyr)
library(dplyr)
# Directions:
# A file that calculates summary information to be included in your report
# (e.g nrow, ncol, max, min, avg, median, etc.)

# Max
max_poor_exemption <- irs_data %>%
  transmute(num_poor.exemptions = as.numeric(gsub(",","", Poor.exemptions)),
            year = as.numeric(Year), state = Name) %>%
  group_by(year) %>%
  summarise(max_amount = max(num_poor.exemptions, na.rm = T))

# Min
min_poor_exemption <- irs_data %>%
  transmute(num_poor.exemptions = as.numeric(gsub(",","", Poor.exemptions)),
            year = as.numeric(Year), state = Name) %>%
  group_by(year) %>%
  summarise(min_amount = min(num_poor.exemptions, na.rm = T))

# Average Poor Exemption each Year
avg_poor_exemption <- irs_data %>%
  transmute(num_poor.exemptions = as.numeric(gsub(",","", Poor.exemptions)),
            year = as.numeric(Year), state = Name) %>%
  group_by(year) %>%
  summarise(average_amount = mean(num_poor.exemptions, na.rm = T))

# Average Total Exemption each Year
avg_total_exemption <- irs_data %>%
  transmute(num_total.exemptions = as.numeric(gsub(",","", Total.exemptions)),
            year = as.numeric(Year), state = Name) %>%
  group_by(year) %>%
  summarise(average_amount = mean(num_total.exemptions, na.rm = T))

# Nrow number of Years observed
avg_total_exemption$Year <- nrow(avg_total_exemption)

# Summary Paragraph

### Load Data
poverty_data <- read.csv('covid_data_log_200922.csv')
irs_data <- read.csv('irs.csv')

### Directions:
A file that calculates summary information to be included in your report (e.g nrow, ncol, max, min, avg, median, etc.)

## Max

## Min

## Average Poor Exemption Each Year
avg_poor_exemption <- irs_data %>%
  transmute(num_poor.exemptions = as.numeric(gsub(",","", Poor.exemptions)),
            year = as.numeric(Year), state = Name) %>%
  group_by(year) %>%
  summarise(average_amount = mean(num_poor.exemptions, na.rm = T))

## Average Total Exemption Each Year
avg_total_exemption <- irs_data %>%
  transmute(num_total.exemptions = as.numeric(gsub(",","", Total.exemptions)),
            year = as.numeric(Year), state = Name) %>%
  group_by(year) %>%
  summarise(average_amount = mean(num_total.exemptions, na.rm = T))

## Median

## Summary Paragraph
Based on our script, we found out that the data was taken over the course of 30 years; from 1989 to 2018. We were also curious on how the average of both the total exemption amount and specifically the poor exemption amount changed over time. Thus, we created two new tables calculating each variable for each year, and we found out that the average for both have overall increased as time went on. 

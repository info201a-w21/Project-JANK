# Load Data
poverty_data <- read.csv('covid_data_log_200922.csv')
irs_data <- read.csv('irs.csv')

# Directions:
# A file that calculates summary information to be included in your report
# (e.g nrow, ncol, max, min, avg, median, etc.)

# Max

# Min

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
irs_data$Year <- nrow(avg_total_exemption)

# Summary Paragraph

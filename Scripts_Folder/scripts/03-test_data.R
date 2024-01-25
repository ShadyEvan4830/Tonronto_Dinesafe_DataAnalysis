#### Preamble ####
# Purpose: Tests whether dataset can operate normally
# Author: Tianen (Evan) Hao
# Date: 15 January 2024
# Contact: evan4830@gmail.com
# License: MIT
# Pre-requisites: R 4.3.2


#### Test dinesafe data ####
library(tidyverse)

# Use the simulated DineSafe data set
set.seed(123)
simulated_dataset <- tibble(
  `Establishment ID` = 1:100,
  `Establishment Name` = paste("Establishment", 1:100),
  `Establishment Status` = sample(c("Pass", "Conditional Pass", "Fail"), 100, replace = TRUE),
  `Inspection Date` = sample(seq(as.Date('2021-01-01'), as.Date('2021-12-31'), by="day"), 100),
  `Infractions` = sample(0:5, 100, replace = TRUE)
)

# Test if 'Establishment Status' contains specific categories
all(c("Pass", "Conditional Pass", "Fail") %in% simulated_dataset$`Establishment Status`)

# Test the range of dates in 'Inspection Date'
simulated_dataset$`Inspection Date` |> min() >= as.Date('2021-01-01')
simulated_dataset$`Inspection Date` |> max() <= as.Date('2021-12-31')

# Test the range of values in 'Infractions'
simulated_dataset$Infractions |> min() >= 0
simulated_dataset$Infractions |> max() <= 5

# Test the class of 'Establishment ID'
simulated_dataset$`Establishment ID` |> class() == "integer"

# Some extra test
status_count <- simulated_dataset %>%
  group_by(`Establishment Status`) %>%
  summarize(Count = n())

ggplot(status_count, aes(x = `Establishment Status`, y = Count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  labs(title = "Number of Establishments by Status",
       x = "Establishment Status", y = "Count")

library(dplyr)

inspection_summary <- simulated_dataset %>%
  group_by(`Establishment Status`) %>%
  summarise(Count = n()) %>%
  mutate(Percentage = (Count / sum(Count)) * 100)

print(inspection_summary)


#### Test Toronto's Dashboard Key Indicators data set####

library(dplyr)
library(tibble)

# Use the simulated Toronto's Dashboard Key Indicators data set
set.seed(123)

cpi_data <- tibble(
  Year = 2010:2023, 
  Average_CPI = runif(length(Year), min = 0, max = 5) 
)

print(cpi_data)

# Test the range of years
cpi_data$Year |> min() == 2010
cpi_data$Year |> max() == 2023

# Test if Average_CPI values are within a specified range
cpi_data$Average_CPI |> min() >= 0
cpi_data$Average_CPI |> max() <= 5

# Test the class of Year and Average_CPI columns
cpi_data$Year |> class() == "integer"
cpi_data$Average_CPI |> class() == "numeric"

# Some extra test
library(ggplot2)

ggplot(cpi_data, aes(x = Year, y = Average_CPI)) +
  geom_line() +
  labs(title = "Annual CPI Trend", x = "Year", y = "Average CPI")

cpi_data <- cpi_data %>%
  mutate(Growth_Rate = (Average_CPI - lag(Average_CPI)) / lag(Average_CPI))

print(cpi_data)

model <- lm(Average_CPI ~ Year, data = cpi_data)
summary(model)

future_years <- tibble(Year = 2024:2030)
predictions <- predict(model, newdata = future_years)
future_cpi <- bind_cols(future_years, tibble(Average_CPI = predictions))

print(future_cpi)



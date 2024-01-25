#### Preamble ####
# Purpose: Simulates whether the code and environment can run the required graphs well
# Author: Tianen (Evan) Hao
# Date: 14 January 2024
# Contact: evan4830@gmail.com
# License: MIT
# Pre-requisites: R 4.3.2

#### Simulate data ####

# Create a simulated for Dinesafe data set
library(tidyverse)

set.seed(123)
simulated_dataset <- tibble(
  `Establishment ID` = 1:100,
  `Establishment Name` = paste("Establishment", 1:100),
  `Establishment Status` = sample(c("Pass", "Conditional Pass", "Fail"), 100, replace = TRUE),
  `Inspection Date` = sample(seq(as.Date('2021-01-01'), as.Date('2021-12-31'), by="day"), 100),
  `Infractions` = sample(0:5, 100, replace = TRUE)
)

# Create a simulated for Toronto's Dashboard Key Indicators data set
set.seed(123)

cpi_data <- tibble(
  Year = 2010:2023, 
  Average_CPI = runif(length(Year), min = 0, max = 5) 
)


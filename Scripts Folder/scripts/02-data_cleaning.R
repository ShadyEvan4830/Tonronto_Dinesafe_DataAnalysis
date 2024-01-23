#### Preamble ####
# Purpose: Clean Dinesafe and CPI datas from OpenDataToronto
# Author: Tianen (Evan) Hao
# Date: 14 January 2024
# Contact: evan4830@gmail.com
# License: MIT
# Pre-requisites: R 4.3.2

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read.csv("/cloud/project/Inputs Folder/Data/raw_data.csv")

cleaned_data <- dataset %>%
  filter(!is.na(`Establishment Name`)) %>%
  mutate(new_column = tolower(`Establishment Name`))

#### Save data ####
write.csv(dataset, "/cloud/project/Inputs Folder/Data/Clean_Dinesafe_Data.csv")

#### Clean data ####
raw_data2 <- read.csv("/cloud/project/Inputs Folder/Data/raw_data2.csv")

cpi_data <- filter(data, measure_name == "CPI - Consumer Price Index - Toronto (% Change)")

cpi_data_renamed <- rename(cpi_data, CPI = measure_value)

#### Save data ####
write.csv(cpi_data, "/cloud/project/Inputs Folder/Data/Clean_CPI_Data.csv")

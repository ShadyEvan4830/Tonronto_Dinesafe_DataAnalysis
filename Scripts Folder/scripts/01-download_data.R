#### Preamble ####
# Purpose: Download and read Dinesafe and CPI datas from OpenDataToronto
# Author: Tianen (Evan) Hao
# Date: 14 January 2024
# Contact: evan4830@gmail.com
# License: MIT
# Pre-requisites: R 4.3.2

library(opendatatoronto)

#### Download data ####
# get package
package <- show_package("ea1d6e57-87af-4e23-b722-6c1f5aa18a8d")
package

# get all resources for this package
resources <- list_package_resources("ea1d6e57-87af-4e23-b722-6c1f5aa18a8d")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
dataset <- filter(datastore_resources, row_number()==1) %>% get_resource()

#### Save data ####
write.csv(dataset, "raw_data.csv") 

#### Download data 2####

# Get package
package <- show_package("c6d64e9b-f85a-4084-be14-60cf18509203")
# It's a good practice to check the package details, but you can also comment it out if not needed
# package

# Get all resources for this package
resources <- list_package_resources("c6d64e9b-f85a-4084-be14-60cf18509203")

# Identify datastore resources; Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Load the first datastore resource as a sample
# Using `slice()` instead of `filter()` to select the first resource
data <- slice(datastore_resources, 1) %>% get_resource()

# View the first few rows of the dataset
head(data)
         
#### Save data 2####
write.csv(cpi_data, "raw_data2.csv") 

#### Preamble ####
# Purpose: Simulates a dataset of Adjustment Applications Committee.
# Author: Angel Xu
# Date: 22 November 2024
# Contact: anjojoo.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(1212)


#### Simulate data ####
# District names
planning_district <- c(
  "North York",
  "Toronto East York",
  "Etobicoke York",
  "Scarborough"
)

# Application types
application_type <- c("MV", "CO")

# Decision types
decision <- c("Approval", "Refused")

# Set a date range
start_date <- as.Date("2013-01-01")
end_date <- as.Date("2023-12-31")

# Create a dataset by randomly assigning states and parties to divisions
simulated_data <- tibble(
  application_type = sample(
    application_type,
    size = 500,
    replace = TRUE,
    prob = c(0.3, 0.7) # Rough distribution
  ), 
  dates = as.Date(sample(seq(start_date, end_date, by = "day"), 500, replace = TRUE)), 
  planning_district = sample(
    planning_district,
    size = 500,
    replace = TRUE,
    prob = c(0.40, 0.40, 0.15, 0.05) # Rough distribution
  ), 
  decision = sample(
    decision,
    size = 500,
    replace = TRUE,
    prob = c(0.6, 0.4) # Rough distribution
  )
)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")


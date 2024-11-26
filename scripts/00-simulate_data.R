#### Preamble ####
# Purpose: Simulates a dataset of Adjustment Applications Committee.
# Author: Angel Xu
# Date: 22 November 2024
# Contact: anjojoo.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse`, `arrow`, `lintr`, `styler`, `here` packages
# must be installed and loaded.
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(lintr)
library(styler)
library(here)
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
start_date <- as.Date("2011-02-23")
end_date <- as.Date("2024-10-22")

# Create a dataset by randomly assigning states and parties to divisions
simulated_data <- tibble(
  application_type = sample(
    application_type,
    size = 500,
    replace = TRUE,
    prob = c(0.3, 0.7) # Rough distribution
  ),
  date = as.Date(sample(seq(start_date, end_date, by = "day"), 500,
    replace = TRUE
  )),
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
write_parquet(simulated_data, "data/00-simulated_data/simulated_data.parquet")


#### Lint and style the code ####
lint(filename = here("scripts/00-simulate_data.R"))
style_file(path = here("scripts/00-simulate_data.R"))


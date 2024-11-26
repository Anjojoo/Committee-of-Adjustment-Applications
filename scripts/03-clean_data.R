#### Preamble ####
# Purpose: Cleans the raw plane data
# Author: Angel Xu
# Date: 22 November 2024
# Contact: anjojoo.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)

#### Clean data ####
# Read the raw data
raw_data <- read_csv("data/01-raw_data/active_applications.csv")

# Convert 'IN_DATE' to Date format
raw_data$IN_DATE <- as.Date(raw_data$IN_DATE, format = "%Y-%m-%d")

# Clean, mutate and select wanted columns
cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(application_type, in_date, planning_district, c_of_a_descision) |>
  filter(grepl("approved|refused|approval", c_of_a_descision, ignore.case = TRUE)) |> 
  mutate(c_of_a_descision = ifelse(
    grepl("approved|approval", c_of_a_descision, ignore.case = TRUE),
    "Approval",
    "Refused"
  )) |> 
  rename(date = in_date,
         decision = c_of_a_descision
         ) |> 
  tidyr::drop_na()

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")

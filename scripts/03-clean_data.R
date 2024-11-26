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
library(lintr)
library(styler)
library(here)

#### Clean data ####
# Read the raw data
raw_data <- read_csv("data/01-raw_data/active_applications.csv")

# Convert 'IN_DATE' to Date format
raw_data$IN_DATE <- as.Date(raw_data$IN_DATE, format = "%Y-%m-%d")

# Clean, mutate and select wanted columns
cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  filter(grepl("approved|refused|approval", c_of_a_descision,
    ignore.case = TRUE
  )) |>
  mutate(
    c_of_a_descision = ifelse(grepl("approved|approval",
      c_of_a_descision,
      ignore.case = TRUE
    ),
    1, 0
    ),
    year = year(in_date)
  ) |>
  filter(year >= 2016) |>
  rename(decision = c_of_a_descision) |>
  select(application_type, year, planning_district, decision) |>
  tidyr::drop_na()

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")


#### Lint and style the code ####
lint(filename = here("scripts/03-clean_data.R"))
style_file(path = here("scripts/03-clean_data.R"))

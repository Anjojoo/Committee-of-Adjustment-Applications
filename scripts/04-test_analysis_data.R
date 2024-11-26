#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned Adjusted
# Application Committee dataset.
# Author: Angel Xu
# Date: 22 November 2024
# Contact: anjojoo.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `The `tidyverse`, `arrow`, `lintr`, `styler`, `here` packages
# must be installed and loaded.
# - 02-download_data.R and 03-clean_data.R must have been run
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(lintr)
library(styler)
library(here)

analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")


#### Test data ####

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}


# Check whether all required columns are present
check_required_columns <- function(data, required_columns) {
  if (!all(required_columns %in% colnames(data))) {
    stop("Error: Some required columns are missing.")
  } else {
    message("Check passed: All required columns are present.")
  }
}

# Check if each column has the correct data type
check_column_types <- function(data) {
  if (!is.Date(as.Date(data$date))) stop("Error: 'date' column must be in Date format.")
  if (!is.character(data$application_type)) stop("Error: 'application_type' column must be character.")
  if (!is.character(data$planning_district)) stop("Error: 'planning_district' column must be character.")
  if (!is.numeric(data$decision)) stop("Error: 'decision' column must be character.")
  message("Check passed: All columns have the correct format.")
}

# Test if all 'date' values are between Feb 23, 2011, and Oct 22, 2024
check_date_range <- function(data) {
  if (!all(as.Date(data$date) >= as.Date("2011-02-23") & as.Date(data$date) <= as.Date("2024-10-22"))) {
    stop("Error: 'date' column contains values outside the valid range (2011-02-23 to 20234-10-22).")
  } else {
    message("Check passed: All 'date' values are within the proper range.")
  }
}

# Test if 'application_type' values are within the provided application types
check_application_types <- function(data) {
  valid_types <- c("MV", "CO")
  if (!all(data$application_type %in% valid_types)) {
    stop("Error: Invalid 'application_type' values found.")
  } else {
    message("Check passed: All 'application_type' values are valid.")
  }
}

# Test if 'planning_district' values are within the district list
check_planning_districts <- function(data) {
  valid_districts <- c("Etobicoke York", "North York", "Scarborough",
                       "Toronto East York")
  if (!all(data$planning_district %in% valid_districts)) {
    stop("Error: Invalid 'planning_district' values found.")
  } else {
    message("Check passed: All 'planning_district' values are valid.")
  }
}

# Test if 'decision' values are within the result list
check_decision_values <- function(data) {
  valid_decisions <- c(1, 0)
  if (!all(data$decision %in% valid_decisions)) {
    stop("Error: Invalid 'decision' values found.")
  } else {
    message("Check passed: All 'decision' values are valid.")
  }
}

# Run all checks
required_columns <- c("application_type", "date", "planning_district", "decision")
check_required_columns(analysis_data, required_columns)
check_column_types(analysis_data)
check_date_range(analysis_data)
check_application_types(analysis_data)
check_planning_districts(analysis_data)
check_decision_values(analysis_data)


# If the script gets to this point without stopping, all tests passed
print("All tests passed!")


#### Lint and style the code ####
lint(filename = here("scripts/04-test_analysis_data.R"))
style_file(path = here("scripts/04-test_analysis_data.R"))

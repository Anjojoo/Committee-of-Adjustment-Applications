#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(lintr)
library(styler)
library(here)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


# Ensure categorical variables are treated as factors
analysis_data <- analysis_data %>%
  mutate(
    application_type = as.factor(application_type),
    planning_district = as.factor(planning_district)
  )

#### Model data ####
first_model <- 
  stan_glm(
    formula = decision ~ application_type + date + planning_district,
    data = analysis_data,
    family = binomial(link = "logit"), # Logistic regression
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


#### Lint and style the code ####
lint(filename = here("scripts/00-simulate_data.R"))
style_file(path = here("scripts/00-simulate_data.R"))

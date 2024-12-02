#### Preamble ####
# Purpose: Bayesian Logisitic Regression Model
# Author: Angel Xu
# Date: 23 November 2024
# Contact: anjojoo.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-dowload_data.R and 03-clean_data.R to get the dataset
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(lintr)
library(styler)
library(here)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")


# Ensure categorical variables are treated as factors
analysis_data <- analysis_data %>%
  mutate(
    application_type = as.factor(application_type),
    year = as.factor(year),
    planning_district = as.factor(planning_district)
  )

#### Model data ####
first_model <-
  stan_glm(
    formula = decision ~ application_type + year + planning_district,
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
lint(filename = here("scripts/05-model_data.R"))
style_file(path = here("scripts/05-model_data.R"))

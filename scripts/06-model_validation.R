#### Preamble ####
# Purpose: Bayesian Logisitic Regression Model Validation
# Author: Angel Xu
# Date: 30 November 2024
# Contact: anjojoo.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-dowload_data.R, 03-clean_data.R, and 05-model_data
# to get the dataset and the model
# Any other information needed? None


#### Workspace setup ####
set.seed(853)
library(dplyr)
library(arrow)
library(rstanarm)
library(lintr)
library(styler)
library(here)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")


#### 80% of the sample size
size <- floor(0.8 * nrow(analysis_data))

# Split data into training and test sets
train_index <- sample(seq_len(nrow(analysis_data)), size = size)
train_data <- analysis_data[train_index, ]
test_data <- analysis_data[-train_index, ]

# Fit Bayesian logistic model on the training set
model_train <- stan_glm(
  formula = decision ~ application_type + year + planning_district,
  data = train_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5),
  prior_intercept = normal(location = 0, scale = 2.5),
  seed = 853
)

# Predict on the test set
predicted_probs <- posterior_epred(model_train, newdata = test_data)
predicted_class <- ifelse(rowMeans(predicted_probs) > 0.5, 1, 0)

# Calculate classification accuracy
accuracy_train <- mean(predicted_class == train_data$decision)
accuracy_test <- mean(predicted_class == test_data$decision)
accuracy_train
accuracy_test

# Save accuracy_train and accuracy_test to an RDS file
saveRDS(list(accuracy_train = accuracy_train, accuracy_test = accuracy_test),
  file = "models/accuracy_results.rds"
)

#### Lint and style the code ####
lint(filename = here("scripts/06-model_validation.R"))
style_file(path = here("scripts/06-model_validation.R"))

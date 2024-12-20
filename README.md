# Toronto's Committee of Adjustment Application Approval

## Overview

This project analyzes the determinants of application approval within Toronto's Committee of Adjustment using a Bayesian logistic regression model. The study explores how factors such as application type, submission year, and planning district influence the likelihood of approval.


## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains the raw data as obtained from Open Data Toronto.
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models, and model validation accuracy. 
-   `other` contains datasheet, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean, and test data, as well as build and validate model.


## Statement on LLM usage

ChatGPT 4o mini was used to provide assistance on coding, resolving issues occurring in the process of constructing models, and on interpreting and evaluating models. Entire chat history is available in `other/llm_usage/usage.txt`.


#' Estimate causal effect of a single variable using the backdoor criterion
#'
#' @param data A data frame containing the variables of interest
#' @param x The name of the treatment variable
#' @param y The name of the outcome variable
#' @param confounders A vector of names of confounding variables
#' @param binary_vars A vector of names of binary variables
#' @return An estimate of the causal effect of x on y
#'
estimate_causal_effect <- function(data, x, y, confounders, binary_vars) {
  # Check if x and y are in data
  if (!(x %in% colnames(data)) || !(y %in% colnames(data))) {
    stop("x and y must be column names in data")
  }

  # Check if confounders are in data
  if (!all(confounders %in% colnames(data))) {
    stop("confounders must be column names in data")
  }

  # Check if binary_vars are in data
  if (!all(binary_vars %in% colnames(data))) {
    stop("binary_vars must be column names in data")
  }

  # Get the subset of data with the relevant columns
  cols <- c(x, y, confounders, binary_vars)
  data_subset <- data[, cols]

  # Check if treatment is binary or continuous
  if (x %in% binary_vars) {
    # For binary treatment variables, estimate the average causal effect using logistic regression
    model <- glm(formula = paste(y, "~", x, "+", paste(confounders, collapse = "+")), data = data_subset, family = binomial())
    exp(model$coefficients[2]) # Return the exponentiated coefficient of the treatment variable
  } else {
    # For continuous treatment variables, estimate the average causal effect using linear regression
    model <- lm(formula = paste(y, "~", x, "+", paste(confounders, collapse = "+")), data = data_subset)
    model$coefficients[2] # Return the coefficient of the treatment variable
  }
}

#' Estimate causal effects of multiple variables using the backdoor criterion
#'
#' @param data A data frame containing the variables of interest
#' @param treatments A vector of names of the treatment variables
#' @param outcome The name of the outcome variable
#' @param confounders A vector of names of confounding variables
#' @param binary_vars A vector of names of binary variables
#' @return A list of estimates of the causal effects of each treatment variable on the outcome
#'

estimate_causal_effects <- function(dataset, treatment_var, outcome_var, alpha = 0.05) {

  # Find treatment variable index
  treat_var_index <- which(colnames(dataset) == treatment_var)

  # Find outcome variable index
  outcome_var_index <- which(colnames(dataset) == outcome_var)

  # Separate data into treatment and control groups
  treatment_group <- dataset[which(dataset[, treat_var_index] == 1), ]
  control_group <- dataset[which(dataset[, treat_var_index] == 0), ]

  # Compute means of outcome variable for each group
  treatment_mean <- mean(treatment_group[, outcome_var_index])
  control_mean <- mean(control_group[, outcome_var_index])

  # Compute difference in means
  mean_diff <- treatment_mean - control_mean

  # Compute standard error
  n_treat <- nrow(treatment_group)
  n_control <- nrow(control_group)
  treat_var_sd <- sd(treatment_group[, outcome_var_index])
  control_var_sd <- sd(control_group[, outcome_var_index])
  std_error <- sqrt((treat_var_sd^2/n_treat) + (control_var_sd^2/n_control))

  # Compute t-value
  t_value <- mean_diff/std_error

  # Compute degrees of freedom
  df <- n_treat + n_control - 2

  # Compute p-value
  p_value <- 2 * pt(-abs(t_value), df)

  # Compute confidence interval
  conf_int <- mean_diff + c(-1, 1) * qt(1 - alpha/2, df) * std_error

  # Construct result dataframe
  result <- data.frame(treatment_var = treatment_var,
                       outcome_var = outcome_var,
                       estimate = mean_diff,
                       std_error = std_error,
                       t_value = t_value,
                       df = df,
                       p_value = p_value,
                       lower_ci = conf_int[1],
                       upper_ci = conf_int[2])

  return(result)
}




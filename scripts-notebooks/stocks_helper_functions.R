predict_val <- function(data, x_val) {
    
  clean_data <- data |>
    setNames(c("x", "y")) |>
    dplyr::filter(!is.na(x) & !is.na(y))
    
  model <- lm(y ~ x, data = clean_data)
  predict(model, newdata = data.frame(x = x_val))
}



impute_regression <- function(df, y_var, x_var) {

  # Check enough complete cases for regression
  complete_cases <- complete.cases(df[[y_var]], df[[x_var]])
  if (sum(complete_cases) < 2) {
    return(df[[y_var]])  # Not enough data, return original vector
  }
  
  # Fit regression on complete cases
  model <- lm(stats::as.formula(paste(y_var, "~", x_var)), data = df[complete_cases, ])
  
  # Predict missing values
  missing_idx <- which(is.na(df[[y_var]]) & !is.na(df[[x_var]]))
  if (length(missing_idx) > 0) {
    preds <- predict(model, newdata = df[missing_idx, , drop = FALSE])
    df[[y_var]][missing_idx] <- preds
  }
  
  return(df[[y_var]])
}



interpolate_slice <- function(data, x_val) {
    
  # Return NA if x_val is NA
  if (is.na(x_val)) return(NA_real_)

  # Rename columns to standard names (assumes only two columns: x and y)
  clean_data <- data %>%
    setNames(c("x", "y")) %>%
    filter(!is.na(x) & !is.na(y))

  if (nrow(clean_data) == 0) return(NA_real_)

  if (x_val > max(clean_data$x, na.rm = TRUE)) {
    return(NA_real_)
  }

  model <- lm(y ~ x, data = clean_data)

  predict(model, newdata = data.frame(x = x_val))
}


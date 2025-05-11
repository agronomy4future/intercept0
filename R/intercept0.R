#' Linear Model with Intercept forced to 0
#'
#' Fits a linear model with the intercept term removed, calculates the corrected R²,
#' and attaches it to the model. This function allows for custom summary output.
#'
#' @param formula A formula object specifying the model to be fitted.
#'               The formula should be in the form `response ~ predictors`.
#' @param data A data frame containing the variables in the formula.
#'
#' @returns An object of class `force_intercept_model` (inherits from `lm`),
#'          containing the fitted model and the corrected R² value.
#'          The corrected R² is a measure of the goodness-of-fit adjusted for
#'          the removal of the intercept.
#' @export
#'
#' @examples
#' x=c(19.5,40.8,45.2,55.3,24.9,49,50,29.7,32.3,42.6,54.2,52.9,64.3,53.6,34.1,18.1,66.7,57.2,37.1,58.1,67.2,53.5,63,42.1,34.9,71.3,23)
#' y=c(20.41,37.43,36.57,50.34,23.07,44.98,44.35,29.27,28.10,40.89,52.16,49.04,61.57,52.3,40.86,23.18,60.13,51.02,35.37,54.46,59.88,45.96,53.9,39.33,34.58,61.35,25.37)
#' df= data.frame (x,y)
#'
#' if(!require(remotes)) install.packages("remotes")
#' if (!requireNamespace("intercept0", quietly = TRUE)) {
#'      remotes::install_github("agronomy4future/intercept0")
#' }
#' library(remotes)
#' library(intercept0)
#'
#' model= intercept0(y~x,data=df)
#' summary(model)
intercept0 = function(formula, data) {
  # Fit model with intercept removed
  model = lm(update(formula, . ~ . - 1), data = data)

  # Get response variable and calculate corrected R²
  response_var = all.vars(formula)[1]
  y = model$model[[response_var]]  # Use data actually used in model
  y_pred = predict(model)

  sse = sum((y - y_pred)^2)
  sst = sum((y - mean(y))^2)
  corrected_r2 = 1 - (sse / sst)

  # Attach corrected R² and custom class
  model$corrected_r2 = corrected_r2
  class(model) = c("force_intercept_model", "lm")

  return(model)
}

#' Custom Summary for force_intercept_model
#'
#' Custom summary method for objects of class `force_intercept_model`. It prints
#' the regular linear model summary, along with the corrected R² value.
#'
#' @param object An object of class `force_intercept_model` (inherits from `lm`).
#' @param ... Additional arguments passed to the `summary.lm` method.
#'
#' @returns The summary object of class `summary.lm` and prints the corrected R² value.
#' @export
#'
#' @examples
#' x=c(19.5,40.8,45.2,55.3,24.9,49,50,29.7,32.3,42.6,54.2,52.9,64.3,53.6,34.1,18.1,66.7,57.2,37.1,58.1,67.2,53.5,63,42.1,34.9,71.3,23)
#' y=c(20.41,37.43,36.57,50.34,23.07,44.98,44.35,29.27,28.10,40.89,52.16,49.04,61.57,52.3,40.86,23.18,60.13,51.02,35.37,54.46,59.88,45.96,53.9,39.33,34.58,61.35,25.37)
#' df= data.frame (x,y)
#'
#' if(!require(remotes)) install.packages("remotes")
#' if (!requireNamespace("intercept0", quietly = TRUE)) {
#'      remotes::install_github("agronomy4future/intercept0")
#' }
#' library(remotes)
#' library(intercept0)
#'
#' model= intercept0(y~x,data=df)
#' summary(model)
summary.force_intercept_model= function(object, ...) {
  result= summary.lm(object, ...)
  print(result)
  cat("[1] Corrected R-squared:", round(object$corrected_r2, 7), "\n")
  invisible(result)
}

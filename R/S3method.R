################################################################################
### File: S3method.R
### Description: S3 generic functions to handle vectors and data.frames / formula objects
###              for psrank and hettmansperger_norton_test
###
################################################################################


#' Calculation of Pseudo-Ranks
#'
#' @description Calculation of (mid) pseudo-ranks of a sample. In case of ties (i.e. equal values), the average of min pseudo-rank and max-pseudor-rank are taken (similar to rank with ties.method="average").
#' @param data numerical vector or data.frame
#' @param group vector coding for the groups
#' @param formula formula object
#' @param ... further arguments
#' @return Returns a numerical vector containing the pseudo-ranks
#' @rdname psrank
#' @example R/example_1.txt
#' @keywords export
psrank <- function(data, ...){
  UseMethod("psrank")
}

#' @method psrank numeric
#' @rdname psrank
#' @keywords export
psrank.numeric <- function(data, group, ...){
  recursiveCalculation(data, group)
}

#' @method psrank formula
#' @rdname psrank
#' @keywords export
psrank.formula <- function(formula, data, ...){
  df <- model.frame(formula, data)
  recursiveCalculation(df[, 1], df[, 2])
}


#' Hettmansperger-Norton Trend Test for k-Samples
#'
#' @description This function calculates the Hettmansperger-Norton trend test using pseudo-ranks under the null hypothesis H0F: F_1 = ... F_k = 0.
#' @rdname hettmansperger_norton_test
#' @param data numeric vector containing the data or a data.frame
#' @param group ordered factor vector for the groups
#' @param alternative either decreasing (trend k, k-1, ..., 1) or increasing (1, 2, ..., k) or custom (then argument trend must be used)
#' @param formula formula object
#' @param trend custom numeric vector indicating the trend for the custom alternative, only used if alternative = "custom"
#' @param ... further arguments are ignored
#' @return Returns an object.
#' @example R/example_2.txt
#' @references Brunner, E., Bathke A. C. and Konietschke, F. Rank- and Pseudo-Rank Procedures in Factorial Designs - Using R and SAS. Springer Verlag. to appear.
#' @references Hettmansperger, T. P., & Norton, R. M. (1987). Tests for patterned alternatives in k-sample problems. Journal of the American Statistical Association, 82(397), 292-299
#' @keywords export
hettmansperger_norton_test <- function(data, ...) {
  UseMethod("hettmansperger_norton_test")
}

#' @method hettmansperger_norton_test numeric
#' @rdname hettmansperger_norton_test
#' @keywords export
hettmansperger_norton_test.numeric <- function(data, group, alternative = c("decreasing", "increasing", "custom"), trend = NULL, ...) {
  return(hettmansperger_norton_test_internal(data, group, alternative = alternative, formula = NULL, trend = trend, ...))
}

#' @method hettmansperger_norton_test formula
#' @rdname hettmansperger_norton_test
#' @keywords export
hettmansperger_norton_test.formula <- function(formula, data, alternative = c("decreasing", "increasing", "custom"), trend = NULL, ...) {
  model <- model.frame(formula, data = data)
  colnames(model) <- c("data", "group")
  return(hettmansperger_norton_test_internal(model$data, model$group, alternative = alternative, formula = formula, trend = trend, ...))
}
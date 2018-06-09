################################################################################
### File: S3method.R
### Description: S3 generic functions to handle vectors and data.frames
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
#' @seealso \code{\link{rank}}.
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
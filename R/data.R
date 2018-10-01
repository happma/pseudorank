################################################################################
### File: data.R
### Description: data object
###
################################################################################

#' Artifical data of 54 subjects
#'
#' An artificial dataset containing data of 54 subjects where where a substance was administered in three different concentrations (1,2 and 3).
#' This data set can be used to show the paradoxical results obtained from rank tests, i.e., the Hettmansperger-Norton test.
#'
#' The columns are as follows:
#' \itemize{
#'   \item conc. Grouping variable specifying which concentration was used. This factor is ordered, i.e., 1 < 2 < 3.
#'   \item score. The response variable.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ParadoxicalRanks
#' @usage data(ParadoxicalRanks)
#' @format A data frame with 54 rows and 2 variables.
#' @example R/example_paradoxical_results.txt
"ParadoxicalRanks"
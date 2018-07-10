################################################################################
### File: pseudoranks.R
### Description: Function to calculate mid-pseudo-ranks
###
################################################################################


#' Calculation of Pseudo-Ranks
#'
#' @description Calculation of (mid) pseudo-ranks of a sample. In case of ties (i.e. equal values), the average of min pseudo-rank and max-pseudor-rank are taken (similar to rank with ties.method="average").
#' @param data numerical vector
#' @param group vector coding for the groups
#' @return Returns a numerical vector containing the pseudo-ranks
#' @keywords internal
recursiveCalculation <- function(data, group) {

  stopifnot(is.numeric(data), is.factor(group))
  n <- table(group)
  
  # balanced group sizes
  if( identical(n,rep(n[1],length(n)))  ) {
    return(rank(data, ties.method = "average"))
  }
  else {
    ord <- .Call(`_pseudorank_order_vec`, data) + 1
    data_sorted <- data[ord]
    sortback <- match(data, data_sorted)
    return(.Call(`_pseudorank_psrankCpp`, data_sorted, group[ord], n)[sortback])
  }
}


## Alternative (slower) algorithms
## ----------------------------------
# pairwise <- function(data, group, n){
#   group <- factor(group, labels = 1:length(n))
#   df <- data.table(data = data, group = group, id = 1:sum(n))
#   a <- length(n)
#   
#   df$group <- factor(df$group, labels = 1:a)
#   df$group <- as.numeric(df$group)
#   prank <- rep(0, length(data))
#   
#   L <- list(as.matrix(diag(a), ncol = a))
#   tmp <- df
#   
#   for(i in 1:a) {
#     L[[i]] <- as.matrix(diag(sum(n)), ncol = sum(n))*0
#     for(j in 1:a) {
#       tmp <- copy(df)
#       tmp[group %in% c(i,j), data:=rank(data, ties.method = "average")] 
#       L[[i]][, j] <- copy(tmp[, data])
#     }
#   }
#   
#   for(i in 1:sum(n)) {
#     g <- df$group[i]
#     prank[i] <- 1/n[g]*(L[[g]][i, g]-1/2)
#     for(j in 1:a) {
#       prank[i] <- prank[i]+1/n[j]*(L[[j]][i, g] - L[[g]][i, g])
#     }
#   }
#   prank <- prank*sum(n)/a+1/2
#   return(prank)
# } 
# 
# 
# AB <- function(data, group){
#   
#   stopifnot(is.numeric(data), is.factor(group))
#   n <- as.numeric(as.matrix(table(group)))
#   lcm <- Reduce(Lcm, n)
#   lambda <- lcm/n
#   
#   dat <- data.table(data = data, group = as.factor(group))
# 
#   if(max(lambda)>1){
#     len <- dim(dat)[1]
#     prData <- list(dat)
#     z <- levels(dat[,2])
#     a <- nlevels(dat[,2])
#     # amplify data to artificially create balanced groups
#     for(i in 1:a) {
#       print(i)
#       prData[[i+1]] <- dat[dat$group==z[i]][rep(1:(n[i]), each = (lambda[i]-1)), ]
#     }
#     dat <- rbindlist(prData)
#     dat[,data:=(rank(dat[,1], ties.method = "average")-1/2)*1/(lcm*a)]
#     dat <- dat[1:len,]
#     
#   } else {
#     dat[,data=rank(dat[,1], ties.method = "average")] 
#   }
#   
#   
#   # select original observations from amplified data
#   
#   return(dat[,1])
# }
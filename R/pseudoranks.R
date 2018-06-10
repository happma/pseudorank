################################################################################
### File: pseudoranks.R
### Description: Function to calculate mid-pseudo-ranks
###
################################################################################


#globalVariables("_pseudoranks_psrank")

#' Calculation of Pseudo-Ranks
#'
#' @description Calculation of (mid) pseudo-ranks of a sample. In case of ties (i.e. equal values), the average of min pseudo-rank and max-pseudor-rank are taken (similar to rank with ties.method="average").
#' @param data numerical vector
#' @param group vector coding for the groups
#' @return Returns a numerical vector containing the pseudo-ranks
#' @seealso \code{\link{rank}}.
#' @keywords internal
recursiveCalculation <- function(data, group) {

  stopifnot(is.numeric(data), is.factor(group))
  n <- as.numeric(as.matrix(table(group)))

  if( identical(n,rep(n[1],length(n)))  ) {
    return(rank(data, ties.method = "average"))
  } else {
    id <- 1:length(data)
    df <- matrix(c(data = data, group = group, id = id), ncol=3)
    df <- df[order(df[, 1]),]
    prank <- .Call(`_pseudorank_psrank`, df[, 1], df[, 2], n)
    sortback <- match(id, df[, 3])
    return(prank[sortback])
  }
}


## Alternative (slower) algorithms
## ----------------------------------
# pairwise <- function(data, group, n){
#   group <- factor(group, labels = 1:length(n))
#   df <- data.frame(data = data, group = group, id = 1:sum(n))
#   g <- levels(group)
#   df$group <- factor(df$group, labels = 1:length(n))
#   df$group <- as.numeric(df$group)
#   prank <- rep(0, length(data))
#   for(i in 1:length(n)) {
#     iset <- subset(df, df$group == i)$data
#     internal <- rank(iset, ties.method = "average")
#     for(j in 1:n[i]) {
#       prank[cumsum(c(0,n))[i]+j] <- (internal[j]-1/2)*1/n[i]
#       for(k in setdiff(1:length(n),i)) {
#         pset <- subset(df, df$group==i | df$group == k)$data
#         index <- which(pset == iset[j])
#         prank[cumsum(c(0,n))[i]+j] <- 1/n[k]*(rank(pset, ties.method = "average")[index] - internal[j]) + prank[cumsum(c(0,n))[i]+j] 
#       }
#       prank[cumsum(c(0,n))[i]+j] <- prank[cumsum(c(0,n))[i]+j]*sum(n)/length(n) + 1/2
#     }
#   }
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
# pseudorank

[![CRANstatus](https://www.r-pkg.org/badges/version/pseudorank)](https://cran.r-project.org/package=pseudorank)
<a href="https://www.rpackages.io/package/pseudorank"><img src="https://www.rpackages.io/badge/pseudorank.svg" /></a>
[![](https://cranlogs.r-pkg.org/badges/pseudorank)](https://cran.r-project.org/package=pseudorank)
[![Travis-CI Build Status](https://travis-ci.org/happma/pseudorank.svg?branch=master)](https://travis-ci.org/happma/pseudorank)

This R package provides a function written in C++ to calculate pseudo-ranks in R and the Hettmansperger-Norton test with pseudo-ranks instead of ranks.
For a definition and discussion of pseudo-ranks, see for example 

Brunner, E., Bathke A. C. and Konietschke, F: Rank- and Pseudo-Rank Procedures in Factorial Designs - Using R and SAS, Springer Verlag, to appear.

To install the current development version from github:

``` r
## install devtools package
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
# install package
devtools::install_github("happma/pseudorank")
library(pseudorank)
```

## Calculating Pseudo-Ranks

The function 'psrank' can either be used with data.frames or with vectors. Please note that when using a data.frame only one grouping factor can be used.

``` r
# some example data
df <- data.frame(data =rnorm(100),group = c(rep(1,40),rep(2,40),rep(3,20)))
df$group <- as.factor(df$group)

# two ways to calculate pseudo-ranks
# Variant 1: use a vector for the data and a group vector
psrank(df$data,df$group)

# Variant 2: use a formual object, Note that only one group factor can be used
# that is, in data~group*group2 only 'group' will be used
psrank(data~group,df)
```

## Hettmansperger-Norton Test for Patterned Alternatives in $k$-Sample Problems

The test implemented in this package uses pseudo-ranks instead of ranks. This is mainly due to paradoxical results caused by ranks. See 

Brunner, E., Konietschke, F., Bathke, A. C., & Pauly, M. (2018). Ranks and Pseudo-Ranks-Paradoxical Results of Rank Tests. arXiv preprint arXiv:1802.05650.

for a discussion of this problem.
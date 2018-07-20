df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,3,3,3,3))
df$group <- as.factor(df$group)

result_max <- c(2.00, 9.00, 2.00, 3.50, 5.75, 5.75, 6.50, 7.25, 9.00)
result_min <- c(1.00, 8.25, 1.00, 3.00, 4.50, 4.50, 6.75, 7.50, 8.25)

m <- pseudorank::psrank(df$data, df$group, ties.method = "min")
M <- pseudorank::psrank(df$data, df$group, ties.method = "max")
mid <- pseudorank::psrank(df$data, df$group, ties.method = "average")

context("Max and Min Pseudo-Ranks")

test_that("function psrank missing values", {
  expect_equivalent(pseudorank::psrank(df$data, df$group, ties.method = "max"), result_max)
  expect_equivalent(pseudorank::psrank(df$data, df$group, ties.method = "min"), result_min)
  expect_equivalent(0.5*(m+M), mid)
})
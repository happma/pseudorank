# data
test_df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,3,3,3,3))
test_df$group <- factor(test_df$group, ordered = TRUE)

# test function psrank
context("Function for Calculating Pseudo-Ranks")
true_result <- c(1.500, 8.625, 1.500, 3.250, 5.125, 5.125, 6.625, 7.375, 8.625)

test_that("function psrank", {
  expect_identical(pseudorank::psrank(data~group, test_df), true_result)
  expect_identical(pseudorank::psrank(test_df$data, test_df$group), true_result)
})

test_df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,2,3,3,3))
test_df$group <- factor(test_df$group, ordered = TRUE)

test_that("function psrank equal group sizes", {
  expect_identical(pseudorank::psrank(data~group, test_df), rank(test_df$data, ties.method = "average"))
  expect_identical(pseudorank::psrank(test_df$data, test_df$group), rank(test_df$data, ties.method = "average"))
})
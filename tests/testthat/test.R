# data
test_df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,3,3,3,3))
test_df$group <- factor(test_df$group)

test_df2 <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,3,1,2,2,3,3,3,1))
test_df2$group <- factor(test_df2$group)

# test function psrank
context("Function for Calculating Pseudo-Ranks")
true_result <- c(1.500, 8.625, 1.500, 3.250, 5.125, 5.125, 6.625, 7.375, 8.625)

test_that("function psrank", {
  expect_identical(pseudorank::psrank(test_df$data, test_df$group), true_result)
  expect_identical(pseudorank::psrank(y = test_df$group, x = test_df$data), true_result)
  expect_identical(pseudorank::psrank(data ~ group, test_df), true_result)
  
  expect_identical(pseudorank::psrank(test_df2$data, test_df2$group), true_result)
  expect_identical(pseudorank::psrank(data ~ group, data=test_df2), true_result)
  expect_identical(pseudorank::psrank(data ~ group, test_df2), true_result)
})

test_df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,2,3,3,3))
test_df$group <- factor(test_df$group)

test_that("function psrank equal group sizes", {
  expect_identical(pseudorank::psrank(test_df$data, test_df$group), rank(test_df$data, ties.method = "average"))
  expect_identical(pseudorank::psrank(data~group, test_df), rank(test_df$data, ties.method = "average"))
})

# test psrank with missing values

test_df <- data.frame(data = c(NA,7,1,NA,3,3,5.5,6,NA, 3, 1), group = c(1,1,1,2,2,2,3,3,3,1,2))
test_df$group <- factor(test_df$group)

result_NA <- c(8.055556, 1.388889, 3.611111, 3.611111, 5.611111, 6.944444, 3.611111, 1.388889)
result_TRUE <- c(8.902778,  7.986111,  1.416667,  9.819444,  3.708333,  3.708333,  5.694444,  6.916667, 10.888889,  3.708333,  1.416667)
result_FALSE <- c(3.097222, 11.041667,  4.472222,  2.180556,  6.763889,  6.763889,  8.750000,  9.972222,  1.111111,  6.763889,  4.472222)

test_that("function psrank missing values", {
  expect_equivalent(pseudorank::psrank(test_df$data, test_df$group, na.last = TRUE), result_TRUE, tolerance=1e-04)
  expect_equivalent(pseudorank::psrank(test_df$data, test_df$group, na.last = FALSE), result_FALSE, tolerance=1e-04)
  expect_equivalent(pseudorank::psrank(test_df$data, test_df$group, na.last = NA), result_NA, tolerance=1e-04)
})
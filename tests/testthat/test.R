# data
test_df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,3,3,3,3))
test_df$group <- factor(test_df$group, ordered = TRUE)

# test function psrank
true_result <- c(1.500, 8.625, 1.500, 3.250, 5.125, 5.125, 6.625, 7.375, 8.625)

test_that("function psrank", {
  expect_identical(pseudorank::psrank(data~group, test_df), true_result)
  expect_identical(pseudorank::psrank(test_df$data, test_df$group), true_result)
})

# test function psrank
true_result_hettmanspergerI <- 1.47888
true_result_hettmanspergerD <- -1.47888

test_that("function hettmansperger_norton_test", {
  expect_equivalent(pseudorank::hettmansperger_norton_test(data~group, test_df, alternative = "increasing")$test, true_result_hettmanspergerI, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(test_df$data, test_df$group, alternative = "increasing")$test, true_result_hettmanspergerI, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(data~group, test_df, alternative = "decreasing")$test, true_result_hettmanspergerD, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(test_df$data, test_df$group, alternative = "decreasing")$test, true_result_hettmanspergerD, tolerance=1e-4)
})
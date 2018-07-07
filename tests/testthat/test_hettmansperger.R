# test function hettmansperger
test_df <- data.frame(data = c(1,7,1,2,3,3,5.5,6,7), group = c(1,1,1,2,2,3,3,3,3))
test_df$group <- factor(test_df$group, ordered = TRUE)

context("Function for Calculating the Hettmansperger-Norton Test")
true_result_hettmanspergerI <- 1.47888
true_result_hettmanspergerD <- -1.47888

test_that("function hettmansperger_norton_test", {
  expect_equivalent(pseudorank::hettmansperger_norton_test(data~group, test_df, alternative = "increasing")$test, true_result_hettmanspergerI, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(test_df$data, test_df$group, alternative = "increasing")$test, true_result_hettmanspergerI, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(data~group, test_df, alternative = "decreasing")$test, true_result_hettmanspergerD, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(test_df$data, test_df$group, alternative = "decreasing")$test, true_result_hettmanspergerD, tolerance=1e-4)
})

# test function psrank custom trend
true_result_hettmanspergerC <- 0.3335237
test_trend <- c(1, 3, 2)

test_that("function hettmansperger_norton_test custom trend", {
  expect_equivalent(pseudorank::hettmansperger_norton_test(data~group, test_df, alternative = "custom", trend = test_trend)$test, true_result_hettmanspergerC, tolerance=1e-4)
  expect_equivalent(pseudorank::hettmansperger_norton_test(test_df$data, test_df$group, alternative = "custom", trend = test_trend)$test, true_result_hettmanspergerC, tolerance=1e-4)
})
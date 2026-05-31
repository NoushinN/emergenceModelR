test_that("simulate_self_organization returns data frame", {
  so <- simulate_self_organization(grid_size = 5, steps = 3, seed = 1)
  expect_s3_class(so, "data.frame")
  expect_true(all(c("step", "x", "y", "value") %in% names(so)))
})

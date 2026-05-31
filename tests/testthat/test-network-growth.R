test_that("simulate_network_growth returns expected list", {
  net <- simulate_network_growth(n_nodes = 10, m = 2, seed = 1)
  expect_true(is.list(net))
  expect_s3_class(net$edges, "data.frame")
  expect_true(is.matrix(net$adjacency_matrix))
})

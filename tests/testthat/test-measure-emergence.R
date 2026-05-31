test_that("measure_emergence returns metrics", {
  ca <- simulate_cellular_automata(n_cells = 11, steps = 5)
  m <- measure_emergence(ca, value_col = "state", time_col = "step")
  expect_s3_class(m, "data.frame")
  expect_true("shannon_entropy" %in% names(m))
})

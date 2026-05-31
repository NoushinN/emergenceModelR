test_that("simulate_cellular_automata returns data frame", {
  ca <- simulate_cellular_automata(n_cells = 11, steps = 5)
  expect_s3_class(ca, "data.frame")
  expect_true(all(c("step", "cell", "state") %in% names(ca)))
})

test_that("simulate_agent_interactions returns data frame", {
  agents <- simulate_agent_interactions(n_agents = 5, steps = 3, seed = 1)
  expect_s3_class(agents, "data.frame")
  expect_true(all(c("step", "agent", "x", "y") %in% names(agents)))
})

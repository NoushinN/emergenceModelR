#' Simulate simple agent interactions
#'
#' `simulate_agent_interactions()` models agents moving in a two-dimensional
#' space. Agents are influenced by neighbors within an interaction radius and by
#' random movement. The model is designed to illustrate how local interaction can
#' produce group-level patterns.
#'
#' @param n_agents Number of agents.
#' @param steps Number of simulation steps.
#' @param interaction_radius Distance within which agents influence each other.
#' @param alignment Strength of movement toward nearby agents.
#' @param noise Random movement strength.
#' @param seed Optional random seed.
#'
#' @return A data frame with one row per agent per step.
#' @export
#'
#' @examples
#' agents <- simulate_agent_interactions(n_agents = 20, steps = 30, seed = 1)
#' head(agents)
simulate_agent_interactions <- function(
    n_agents = 50,
    steps = 100,
    interaction_radius = 0.15,
    alignment = 0.05,
    noise = 0.02,
    seed = NULL
) {
  check_positive_integer(n_agents, "n_agents")
  check_positive_integer(steps, "steps")
  check_probability(interaction_radius, "interaction_radius")
  check_probability(alignment, "alignment")
  check_probability(noise, "noise")
  if (!is.null(seed)) set.seed(seed)

  x <- stats::runif(n_agents)
  y <- stats::runif(n_agents)
  out <- vector("list", steps)

  for (t in seq_len(steps)) {
    out[[t]] <- data.frame(
      step = t,
      agent = paste0("A", seq_len(n_agents)),
      x = x,
      y = y
    )

    new_x <- x
    new_y <- y
    for (i in seq_len(n_agents)) {
      d <- sqrt((x - x[i])^2 + (y - y[i])^2)
      neighbors <- which(d > 0 & d <= interaction_radius)
      if (length(neighbors) > 0) {
        target_x <- mean(x[neighbors])
        target_y <- mean(y[neighbors])
        new_x[i] <- x[i] + alignment * (target_x - x[i]) + stats::rnorm(1, 0, noise)
        new_y[i] <- y[i] + alignment * (target_y - y[i]) + stats::rnorm(1, 0, noise)
      } else {
        new_x[i] <- x[i] + stats::rnorm(1, 0, noise)
        new_y[i] <- y[i] + stats::rnorm(1, 0, noise)
      }
    }
    x <- pmin(pmax(new_x, 0), 1)
    y <- pmin(pmax(new_y, 0), 1)
  }

  do.call(rbind, out)
}

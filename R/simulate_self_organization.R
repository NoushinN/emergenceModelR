#' Simulate self-organization on a simple grid
#'
#' `simulate_self_organization()` models local feedback and diffusion on a
#' two-dimensional grid. Values are updated from local neighborhoods, producing
#' simple spatial pattern formation.
#'
#' @param grid_size Width and height of the square grid.
#' @param steps Number of simulation steps.
#' @param diffusion Strength of local averaging.
#' @param feedback Strength of local nonlinear feedback.
#' @param noise Random noise added at each step.
#' @param seed Optional random seed.
#'
#' @return A data frame with columns `step`, `x`, `y`, and `value`.
#' @export
#'
#' @examples
#' so <- simulate_self_organization(grid_size = 20, steps = 10, seed = 1)
#' head(so)
simulate_self_organization <- function(
    grid_size = 30,
    steps = 50,
    diffusion = 0.20,
    feedback = 0.60,
    noise = 0.03,
    seed = NULL
) {
  check_positive_integer(grid_size, "grid_size")
  check_positive_integer(steps, "steps")
  check_probability(diffusion, "diffusion")
  check_probability(feedback, "feedback")
  check_probability(noise, "noise")
  if (!is.null(seed)) set.seed(seed)

  grid <- matrix(stats::runif(grid_size * grid_size), nrow = grid_size)
  out <- vector("list", steps)

  for (t in seq_len(steps)) {
    out[[t]] <- data.frame(
      step = t,
      x = rep(seq_len(grid_size), times = grid_size),
      y = rep(seq_len(grid_size), each = grid_size),
      value = as.vector(grid)
    )

    up <- grid[c(grid_size, seq_len(grid_size - 1)), ]
    down <- grid[c(2:grid_size, 1), ]
    left <- grid[, c(grid_size, seq_len(grid_size - 1))]
    right <- grid[, c(2:grid_size, 1)]
    neighborhood <- (up + down + left + right) / 4

    local_feedback <- feedback * grid * (1 - grid)
    grid <- (1 - diffusion) * grid + diffusion * neighborhood + local_feedback
    grid <- grid + stats::rnorm(length(grid), 0, noise)
    grid <- matrix(rescale01(as.vector(grid)), nrow = grid_size)
  }

  do.call(rbind, out)
}

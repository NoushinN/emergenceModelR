#' Simulate a one-dimensional elementary cellular automaton
#'
#' `simulate_cellular_automata()` simulates binary cellular automata such as
#' Rule 30, Rule 90, and Rule 110. A simple local rule is repeatedly applied to
#' neighboring cells, producing patterns that may appear ordered, random, or
#' complex.
#'
#' @param rule Elementary cellular automaton rule number between 0 and 255.
#' @param n_cells Number of cells in the row.
#' @param steps Number of time steps.
#' @param initial_state Optional vector of 0s and 1s of length `n_cells`. If
#'   `NULL`, a single central active cell is used.
#' @param wrap Logical. If `TRUE`, the row wraps around at the edges.
#'
#' @return A data frame with columns `step`, `cell`, and `state`.
#' @export
#'
#' @examples
#' ca <- simulate_cellular_automata(rule = 30, n_cells = 31, steps = 20)
#' head(ca)
simulate_cellular_automata <- function(
    rule = 30,
    n_cells = 101,
    steps = 100,
    initial_state = NULL,
    wrap = TRUE
) {
  check_positive_integer(n_cells, "n_cells")
  check_positive_integer(steps, "steps")
  if (!is.numeric(rule) || length(rule) != 1 || rule < 0 || rule > 255 || rule != as.integer(rule)) {
    stop("rule must be an integer between 0 and 255.", call. = FALSE)
  }

  rule_bits <- as.integer(intToBits(as.integer(rule))[1:8])

  if (is.null(initial_state)) {
    state <- rep(0L, n_cells)
    state[ceiling(n_cells / 2)] <- 1L
  } else {
    if (length(initial_state) != n_cells || any(!initial_state %in% c(0, 1))) {
      stop("initial_state must be a vector of 0s and 1s with length n_cells.", call. = FALSE)
    }
    state <- as.integer(initial_state)
  }

  mat <- matrix(0L, nrow = steps, ncol = n_cells)
  mat[1, ] <- state

  for (t in 2:steps) {
    old <- mat[t - 1, ]
    new <- integer(n_cells)
    for (i in seq_len(n_cells)) {
      left <- if (i == 1) if (wrap) old[n_cells] else 0L else old[i - 1]
      center <- old[i]
      right <- if (i == n_cells) if (wrap) old[1] else 0L else old[i + 1]
      pattern <- left * 4 + center * 2 + right
      new[i] <- rule_bits[pattern + 1]
    }
    mat[t, ] <- new
  }

  data.frame(
    step = rep(seq_len(steps), each = n_cells),
    cell = rep(seq_len(n_cells), times = steps),
    state = as.vector(t(mat))
  )
}

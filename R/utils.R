check_positive_integer <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || x < 1 || x != as.integer(x)) {
    stop(name, " must be a positive integer.", call. = FALSE)
  }
  invisible(TRUE)
}

check_probability <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || x < 0 || x > 1) {
    stop(name, " must be a number between 0 and 1.", call. = FALSE)
  }
  invisible(TRUE)
}

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  if (!all(is.finite(rng)) || diff(rng) == 0) return(rep(0, length(x)))
  (x - rng[1]) / diff(rng)
}

shannon_entropy_internal <- function(x) {
  p <- table(x) / length(x)
  -sum(p * log2(p))
}

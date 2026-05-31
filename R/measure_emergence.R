#' Compute simple emergence-oriented summary metrics
#'
#' `measure_emergence()` computes educational metrics that can help summarize
#' order, diversity, variability, and temporal change in simulation outputs.
#'
#' @param data A data frame.
#' @param value_col Name of the numeric or discrete value column.
#' @param time_col Optional name of the time column.
#'
#' @return A data frame of summary metrics.
#' @export
#'
#' @examples
#' ca <- simulate_cellular_automata(rule = 30, steps = 20)
#' measure_emergence(ca, value_col = "state", time_col = "step")
measure_emergence <- function(data, value_col, time_col = NULL) {
  if (!is.data.frame(data)) stop("data must be a data frame.", call. = FALSE)
  if (!value_col %in% names(data)) stop("value_col not found in data.", call. = FALSE)
  if (!is.null(time_col) && !time_col %in% names(data)) stop("time_col not found in data.", call. = FALSE)

  x <- data[[value_col]]
  numeric_x <- suppressWarnings(as.numeric(x))

  metrics <- data.frame(
    n = length(x),
    unique_states = length(unique(x)),
    shannon_entropy = shannon_entropy_internal(x),
    mean_value = mean(numeric_x, na.rm = TRUE),
    sd_value = stats::sd(numeric_x, na.rm = TRUE)
  )

  if (!is.null(time_col)) {
    times <- unique(data[[time_col]])
    if (length(times) > 1) {
      by_time <- tapply(numeric_x, data[[time_col]], mean, na.rm = TRUE)
      metrics$temporal_variability <- stats::sd(by_time, na.rm = TRUE)
      metrics$mean_absolute_change <- mean(abs(diff(by_time)), na.rm = TRUE)
    }
  }
  metrics
}

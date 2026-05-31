#' Plot emergenceModelR simulation output
#'
#' `plot_emergence_sim()` provides simple plotting support for simulation
#' outputs. It can create either line plots or raster plots.
#'
#' @param data A data frame.
#' @param x Column name for x-axis.
#' @param y Column name for y-axis.
#' @param value Optional column used for raster fill.
#' @param group Optional grouping column for line plots.
#' @param type Either `"line"` or `"raster"`.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' ca <- simulate_cellular_automata(rule = 30, steps = 20)
#' plot_emergence_sim(ca, x = "cell", y = "step", value = "state", type = "raster")
plot_emergence_sim <- function(data, x, y, value = NULL, group = NULL, type = c("line", "raster")) {
  type <- match.arg(type)
  if (!is.data.frame(data)) stop("data must be a data frame.", call. = FALSE)
  if (!x %in% names(data)) stop("x column not found in data.", call. = FALSE)
  if (!y %in% names(data)) stop("y column not found in data.", call. = FALSE)

  if (type == "raster") {
    if (is.null(value) || !value %in% names(data)) stop("value column must be provided for raster plots.", call. = FALSE)
    return(
      ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]], fill = .data[[value]])) +
        ggplot2::geom_raster() +
        ggplot2::theme_minimal() +
        ggplot2::labs(x = x, y = y, fill = value)
    )
  }

  if (!is.null(group) && !group %in% names(data)) stop("group column not found in data.", call. = FALSE)
  if (is.null(group)) {
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
      ggplot2::geom_line() + ggplot2::geom_point() + ggplot2::theme_minimal() + ggplot2::labs(x = x, y = y)
  } else {
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]], group = .data[[group]])) +
      ggplot2::geom_line() + ggplot2::theme_minimal() + ggplot2::labs(x = x, y = y)
  }
}

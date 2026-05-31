#' Simulate network growth
#'
#' `simulate_network_growth()` grows a network one node at a time. New nodes
#' attach either randomly or preferentially to already well-connected nodes.
#'
#' @param n_nodes Final number of nodes.
#' @param m Number of edges each new node attempts to form.
#' @param mode Either `"preferential"` or `"random"`.
#' @param seed Optional random seed.
#'
#' @return A list with `edges`, `degree_history`, and `adjacency_matrix`.
#' @export
#'
#' @examples
#' net <- simulate_network_growth(n_nodes = 20, seed = 1)
#' head(net$edges)
simulate_network_growth <- function(
    n_nodes = 50,
    m = 2,
    mode = c("preferential", "random"),
    seed = NULL
) {
  check_positive_integer(n_nodes, "n_nodes")
  check_positive_integer(m, "m")
  if (m >= n_nodes) stop("m must be smaller than n_nodes.", call. = FALSE)
  mode <- match.arg(mode)
  if (!is.null(seed)) set.seed(seed)

  adj <- matrix(0L, nrow = n_nodes, ncol = n_nodes)
  adj[1, 2] <- adj[2, 1] <- 1L
  edges <- data.frame(from = 1L, to = 2L, step = 2L)
  degree_history <- list()

  for (new_node in 3:n_nodes) {
    existing <- seq_len(new_node - 1)
    deg <- rowSums(adj)[existing]
    if (mode == "preferential") {
      prob <- deg + 1
      prob <- prob / sum(prob)
    } else {
      prob <- rep(1 / length(existing), length(existing))
    }
    targets <- sample(existing, size = min(m, length(existing)), replace = FALSE, prob = prob)
    for (target in targets) {
      adj[new_node, target] <- 1L
      adj[target, new_node] <- 1L
      edges <- rbind(edges, data.frame(from = new_node, to = target, step = new_node))
    }
    degree_history[[new_node]] <- data.frame(
      step = new_node,
      node = paste0("N", seq_len(new_node)),
      degree = rowSums(adj)[seq_len(new_node)]
    )
  }

  list(
    edges = edges,
    degree_history = do.call(rbind, degree_history),
    adjacency_matrix = adj
  )
}

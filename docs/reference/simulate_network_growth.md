# Simulate network growth

`simulate_network_growth()` grows a network one node at a time. New
nodes attach either randomly or preferentially to already well-connected
nodes.

## Usage

``` r
simulate_network_growth(
  n_nodes = 50,
  m = 2,
  mode = c("preferential", "random"),
  seed = NULL
)
```

## Arguments

- n_nodes:

  Final number of nodes.

- m:

  Number of edges each new node attempts to form.

- mode:

  Either `"preferential"` or `"random"`.

- seed:

  Optional random seed.

## Value

A list with `edges`, `degree_history`, and `adjacency_matrix`.

## Examples

``` r
net <- simulate_network_growth(n_nodes = 20, seed = 1)
head(net$edges)
#>   from to step
#> 1    1  2    2
#> 2    3  2    3
#> 3    3  1    3
#> 4    4  3    4
#> 5    4  1    4
#> 6    5  1    5
```

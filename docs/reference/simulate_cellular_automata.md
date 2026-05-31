# Simulate a one-dimensional elementary cellular automaton

`simulate_cellular_automata()` simulates binary cellular automata such
as Rule 30, Rule 90, and Rule 110. A simple local rule is repeatedly
applied to neighboring cells, producing patterns that may appear
ordered, random, or complex.

## Usage

``` r
simulate_cellular_automata(
  rule = 30,
  n_cells = 101,
  steps = 100,
  initial_state = NULL,
  wrap = TRUE
)
```

## Arguments

- rule:

  Elementary cellular automaton rule number between 0 and 255.

- n_cells:

  Number of cells in the row.

- steps:

  Number of time steps.

- initial_state:

  Optional vector of 0s and 1s of length `n_cells`. If `NULL`, a single
  central active cell is used.

- wrap:

  Logical. If `TRUE`, the row wraps around at the edges.

## Value

A data frame with columns `step`, `cell`, and `state`.

## Examples

``` r
ca <- simulate_cellular_automata(rule = 30, n_cells = 31, steps = 20)
head(ca)
#>   step cell state
#> 1    1    1     0
#> 2    1    2     0
#> 3    1    3     0
#> 4    1    4     0
#> 5    1    5     0
#> 6    1    6     0
```

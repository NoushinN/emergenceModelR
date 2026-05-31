# Plot emergenceModelR simulation output

`plot_emergence_sim()` provides simple plotting support for simulation
outputs. It can create either line plots or raster plots.

## Usage

``` r
plot_emergence_sim(
  data,
  x,
  y,
  value = NULL,
  group = NULL,
  type = c("line", "raster")
)
```

## Arguments

- data:

  A data frame.

- x:

  Column name for x-axis.

- y:

  Column name for y-axis.

- value:

  Optional column used for raster fill.

- group:

  Optional grouping column for line plots.

- type:

  Either `"line"` or `"raster"`.

## Value

A ggplot object.

## Examples

``` r
ca <- simulate_cellular_automata(rule = 30, steps = 20)
plot_emergence_sim(ca, x = "cell", y = "step", value = "state", type = "raster")
```

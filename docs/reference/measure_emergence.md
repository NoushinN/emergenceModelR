# Compute simple emergence-oriented summary metrics

`measure_emergence()` computes educational metrics that can help
summarize order, diversity, variability, and temporal change in
simulation outputs.

## Usage

``` r
measure_emergence(data, value_col, time_col = NULL)
```

## Arguments

- data:

  A data frame.

- value_col:

  Name of the numeric or discrete value column.

- time_col:

  Optional name of the time column.

## Value

A data frame of summary metrics.

## Examples

``` r
ca <- simulate_cellular_automata(rule = 30, steps = 20)
measure_emergence(ca, value_col = "state", time_col = "step")
#>      n unique_states shannon_entropy mean_value  sd_value temporal_variability
#> 1 2020             2        0.512918  0.1143564 0.3183225           0.06749473
#>   mean_absolute_change
#> 1           0.04012507
```

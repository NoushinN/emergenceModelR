# Simulate self-organization on a simple grid

`simulate_self_organization()` models local feedback and diffusion on a
two-dimensional grid. Values are updated from local neighborhoods,
producing simple spatial pattern formation.

## Usage

``` r
simulate_self_organization(
  grid_size = 30,
  steps = 50,
  diffusion = 0.2,
  feedback = 0.6,
  noise = 0.03,
  seed = NULL
)
```

## Arguments

- grid_size:

  Width and height of the square grid.

- steps:

  Number of simulation steps.

- diffusion:

  Strength of local averaging.

- feedback:

  Strength of local nonlinear feedback.

- noise:

  Random noise added at each step.

- seed:

  Optional random seed.

## Value

A data frame with columns `step`, `x`, `y`, and `value`.

## Examples

``` r
so <- simulate_self_organization(grid_size = 20, steps = 10, seed = 1)
head(so)
#>   step x y     value
#> 1    1 1 1 0.2655087
#> 2    1 2 1 0.3721239
#> 3    1 3 1 0.5728534
#> 4    1 4 1 0.9082078
#> 5    1 5 1 0.2016819
#> 6    1 6 1 0.8983897
```

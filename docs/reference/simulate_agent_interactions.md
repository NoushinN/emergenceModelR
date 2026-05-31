# Simulate simple agent interactions

`simulate_agent_interactions()` models agents moving in a
two-dimensional space. Agents are influenced by neighbors within an
interaction radius and by random movement. The model is designed to
illustrate how local interaction can produce group-level patterns.

## Usage

``` r
simulate_agent_interactions(
  n_agents = 50,
  steps = 100,
  interaction_radius = 0.15,
  alignment = 0.05,
  noise = 0.02,
  seed = NULL
)
```

## Arguments

- n_agents:

  Number of agents.

- steps:

  Number of simulation steps.

- interaction_radius:

  Distance within which agents influence each other.

- alignment:

  Strength of movement toward nearby agents.

- noise:

  Random movement strength.

- seed:

  Optional random seed.

## Value

A data frame with one row per agent per step.

## Examples

``` r
agents <- simulate_agent_interactions(n_agents = 20, steps = 30, seed = 1)
head(agents)
#>   step agent         x         y
#> 1    1    A1 0.2655087 0.9347052
#> 2    1    A2 0.3721239 0.2121425
#> 3    1    A3 0.5728534 0.6516738
#> 4    1    A4 0.9082078 0.1255551
#> 5    1    A5 0.2016819 0.2672207
#> 6    1    A6 0.8983897 0.3861141
```

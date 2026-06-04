# Network Growth Tutorial

``` r
library(emergenceModelR)
```

## Purpose

This tutorial introduces
[`simulate_network_growth()`](https://noushinn.github.io/emergenceModelR/reference/simulate_network_growth.md).
The function creates simplified network growth simulations that show how
global network structure can arise from local attachment rules.

In this tutorial, you will learn how to:

- run a preferential attachment model;
- inspect the network output;
- examine the edge list;
- summarize node degree;
- compare preferential and random attachment;
- use
  [`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md)
  on network degree history;
- interpret network growth results responsibly.

## What the function represents

A network is made of nodes and edges. Nodes represent parts of a system,
and edges represent connections between them.

In this model, the network grows over time. New nodes are added and
connected to existing nodes according to an attachment rule.

The model is intentionally simple. It is not a full model of real
social, biological, neural, or technological networks. It is designed to
teach one core idea:

> Local attachment rules can generate global network structure.

## Main arguments

| Argument  | Meaning                                                 |
|-----------|---------------------------------------------------------|
| `n_nodes` | Total number of nodes in the final network              |
| `m`       | Number of connections each new node attempts to form    |
| `mode`    | Attachment rule: usually `"preferential"` or `"random"` |
| `seed`    | Random seed for reproducible results                    |

The most important argument is `mode`, because it controls how new nodes
choose existing nodes to connect to.

## Preferential attachment

Preferential attachment means that new nodes are more likely to connect
to nodes that are already well connected.

This is sometimes described as a cumulative advantage process: nodes
with many links have a higher chance of receiving even more links.

``` r
pref <- simulate_network_growth(
  n_nodes = 60,
  m = 2,
  mode = "preferential",
  seed = 4
)

names(pref)
#> [1] "edges"            "degree_history"   "adjacency_matrix"
```

## Inspect the edge list

The edge list shows which nodes are connected.

``` r
head(pref$edges)
#>   from to step
#> 1    1  2    2
#> 2    3  1    3
#> 3    3  2    3
#> 4    4  2    4
#> 5    4  3    4
#> 6    5  1    5
```

Each row represents a connection between two nodes. This is the basic
relational structure of the network.

## Inspect degree history

Degree means the number of connections a node has. The degree history
tracks how node degree changes as the network grows.

``` r
head(pref$degree_history)
#>   step node degree
#> 1    3   N1      2
#> 2    3   N2      2
#> 3    3   N3      2
#> 4    4   N1      2
#> 5    4   N2      3
#> 6    4   N3      3
```

The degree history is useful because it allows us to study the
development of network structure over time.

## Final degree summary

To summarize the final network, keep only the last time step.

``` r
final_degrees <- subset(
  pref$degree_history,
  step == max(step)
)

summary(final_degrees$degree)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>     2.0     2.0     3.0     3.9     5.0    12.0
```

## Interpretation

The final degree summary shows how many connections nodes have at the
end of the simulation.

In a preferential attachment model, some nodes may become much more
connected than others. These highly connected nodes are often called
hubs.

The key point is:

> The hubs are not directly designed. They emerge from repeated local
> attachment decisions.

## Create a degree summary table

A simple table can help summarize the final network more clearly.

``` r
pref_summary <- data.frame(
  model = "preferential",
  mean_degree = mean(final_degrees$degree),
  max_degree = max(final_degrees$degree),
  sd_degree = stats::sd(final_degrees$degree),
  n_nodes = length(unique(final_degrees$node))
)

pref_summary
#>          model mean_degree max_degree sd_degree n_nodes
#> 1 preferential         3.9         12  2.508967      60
```

The maximum degree and standard deviation are especially useful for
detecting unequal connectivity.

## Random attachment

Now compare preferential attachment with random attachment.

In random attachment, new nodes connect without favoring already
well-connected nodes.

``` r
random_net <- simulate_network_growth(
  n_nodes = 60,
  m = 2,
  mode = "random",
  seed = 4
)

final_random <- subset(
  random_net$degree_history,
  step == max(step)
)

summary(final_random$degree)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>     2.0     2.0     3.5     3.9     5.0    12.0
```

## Compare preferential and random networks

``` r
comparison <- data.frame(
  model = c("preferential", "random"),
  mean_degree = c(
    mean(final_degrees$degree),
    mean(final_random$degree)
  ),
  max_degree = c(
    max(final_degrees$degree),
    max(final_random$degree)
  ),
  sd_degree = c(
    stats::sd(final_degrees$degree),
    stats::sd(final_random$degree)
  )
)

comparison
#>          model mean_degree max_degree sd_degree
#> 1 preferential         3.9         12  2.508967
#> 2       random         3.9         12  2.080580
```

## Interpretation of the comparison

The two networks may have the same number of nodes and similar average
degree, but their structure can be different.

Preferential attachment often produces a more unequal degree
distribution. Random attachment usually produces less extreme hubs.

This illustrates a major lesson of network emergence:

> The rule for forming connections shapes the global structure of the
> network.

## Measure emergence-oriented summaries

You can also use
[`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md)
to summarize degree history.

``` r
measure_emergence(
  pref$degree_history,
  value_col = "degree",
  time_col = "step"
)
#>      n unique_states shannon_entropy mean_value sd_value temporal_variability
#> 1 1827            11        2.594135   3.809524 2.110283            0.3590056
#>   mean_absolute_change
#> 1           0.03333333
```

``` r
measure_emergence(
  random_net$degree_history,
  value_col = "degree",
  time_col = "step"
)
#>      n unique_states shannon_entropy mean_value sd_value temporal_variability
#> 1 1827            11         2.60549   3.809524 1.972388            0.3590056
#>   mean_absolute_change
#> 1           0.03333333
```

## Compare network metrics

``` r
rbind(
  preferential = measure_emergence(
    pref$degree_history,
    value_col = "degree",
    time_col = "step"
  ),
  random = measure_emergence(
    random_net$degree_history,
    value_col = "degree",
    time_col = "step"
  )
)
#>                 n unique_states shannon_entropy mean_value sd_value
#> preferential 1827            11        2.594135   3.809524 2.110283
#> random       1827            11        2.605490   3.809524 1.972388
#>              temporal_variability mean_absolute_change
#> preferential            0.3590056           0.03333333
#> random                  0.3590056           0.03333333
```

## Interpretation of metrics

For network growth, the selected value is `degree`. Therefore, the
metrics summarize variation and change in node connectivity.

A higher standard deviation may suggest more unequal connectivity. A
higher maximum degree may suggest stronger hub formation.

However, these metrics should not be interpreted as a complete measure
of emergence. They summarize network structure. They do not prove that
one network is “truly more emergent” than another.

## Change the number of links per new node

The argument `m` controls how many links each new node attempts to form.
Increasing `m` generally creates a more connected network.

``` r
pref_m1 <- simulate_network_growth(
  n_nodes = 60,
  m = 1,
  mode = "preferential",
  seed = 4
)

pref_m3 <- simulate_network_growth(
  n_nodes = 60,
  m = 3,
  mode = "preferential",
  seed = 4
)

final_m1 <- subset(
  pref_m1$degree_history,
  step == max(step)
)

final_m3 <- subset(
  pref_m3$degree_history,
  step == max(step)
)

data.frame(
  model = c("m = 1", "m = 3"),
  mean_degree = c(mean(final_m1$degree), mean(final_m3$degree)),
  max_degree = c(max(final_m1$degree), max(final_m3$degree)),
  sd_degree = c(stats::sd(final_m1$degree), stats::sd(final_m3$degree))
)
#>   model mean_degree max_degree sd_degree
#> 1 m = 1    1.966667          9  1.517878
#> 2 m = 3    5.800000         17  3.799197
```

## Interpretation of `m`

Changing `m` changes the density of the network. A larger value of `m`
gives each new node more connections, which can increase the overall
degree of the network.

This shows that network emergence depends on both:

- the attachment rule;
- the number of connections added during growth.

## Compare random seeds

Network growth can also depend on chance events. The same rule may
produce different specific networks depending on the random seed.

``` r
pref_seed_1 <- simulate_network_growth(
  n_nodes = 60,
  m = 2,
  mode = "preferential",
  seed = 1
)

pref_seed_10 <- simulate_network_growth(
  n_nodes = 60,
  m = 2,
  mode = "preferential",
  seed = 10
)

final_seed_1 <- subset(
  pref_seed_1$degree_history,
  step == max(step)
)

final_seed_10 <- subset(
  pref_seed_10$degree_history,
  step == max(step)
)

data.frame(
  model = c("seed = 1", "seed = 10"),
  mean_degree = c(mean(final_seed_1$degree), mean(final_seed_10$degree)),
  max_degree = c(max(final_seed_1$degree), max(final_seed_10$degree)),
  sd_degree = c(stats::sd(final_seed_1$degree), stats::sd(final_seed_10$degree))
)
#>       model mean_degree max_degree sd_degree
#> 1  seed = 1         3.9         14  2.826629
#> 2 seed = 10         3.9         17  3.128329
```

## Interpretation of seed comparison

The same rule can produce different specific networks. This reflects the
role of contingency in growing systems.

A network may follow a general pattern, such as hub formation, while the
exact identity and degree of the hubs may vary.

## Suggested exercises

Try modifying the model settings.

``` r
experiment <- simulate_network_growth(
  n_nodes = 100,
  m = 2,
  mode = "preferential",
  seed = 12
)

experiment_final <- subset(
  experiment$degree_history,
  step == max(step)
)

summary(experiment_final$degree)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    2.00    2.00    3.00    3.94    5.00   18.00
```

Questions to consider:

- What happens when `n_nodes` increases?
- What happens when `m` increases?
- How does preferential attachment differ from random attachment?
- Which setting produces the largest hub?
- Does the average degree tell the whole story?
- Why is the degree distribution more informative than the average
  alone?

## Responsible interpretation

This model is a simplified educational model of network growth. It
should not be interpreted as a complete model of real social,
biological, neural, or technological networks.

It is better to say:

> The simulation illustrates how local attachment rules can generate
> hubs.

than:

> The simulation fully explains real-world network formation.

It is better to say:

> Preferential attachment can produce unequal degree distributions in
> this model.

than:

> All real networks form through preferential attachment.

## Key takeaway

[`simulate_network_growth()`](https://noushinn.github.io/emergenceModelR/reference/simulate_network_growth.md)
helps users explore how local connection rules shape global network
structure.

Preferential attachment can generate hubs and unequal degree
distributions without central planning. Random attachment usually
produces a different pattern. By comparing these models, learners can
see how network emergence depends on the rules that form connections.

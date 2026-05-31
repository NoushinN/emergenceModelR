# Measuring Emergence

``` r
library(emergenceModelR)
```

## Purpose

This article explains why measuring emergence is difficult and how the
function
[`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md)
should be interpreted. Emergence is not a single quantity. It may
involve order, complexity, novelty, organization, information,
multi-level structure, or causal dependence (Holland 1998; Mitchell
2009).

The purpose of this chapter is not to offer a final measure of
emergence. Instead, it explains how simple metrics can help summarize
simulation outputs while preserving the distinction between educational
summaries and deeper theoretical claims.

The guiding question is:

> Can we use simple metrics to support the interpretation of emergent
> patterns without pretending that emergence has been fully measured?

## Why measuring emergence is difficult

Emergence is difficult to measure because it is a multi-dimensional
concept.

A pattern may be called emergent for different reasons:

- it arises from local rules;
- it appears at a higher level of organization;
- it is difficult to predict in advance;
- it displays novelty relative to the components;
- it shows structured complexity;
- it depends on interactions among parts;
- it has causal or functional significance at the system level.

These ideas are related, but they are not identical. For example, a
pattern may be unpredictable but not organized. Another pattern may be
highly ordered but not very complex. A random sequence may have high
entropy but little meaningful structure.

This means that no single metric can fully measure emergence.

## Metrics as summaries, not definitions

The function
[`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md)
provides simple summaries of simulation outputs. These summaries are
useful for comparing models, but they should not be treated as complete
definitions of emergence.

A responsible interpretation is:

> The metric summarizes one aspect of the simulated pattern.

An overstatement would be:

> The metric measures true emergence.

The first statement is appropriate. The second is too strong.

## Educational metrics in the package

[`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md)
computes simple metrics that help summarize simulation outputs.

Depending on the model and selected columns, these may include:

- number of observations;
- number of unique states;
- Shannon entropy;
- mean value;
- standard deviation;
- temporal variability;
- mean absolute change over time.

These metrics are useful because they make simulation outputs easier to
compare. They help learners ask whether one model run is more diverse,
more variable, or more dynamic than another.

## Basic example

``` r
ca <- simulate_cellular_automata(
  rule = 30,
  steps = 50
)

measure_emergence(
  ca,
  value_col = "state",
  time_col = "step"
)
#>      n unique_states shannon_entropy mean_value  sd_value temporal_variability
#> 1 5050             2       0.8335416  0.2645545 0.4411394            0.1505025
#>   mean_absolute_change
#> 1            0.0585977
```

## Interpreting the output

The output summarizes the cellular automaton pattern. For example, it
may show how many unique states are present, how variable the output is,
or how much the system changes over time.

This does not mean that the function has fully measured emergence.
Rather, it has summarized features that may be relevant to interpreting
an emergent pattern.

The correct question is not:

> What is the emergence score?

A better question is:

> What does this metric reveal about the pattern, variability,
> diversity, or change in this model output?

## Interpreting entropy

Entropy is often used to describe diversity, uncertainty, or
unpredictability in a distribution (Shannon 1948; Cover and Thomas
2006).

In the context of
[`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md),
entropy can help summarize how diverse or unpredictable the values are
in a model output.

However, entropy alone is not emergence.

A random sequence may have high entropy but little meaningful
organization. A highly ordered pattern may have low entropy but still be
structurally important. Emergence often involves a balance between order
and variability, not simply maximum disorder.

A careful interpretation is:

> Entropy summarizes diversity or uncertainty in the simulated values.

An overstatement would be:

> Entropy measures emergence directly.

## Interpreting unique states

The number of unique states can show how many different values or
categories appear in the output.

For example, in a binary cellular automaton, the number of possible
states may be small. In a self-organization model with continuous grid
values, the number of unique values may be much larger.

This means that unique-state counts must be interpreted relative to the
model type.

``` r
ca_30 <- simulate_cellular_automata(
  rule = 30,
  steps = 50
)

so <- simulate_self_organization(
  grid_size = 30,
  steps = 30,
  diffusion = 0.20,
  feedback = 0.60,
  seed = 5
)

rbind(
  cellular_automata = measure_emergence(
    ca_30,
    value_col = "state",
    time_col = "step"
  ),
  self_organization = measure_emergence(
    so,
    value_col = "value",
    time_col = "step"
  )
)
#>                       n unique_states shannon_entropy mean_value  sd_value
#> cellular_automata  5050             2       0.8335416  0.2645545 0.4411394
#> self_organization 27000         26944      14.7102361  0.8430290 0.1394870
#>                   temporal_variability mean_absolute_change
#> cellular_automata           0.15050249           0.05859770
#> self_organization           0.09541441           0.02312229
```

## Interpretation of unique states

The cellular automaton and self-organization model produce different
kinds of values. The cellular automaton usually uses discrete binary
states. The self-organization model may produce continuous numeric
values.

Therefore, a higher number of unique values does not automatically mean
“more emergence.” It may simply reflect the type of data produced by the
model.

This is why metrics must be interpreted in context.

## Interpreting temporal change

Temporal change shows whether and how much the system changes over time.

A system that never changes may be ordered but not dynamically
interesting. A system that changes randomly may be dynamic but not
organized. Emergence often involves structured change: change that
produces pattern, organization, or system-level behavior.

The metric for mean absolute change can help summarize how much the
selected value changes across time steps.

``` r
ca_110 <- simulate_cellular_automata(
  rule = 110,
  steps = 50
)

measure_emergence(
  ca_110,
  value_col = "state",
  time_col = "step"
)
#>      n unique_states shannon_entropy mean_value  sd_value temporal_variability
#> 1 5050             2       0.6061112  0.1485149 0.3556448           0.08223164
#>   mean_absolute_change
#> 1           0.02667205
```

## Interpretation of temporal change

Temporal change is useful because emergence is often dynamic. Patterns
unfold over time. However, change by itself is not enough.

A completely random system may change a lot. A meaningful emergent
system may show both change and structure.

The important question is:

> Is the change organized, patterned, or meaningful within the model?

## Comparing cellular automata rules

Metrics are most useful when comparing similar models. For example,
comparing two cellular automaton rules is more meaningful than comparing
a cellular automaton directly with an agent model.

``` r
rule_30 <- simulate_cellular_automata(
  rule = 30,
  steps = 50
)

rule_110 <- simulate_cellular_automata(
  rule = 110,
  steps = 50
)

rbind(
  rule_30 = measure_emergence(
    rule_30,
    value_col = "state",
    time_col = "step"
  ),
  rule_110 = measure_emergence(
    rule_110,
    value_col = "state",
    time_col = "step"
  )
)
#>             n unique_states shannon_entropy mean_value  sd_value
#> rule_30  5050             2       0.8335416  0.2645545 0.4411394
#> rule_110 5050             2       0.6061112  0.1485149 0.3556448
#>          temporal_variability mean_absolute_change
#> rule_30            0.15050249           0.05859770
#> rule_110           0.08223164           0.02667205
```

## Interpretation of model comparison

Because both outputs come from the same model family, the comparison is
easier to interpret. Differences in the metrics may reflect differences
in the local rule and resulting pattern.

Even here, metrics should be combined with visualization. A numerical
summary may show that two outputs differ, but a plot can show how they
differ.

## Metrics and visualization

Metrics and plots answer different questions.

| Tool          | What it helps answer                             |
|---------------|--------------------------------------------------|
| Metric        | How variable, diverse, or dynamic is the output? |
| Visualization | What kind of pattern appears?                    |
| Theory        | Why does the pattern matter?                     |

A good interpretation usually combines all three.

For example:

1.  Use a plot to observe the pattern.
2.  Use metrics to summarize the output.
3.  Use theory to explain why the pattern is relevant to emergence.

## Model-specific interpretation

The same metric can mean different things in different model families.

| Model | Value column | Possible interpretation |
|----|----|----|
| Cellular automata | `state` | Diversity or change in binary cell states |
| Self-organization | `value` | Spatial variation or changing grid intensity |
| Agent interactions | `x` or `y` | Variation in agent position |
| Network growth | `degree` | Unevenness or change in connectivity |

This means that metrics should not be compared mechanically across all
models. The interpretation depends on what the value represents.

## Network example

For network growth, degree summaries can help describe connectivity
patterns.

``` r
net <- simulate_network_growth(
  n_nodes = 60,
  m = 2,
  mode = "preferential",
  seed = 4
)

measure_emergence(
  net$degree_history,
  value_col = "degree",
  time_col = "step"
)
#>      n unique_states shannon_entropy mean_value sd_value temporal_variability
#> 1 1827            11        2.594135   3.809524 2.110283            0.3590056
#>   mean_absolute_change
#> 1           0.03333333
```

## Interpretation of network metrics

In a network model, high variation in degree may suggest that some nodes
become much more connected than others. This may indicate hub formation.

However, this does not mean that the network is “more emergent” in a
universal sense. It means that the network has a more unequal or
heterogeneous connectivity pattern.

Again, the metric supports interpretation. It does not replace
interpretation.

## Good uses of metrics

Metrics are useful for:

- comparing parameter settings within the same model;
- summarizing large simulation outputs;
- identifying differences between model runs;
- supporting visual interpretation;
- teaching how local rules affect global outputs;
- encouraging careful comparison rather than vague description.

For example, metrics can help compare:

- Rule 30 and Rule 110;
- low-feedback and high-feedback self-organization;
- weak-alignment and strong-alignment agent models;
- random and preferential network growth.

## Poor uses of metrics

Metrics are less useful when they are treated as final answers.

Avoid using metrics to claim:

- that one system has “true emergence” and another does not;
- that a toy model proves a real-world theory;
- that entropy alone captures organization;
- that complexity has been fully measured;
- that life or consciousness has been detected.

These claims go beyond what the package can support.

## Relation to emergence theory

The difficulty of measuring emergence reflects a deeper theoretical
issue. Emergence is not only about numerical complexity. It is also
about levels of organization, interactions, constraints, and explanatory
relationships.

A strong analysis of emergence should therefore consider:

- the lower-level components;
- the local rules;
- the interaction structure;
- the system dynamics;
- the higher-level pattern;
- the relationship between lower and higher levels.

Metrics can support this analysis, but they cannot replace it.

## Responsible interpretation

It is better to say:

> The metric summarizes variation in the simulated pattern.

than:

> The metric proves emergence.

It is better to say:

> Entropy helps describe diversity or uncertainty.

than:

> Entropy fully measures complexity.

It is better to say:

> The metric supports comparison between model runs.

than:

> The metric gives a final emergence score.

Careful language keeps the package accurate and credible.

## Educational use

This chapter can support several classroom or self-study questions:

- Why is emergence difficult to measure?
- What does entropy summarize?
- Why is high entropy not the same as emergence?
- Why should similar models be compared before comparing different model
  families?
- What can metrics reveal that plots may not?
- What can plots reveal that metrics may miss?
- Why should metrics be interpreted in theoretical context?

These questions help learners treat measurement as part of
interpretation, not a substitute for it.

## Key takeaway

Measuring emergence is difficult because emergence is not a single
property. It may involve diversity, organization, novelty, interaction,
multi-level structure, and dynamic change.

[`measure_emergence()`](https://noushinn.github.io/emergenceModelR/reference/measure_emergence.md)
provides simple educational metrics that help summarize model outputs.
These metrics are useful for comparison, but they should be interpreted
as proxies or summaries, not as complete measures of emergence.

## References

Cover, Thomas M., and Joy A. Thomas. 2006. *Elements of Information
Theory*. Wiley.

Holland, John H. 1998. *Emergence: From Chaos to Order*. Oxford
University Press.

Mitchell, Melanie. 2009. *Complexity: A Guided Tour*. Oxford University
Press.

Shannon, Claude E. 1948. “A Mathematical Theory of Communication.” *Bell
System Technical Journal* 27 (3): 379–423.

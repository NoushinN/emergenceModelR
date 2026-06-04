library(hexSticker)
library(ggplot2)

# Make sure you are in the package root folder:
# setwd("C:/Users/NNABAVI/emergenceModelR")

dir.create("man/figures", recursive = TRUE, showWarnings = FALSE)

# -----------------------------
# Emergence-style spiral network
# -----------------------------

theta <- seq(0.4, 4.7 * pi, length.out = 18)
radius <- seq(0.12, 1.05, length.out = length(theta))

nodes <- data.frame(
  id = seq_along(theta),
  x = radius * cos(theta),
  y = radius * sin(theta),
  size = seq(1.5, 3.2, length.out = length(theta))
)

edges <- data.frame(
  x = nodes$x[-nrow(nodes)],
  y = nodes$y[-nrow(nodes)],
  xend = nodes$x[-1],
  yend = nodes$y[-1]
)

# A few faint background particles
particles <- data.frame(
  x = c(-0.85, -0.60, 0.70, 0.90, -0.25, 0.35),
  y = c( 0.65, -0.55, 0.55, -0.30, 0.92, -0.85),
  size = c(0.7, 0.6, 0.7, 0.6, 0.5, 0.5)
)

p <- ggplot() +
  geom_segment(
    data = edges,
    aes(x = x, y = y, xend = xend, yend = yend),
    linewidth = 0.75,
    color = "#4C5F63",
    alpha = 0.85,
    lineend = "round"
  ) +
  geom_point(
    data = nodes,
    aes(x = x, y = y, size = size),
    shape = 21,
    fill = "#223D42",
    color = "#1B6B5A",
    stroke = 0.35
  ) +
  geom_point(
    data = particles,
    aes(x = x, y = y, size = size),
    shape = 21,
    fill = "#A9C8BE",
    color = "#789E94",
    stroke = 0.2,
    alpha = 0.75
  ) +
  scale_size_identity() +
  coord_equal(
    xlim = c(-1.25, 1.25),
    ylim = c(-1.25, 1.25),
    expand = FALSE
  ) +
  theme_void()

sticker(
  subplot = p,
  package = "",
  s_x = 1,
  s_y = 1,
  s_width = 1.05,
  s_height = 1.05,
  h_fill = "#F4F8F7",
  h_color = "#155C4C",
  h_size = 1.8,
  filename = "man/figures/emergenceModelR_hex.png"
)

message("Saved to: man/figures/emergenceModelR_hex.png")
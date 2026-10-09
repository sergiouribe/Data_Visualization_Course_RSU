# ============================================================================
# Module 08: Advanced Customization in ggplot2
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# You may need to install these:
# install.packages("ggrepel")
# install.packages("scales")

# ----------------------------------------------------------------------------
# PART 1: DEEP THEME CUSTOMIZATION
# ----------------------------------------------------------------------------

# Basic customization example
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  labs(title = "GDP vs Life Expectancy") +
  theme(
    # Title
    plot.title = element_text(
      size = 16,
      face = "bold",
      color = "navy",
      hjust = 0.5  # Center
    ),

    # Panel
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_blank(),

    # Axis
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10, color = "grey30"),
    axis.line = element_line(color = "grey50")
  )


# ----------------------------------------------------------------------------
# PART 2: BUILDING A COMPLETE CUSTOM THEME
# ----------------------------------------------------------------------------

# Define a comprehensive custom theme
theme_elegant <- function(base_size = 12) {
  theme_minimal(base_size = base_size) %+replace%
    theme(
      # Overall plot
      plot.title = element_text(
        size = rel(1.4),
        face = "bold",
        hjust = 0,
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = rel(1),
        color = "grey40",
        hjust = 0,
        margin = margin(b = 15)
      ),
      plot.caption = element_text(
        size = rel(0.8),
        color = "grey50",
        hjust = 1
      ),
      plot.background = element_rect(fill = "white", color = NA),
      plot.margin = margin(15, 15, 10, 10),

      # Panel
      panel.grid.major.y = element_line(color = "grey90", linewidth = 0.3),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "white", color = NA),

      # Axes
      axis.title.x = element_text(margin = margin(t = 10), color = "grey30"),
      axis.title.y = element_text(margin = margin(r = 10), color = "grey30"),
      axis.text = element_text(color = "grey40"),
      axis.line.x = element_line(color = "grey50", linewidth = 0.5),
      axis.ticks = element_line(color = "grey50"),

      # Legend
      legend.position = "bottom",
      legend.title = element_text(face = "bold", size = rel(0.9)),
      legend.text = element_text(size = rel(0.85)),
      legend.background = element_rect(fill = NA),
      legend.key = element_rect(fill = NA)
    )
}

# Use the custom theme
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "The Wealth-Health Connection",
    subtitle = "Relationship between GDP per capita and life expectancy in 2007",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)",
    color = "Continent",
    caption = "Source: Gapminder"
  ) +
  theme_elegant()


# ----------------------------------------------------------------------------
# PART 3: CUSTOM COLOR PALETTES
# ----------------------------------------------------------------------------

# Define custom colors for continents
continent_colors <- c(
  "Africa" = "#E64B35",
  "Americas" = "#4DBBD5",
  "Asia" = "#00A087",
  "Europe" = "#3C5488",
  "Oceania" = "#F39B7F"
)

# Apply custom colors
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_x_log10() +
  scale_color_manual(values = continent_colors) +
  labs(title = "Custom Color Palette") +
  theme_elegant()

# Sequential palette for continuous variable
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = lifeExp)) +
  geom_point(size = 3) +
  scale_x_log10() +
  scale_color_gradient(
    low = "#fff7bc",
    high = "#d95f0e",
    name = "Life\nExpectancy"
  ) +
  labs(title = "Sequential Color Scale") +
  theme_elegant()

# Diverging palette
gapminder |>
  filter(year == 2007) |>
  mutate(diff = lifeExp - mean(lifeExp)) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = diff)) +
  geom_point(size = 3) +
  scale_x_log10() +
  scale_color_gradient2(
    low = "#2166ac",
    mid = "white",
    high = "#b2182b",
    midpoint = 0,
    name = "Deviation from\nGlobal Average"
  ) +
  labs(title = "Diverging Color Scale") +
  theme_elegant()


# ----------------------------------------------------------------------------
# PART 4: ADVANCED GEOMS
# ----------------------------------------------------------------------------

# Dumbbell chart with geom_segment
gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania", "Poland", "Germany"),
         year %in% c(1952, 2007)) |>
  select(country, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  ggplot(aes(y = reorder(country, `2007`))) +
  geom_segment(
    aes(x = `1952`, xend = `2007`, yend = country),
    linewidth = 2, color = "grey70"
  ) +
  geom_point(aes(x = `1952`), size = 5, color = "#e41a1c") +
  geom_point(aes(x = `2007`), size = 5, color = "#4daf4a") +
  labs(
    title = "Life Expectancy: 1952 vs 2007",
    subtitle = "Red = 1952 | Green = 2007",
    x = "Life Expectancy (years)",
    y = NULL
  ) +
  theme_elegant()

# Ribbon for uncertainty/range
gapminder |>
  group_by(year) |>
  summarize(
    avg = mean(lifeExp),
    min = min(lifeExp),
    max = max(lifeExp)
  ) |>
  ggplot(aes(x = year)) +
  geom_ribbon(aes(ymin = min, ymax = max), fill = "steelblue", alpha = 0.2) +
  geom_line(aes(y = avg), color = "steelblue", linewidth = 1.2) +
  labs(
    title = "Global Life Expectancy Range",
    subtitle = "Line = average, ribbon = min to max",
    x = NULL,
    y = "Life Expectancy"
  ) +
  theme_elegant()

# Heatmap with geom_tile
gapminder |>
  mutate(decade = floor(year / 10) * 10) |>
  group_by(continent, decade) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = factor(decade), y = continent, fill = avg_lifeExp)) +
  geom_tile(color = "white", linewidth = 1) +
  scale_fill_viridis_c(option = "plasma", name = "Avg Life\nExpectancy") +
  labs(
    title = "Life Expectancy by Continent and Decade",
    x = "Decade",
    y = NULL
  ) +
  theme_elegant() +
  theme(panel.grid = element_blank())


# ----------------------------------------------------------------------------
# PART 5: ADVANCED ANNOTATIONS
# ----------------------------------------------------------------------------

# Multiple annotation types
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "grey60", alpha = 0.6, size = 2) +

  # Highlight Latvia
  geom_point(
    data = filter(gapminder, year == 2007, country == "Latvia"),
    color = "#e41a1c", size = 5
  ) +

  # Curved arrow to Latvia
  annotate(
    "curve",
    x = 25000, xend = 11000,
    y = 66, yend = 71,
    curvature = -0.3,
    arrow = arrow(length = unit(0.3, "cm"), type = "closed"),
    color = "#e41a1c"
  ) +

  # Label for Latvia
  annotate(
    "text",
    x = 26000, y = 65,
    label = "Latvia: 71.9 years",
    color = "#e41a1c",
    fontface = "bold",
    hjust = 0,
    size = 4
  ) +

  # Shaded region annotation
  annotate(
    "rect",
    xmin = 30000, xmax = 55000,
    ymin = 78, ymax = 83,
    fill = "steelblue", alpha = 0.2
  ) +
  annotate(
    "text",
    x = 42000, y = 80.5,
    label = "High-income\nhigh-health\ncountries",
    size = 3, color = "steelblue"
  ) +

  scale_x_log10(labels = scales::comma) +
  labs(
    title = "GDP vs Life Expectancy with Annotations",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy"
  ) +
  theme_elegant()

# Using ggrepel for automatic label placement
library(ggrepel)

# Select countries to label
countries_to_label <- c("Japan", "Norway", "Latvia", "Sierra Leone",
                        "United States", "Brazil", "China")

gapminder |>
  filter(year == 2007) |>
  mutate(
    label = ifelse(country %in% countries_to_label, as.character(country), "")
  ) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, label = label)) +
  geom_point(color = "steelblue", alpha = 0.5, size = 2) +
  geom_point(
    data = . %>% filter(label != ""),
    color = "#e41a1c", size = 3
  ) +
  geom_text_repel(
    fontface = "bold",
    color = "#e41a1c",
    size = 3.5,
    box.padding = 0.5,
    point.padding = 0.3,
    segment.color = "grey50",
    max.overlaps = 20
  ) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Key Countries Labeled",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy"
  ) +
  theme_elegant()


# ----------------------------------------------------------------------------
# PART 6: FACET CUSTOMIZATION
# ----------------------------------------------------------------------------

# Styled facets
gapminder |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.3, color = "steelblue") +
  facet_wrap(~continent, nrow = 1) +
  labs(
    title = "Life Expectancy Trends by Continent",
    x = NULL,
    y = "Life Expectancy"
  ) +
  theme_elegant() +
  theme(
    strip.background = element_rect(fill = "steelblue", color = NA),
    strip.text = element_text(color = "white", face = "bold", size = 11),
    panel.spacing = unit(1, "lines")
  )

# Free scales for different ranges
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, fill = continent)) +
  geom_histogram(bins = 20, show.legend = FALSE) +
  scale_fill_manual(values = continent_colors) +
  facet_wrap(~continent, scales = "free", nrow = 2) +
  labs(title = "GDP Distribution by Continent (different scales)") +
  theme_elegant()


# ----------------------------------------------------------------------------
# PART 7: SCALE CUSTOMIZATION
# ----------------------------------------------------------------------------

# Custom breaks and labels
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", alpha = 0.7) +
  scale_x_log10(
    breaks = c(500, 2000, 10000, 50000),
    labels = c("$500", "$2K", "$10K", "$50K")
  ) +
  scale_y_continuous(
    breaks = seq(40, 85, 10),
    limits = c(35, 85)
  ) +
  labs(title = "Custom Axis Breaks and Labels") +
  theme_elegant()


# ----------------------------------------------------------------------------
# PART 8: PUBLICATION-READY FIGURE
# ----------------------------------------------------------------------------

# Create a polished, publication-ready visualization
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +

  # Background: all points muted
  geom_point(
    color = "grey85",
    size = 2
  ) +

  # Main layer: colored by continent
  geom_point(
    aes(color = continent, size = pop),
    alpha = 0.7
  ) +

  # Trend line
  geom_smooth(
    method = "loess",
    se = FALSE,
    color = "grey40",
    linewidth = 0.7,
    linetype = "dashed"
  ) +

  # Scales
  scale_x_log10(
    labels = scales::dollar_format(scale = 0.001, suffix = "K"),
    breaks = c(500, 2000, 10000, 50000)
  ) +
  scale_size_continuous(
    range = c(2, 15),
    guide = "none"
  ) +
  scale_color_manual(values = continent_colors) +

  # Labels
  labs(
    title = "The Global Wealth-Health Relationship",
    subtitle = "Each point is a country; size represents population",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy at Birth (years)",
    color = NULL,
    caption = "Data: Gapminder, 2007 | Dashed line shows overall trend"
  ) +

  # Theme
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 16, margin = margin(b = 5)),
    plot.subtitle = element_text(color = "grey40", size = 11, margin = margin(b = 15)),
    plot.caption = element_text(color = "grey50", size = 9, hjust = 0, margin = margin(t = 15)),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "grey92", linewidth = 0.3),
    legend.position = "bottom",
    legend.text = element_text(size = 10),
    axis.title = element_text(size = 11, color = "grey30"),
    axis.text = element_text(color = "grey40"),
    plot.margin = margin(20, 20, 15, 15)
  ) +
  guides(color = guide_legend(override.aes = list(size = 5)))


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Create your own custom theme
# Design a theme that reflects a specific style (corporate, minimalist, etc.)
# Apply it to at least 3 different chart types
# Your code here:


# Exercise 2: Design a custom color palette
# Create a 5-color palette that works well together
# Test it on categorical and continuous data
# Your code here:


# Exercise 3: Advanced annotations
# Create a scatter plot with:
# - At least 2 highlighted points
# - Text labels with arrows
# - A shaded region of interest
# - A reference line with annotation
# Your code here:


# Exercise 4: Heatmap
# Create a heatmap showing life expectancy
# by continent and year (not decade)
# Add proper styling and a good color scale
# Your code here:


# Exercise 5: Publication figure
# Create a complete, publication-ready figure
# Include all appropriate elements:
# - Clear title and subtitle
# - Properly labeled axes
# - Custom colors
# - Annotations where helpful
# - Caption with data source
# Your code here:


# ============================================================================
# END OF SCRIPT
# ============================================================================

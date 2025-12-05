# ============================================================================
# Module 05: Directing Audience Attention with Design
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# ----------------------------------------------------------------------------
# PART 1: PREATTENTIVE ATTRIBUTES
# ----------------------------------------------------------------------------

# Without attention direction - everything equal
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", size = 2) +
  scale_x_log10() +
  labs(title = "All points equal - no focus") +
  theme_minimal()

# With color to highlight one group
gapminder |>
  filter(year == 2007) |>
  mutate(highlight = continent == "Africa") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = highlight)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_x_log10() +
  scale_color_manual(values = c("FALSE" = "grey70", "TRUE" = "#e41a1c")) +
  labs(title = "African countries highlighted") +
  theme_minimal() +
  theme(legend.position = "none")


# ----------------------------------------------------------------------------
# PART 2: COLOR FOR EMPHASIS
# ----------------------------------------------------------------------------

# Highlight one bar
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg = mean(lifeExp)) |>
  mutate(is_lowest = avg == min(avg)) |>
  ggplot(aes(x = reorder(continent, avg), y = avg, fill = is_lowest)) +
  geom_col(width = 0.7) +
  coord_flip() +
  scale_fill_manual(values = c("FALSE" = "grey70", "TRUE" = "#e41a1c")) +
  labs(
    title = "Africa has significantly lower life expectancy",
    subtitle = "Average life expectancy by continent, 2007",
    x = NULL,
    y = "Life Expectancy (years)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  )

# Highlight one country in a list
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 15) |>
  mutate(is_japan = country == "Japan") |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp), fill = is_japan)) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = c("FALSE" = "grey70", "TRUE" = "#2171b5")) +
  labs(
    title = "Japan leads the world in life expectancy",
    x = "Life Expectancy (years)",
    y = NULL
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  )


# ----------------------------------------------------------------------------
# PART 3: SIZE FOR EMPHASIS
# ----------------------------------------------------------------------------

# Using size to draw attention
gapminder |>
  filter(year == 2007) |>
  mutate(is_latvia = country == "Latvia") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, size = is_latvia, color = is_latvia)) +
  geom_point(alpha = 0.7) +
  scale_size_manual(values = c("FALSE" = 2, "TRUE" = 6)) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "red")) +
  scale_x_log10() +
  labs(
    title = "Latvia's position in the world",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


# ----------------------------------------------------------------------------
# PART 4: ANNOTATIONS
# ----------------------------------------------------------------------------

# Adding text annotation
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "grey70", size = 2, alpha = 0.7) +
  # Highlight Latvia
  geom_point(
    data = gapminder |> filter(year == 2007, country == "Latvia"),
    color = "red", size = 5
  ) +
  # Add annotation
  annotate(
    "text",
    x = 15000, y = 68,
    label = "Latvia: 71.9 years\nGDP: $10,675",
    color = "red",
    hjust = 0,
    size = 3.5,
    fontface = "bold"
  ) +
  annotate(
    "segment",
    x = 14000, y = 70,
    xend = 11000, yend = 71.5,
    color = "red",
    arrow = arrow(length = unit(0.15, "cm"))
  ) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Latvia in Global Context",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# Adding a reference line with annotation
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_hline(yintercept = mean(gapminder$lifeExp[gapminder$year == 2007]),
             linetype = "dashed", color = "grey50") +
  geom_point(color = "steelblue", size = 2, alpha = 0.7) +
  annotate(
    "text",
    x = 400, y = 69,
    label = "Global average: 67 years",
    hjust = 0,
    color = "grey40"
  ) +
  scale_x_log10() +
  labs(title = "Life Expectancy with Global Average Reference") +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 5: VISUAL HIERARCHY WITH LAYERS
# ----------------------------------------------------------------------------

# Build from background to foreground
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  # Layer 1: All points (background, subdued)
  geom_point(color = "grey85", size = 2) +
  # Layer 2: European points (middle layer)
  geom_point(
    data = gapminder |> filter(year == 2007, continent == "Europe"),
    color = "steelblue", size = 2.5, alpha = 0.8
  ) +
  # Layer 3: Latvia (foreground, highlighted)
  geom_point(
    data = gapminder |> filter(year == 2007, country == "Latvia"),
    color = "red", size = 5
  ) +
  scale_x_log10() +
  labs(
    title = "Latvia Among European Nations",
    subtitle = "Grey = World | Blue = Europe | Red = Latvia",
    x = "GDP per Capita",
    y = "Life Expectancy"
  ) +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 6: DIRECT LABELING (Instead of legends)
# ----------------------------------------------------------------------------

# Create trend data
continent_trends <- gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop")

# End points for labels
end_points <- continent_trends |>
  filter(year == max(year))

# Line chart with direct labels
continent_trends |>
  ggplot(aes(x = year, y = avg_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  geom_text(
    data = end_points,
    aes(label = continent, x = year + 1.5),
    hjust = 0,
    fontface = "bold",
    size = 3.5
  ) +
  scale_x_continuous(
    limits = c(1952, 2015),
    breaks = seq(1952, 2007, 10)
  ) +
  labs(
    title = "Life Expectancy Trends by Continent",
    x = NULL,
    y = "Average Life Expectancy"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


# ----------------------------------------------------------------------------
# PART 7: HIGHLIGHTING IN LINE CHARTS
# ----------------------------------------------------------------------------

# Highlight one country's trend
gapminder |>
  filter(continent == "Europe") |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  # Background: all countries (grey)
  geom_line(color = "grey80", alpha = 0.5) +
  # Foreground: Latvia (colored, thick)
  geom_line(
    data = gapminder |> filter(country == "Latvia"),
    color = "#e41a1c", linewidth = 1.5
  ) +
  # Label at end
  annotate(
    "text",
    x = 2008, y = 71.9,
    label = "Latvia",
    color = "#e41a1c",
    hjust = 0,
    fontface = "bold"
  ) +
  labs(
    title = "Latvia's Life Expectancy Compared to Europe",
    x = NULL,
    y = "Life Expectancy"
  ) +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 8: COMPLETE EXAMPLE - PUTTING IT ALL TOGETHER
# ----------------------------------------------------------------------------

# Comprehensive example with multiple attention-directing techniques

# Prepare data
baltic_data <- gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania")) |>
  mutate(is_latvia = country == "Latvia")

# Get end points for labels
baltic_end <- baltic_data |>
  filter(year == max(year))

# Create the visualization
baltic_data |>
  ggplot(aes(x = year, y = lifeExp, color = is_latvia, group = country)) +
  # Lines with different styling based on highlight
  geom_line(aes(linewidth = is_latvia), alpha = 0.8) +
  geom_point(aes(size = is_latvia)) +
  # Direct labels
  geom_text(
    data = baltic_end,
    aes(label = country, x = year + 1),
    hjust = 0,
    fontface = "bold",
    size = 3.5
  ) +
  # Scales
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "#e41a1c")) +
  scale_linewidth_manual(values = c("FALSE" = 0.8, "TRUE" = 1.5)) +
  scale_size_manual(values = c("FALSE" = 1.5, "TRUE" = 3)) +
  scale_x_continuous(
    limits = c(1952, 2012),
    breaks = seq(1952, 2007, 10)
  ) +
  # Labels
  labs(
    title = "Latvia's Life Expectancy Journey",
    subtitle = "Compared to fellow Baltic states Estonia and Lithuania",
    x = NULL,
    y = "Life Expectancy (years)",
    caption = "Source: Gapminder"
  ) +
  # Theme
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40"),
    panel.grid.minor = element_blank()
  )


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Highlight one continent
# Create a bar chart of average GDP per capita by continent
# Highlight only Oceania (highest) in a different color
# All others should be grey
# Your code:


# Exercise 2: Add an annotation
# Create a scatter plot of GDP vs Life Expectancy (2007)
# Add an annotation pointing to a country of your choice
# Include an arrow and explanatory text
# Your code:


# Exercise 3: Create visual hierarchy with layers
# Use gapminder 2007 data to create a scatter plot where:
# - All countries are grey (background)
# - African countries are orange (middle)
# - One specific African country is red and larger (foreground)
# Your code:


# Exercise 4: Direct labeling
# Create a line chart showing life expectancy over time
# for 4-5 countries of your choice
# Use direct labels instead of a legend
# Highlight one country with different color/thickness
# Your code:


# Exercise 5: Comprehensive attention direction
# Create a visualization that uses at least 4 different
# attention-directing techniques:
# - Color
# - Size
# - Position/ordering
# - Annotation
# Choose your own data and story
# Your code:


# ============================================================================
# END OF SCRIPT
# ============================================================================

# ============================================================================
# Module 06: Creating Visual Narratives
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# ----------------------------------------------------------------------------
# PART 1: THE THREE-ACT STRUCTURE
# ----------------------------------------------------------------------------

# ACT 1: SETUP - Establish context
# "Life expectancy has improved globally..."

act1_setup <- gapminder |>
  group_by(year) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = year, y = avg_lifeExp)) +
  geom_line(linewidth = 1.5, color = "steelblue") +
  geom_point(size = 2, color = "steelblue") +
  labs(
    title = "The World is Getting Healthier",
    subtitle = "Global average life expectancy has risen steadily since 1952",
    x = NULL,
    y = "Average Life Expectancy (years)"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

act1_setup

# ACT 2: CONFRONTATION - Introduce tension
# "...but not equally everywhere"

act2_tension <- gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg_lifeExp, color = continent)) +
  geom_line(linewidth = 1.2) +
  labs(
    title = "But the Gap Remains",
    subtitle = "Continents have improved at different rates",
    x = NULL,
    y = "Average Life Expectancy",
    color = "Continent"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )

act2_tension

# ACT 3: RESOLUTION - Deliver insight
# "Here's what we can learn"

# Find the biggest improvers
biggest_gains <- gapminder |>
  filter(year %in% c(1952, 2007)) |>
  select(country, continent, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  mutate(improvement = `2007` - `1952`) |>
  slice_max(improvement, n = 10)

act3_resolution <- biggest_gains |>
  ggplot(aes(x = improvement, y = reorder(country, improvement), fill = continent)) +
  geom_col() +
  labs(
    title = "Success Stories: Countries with Greatest Gains",
    subtitle = "Life expectancy improvement from 1952 to 2007",
    x = "Years of life gained",
    y = NULL,
    fill = "Continent"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )

act3_resolution


# ----------------------------------------------------------------------------
# PART 2: NARRATIVE PATTERN - THE JOURNEY
# ----------------------------------------------------------------------------

# Latvia's journey through time

latvia_journey <- gapminder |>
  filter(country == "Latvia") |>
  ggplot(aes(x = year, y = lifeExp)) +
  # The line
  geom_line(linewidth = 1.2, color = "steelblue") +
  geom_point(size = 2.5, color = "steelblue") +
  # Highlight the crisis period
  annotate("rect",
           xmin = 1987, xmax = 1997,
           ymin = -Inf, ymax = Inf,
           alpha = 0.15, fill = "red") +
  # Annotations
  annotate("text", x = 1957, y = 68.5,
           label = "Soviet era:\nSteady improvement",
           hjust = 0, size = 3, color = "grey40") +
  annotate("text", x = 1992, y = 65,
           label = "Independence\n& transition",
           hjust = 0.5, size = 3, color = "red") +
  annotate("text", x = 2003, y = 73,
           label = "Recovery\nbegins",
           hjust = 0, size = 3, color = "steelblue") +
  labs(
    title = "Latvia's Life Expectancy: A Story of Resilience",
    subtitle = "The journey from Soviet era through transition to recovery",
    x = NULL,
    y = "Life Expectancy (years)",
    caption = "Source: Gapminder"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

latvia_journey


# ----------------------------------------------------------------------------
# PART 3: NARRATIVE PATTERN - THE COMPARISON
# ----------------------------------------------------------------------------

# Compare Baltic states
baltic_comparison <- gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania")) |>
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_color_manual(values = c(
    "Latvia" = "#e41a1c",
    "Estonia" = "#377eb8",
    "Lithuania" = "#4daf4a"
  )) +
  labs(
    title = "Three Nations, One Story",
    subtitle = "Baltic states share remarkably similar trajectories",
    x = NULL,
    y = "Life Expectancy",
    color = NULL
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )

baltic_comparison


# ----------------------------------------------------------------------------
# PART 4: NARRATIVE PATTERN - THE ZOOM
# ----------------------------------------------------------------------------

# Start broad, end specific

# Zoom Level 1: The World
zoom1_world <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.4, color = "grey60") +
  scale_x_log10() +
  labs(
    title = "Level 1: The World",
    subtitle = "Every country in 2007",
    x = "GDP per Capita (log)", y = "Life Expectancy"
  ) +
  theme_minimal()

# Zoom Level 2: Europe
zoom2_europe <- gapminder |>
  filter(year == 2007) |>
  mutate(is_europe = continent == "Europe") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = is_europe, alpha = is_europe)) +
  geom_point(size = 2) +
  scale_x_log10() +
  scale_color_manual(values = c("FALSE" = "grey80", "TRUE" = "steelblue")) +
  scale_alpha_manual(values = c("FALSE" = 0.3, "TRUE" = 1)) +
  labs(
    title = "Level 2: Focus on Europe",
    subtitle = "European countries highlighted",
    x = "GDP per Capita (log)", y = "Life Expectancy"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Zoom Level 3: Latvia
zoom3_latvia <- gapminder |>
  filter(year == 2007, continent == "Europe") |>
  mutate(is_latvia = country == "Latvia") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = is_latvia, size = is_latvia)) +
  geom_point() +
  scale_color_manual(values = c("FALSE" = "grey70", "TRUE" = "#e41a1c")) +
  scale_size_manual(values = c("FALSE" = 2, "TRUE" = 5)) +
  scale_x_log10() +
  annotate("text", x = 13000, y = 69,
           label = "Latvia", color = "#e41a1c", fontface = "bold") +
  labs(
    title = "Level 3: Latvia in Europe",
    subtitle = "Latvia's position among European nations",
    x = "GDP per Capita (log)", y = "Life Expectancy"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Show the sequence
zoom1_world
zoom2_europe
zoom3_latvia


# ----------------------------------------------------------------------------
# PART 5: COMPLETE NARRATIVE - "The Tale of Two Countries"
# ----------------------------------------------------------------------------

# Two countries with very different paths

# Chart 1: The Starting Point (Hook)
chart1_hook <- gapminder |>
  filter(country %in% c("Kuwait", "Afghanistan"), year == 1952) |>
  ggplot(aes(x = country, y = lifeExp, fill = country)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = round(lifeExp, 1)), vjust = -0.5, size = 4) +
  scale_fill_manual(values = c("Kuwait" = "#2171b5", "Afghanistan" = "#e41a1c")) +
  labs(
    title = "1952: Two Countries Start Differently",
    subtitle = "Life expectancy at the beginning of our data",
    x = NULL,
    y = "Life Expectancy (years)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Chart 2: The Journey (Tension)
chart2_journey <- gapminder |>
  filter(country %in% c("Kuwait", "Afghanistan")) |>
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Kuwait" = "#2171b5", "Afghanistan" = "#e41a1c")) +
  labs(
    title = "The Paths Diverge...",
    subtitle = "How oil wealth vs. conflict shaped national health",
    x = NULL,
    y = "Life Expectancy",
    color = NULL
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Chart 3: The Gap (Insight)
chart3_gap <- gapminder |>
  filter(country %in% c("Kuwait", "Afghanistan"), year == 2007) |>
  ggplot(aes(x = country, y = lifeExp, fill = country)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = round(lifeExp, 1)), vjust = -0.5, size = 4) +
  scale_fill_manual(values = c("Kuwait" = "#2171b5", "Afghanistan" = "#e41a1c")) +
  annotate("segment",
           x = 1, xend = 2, y = 78, yend = 78,
           arrow = arrow(ends = "both", length = unit(0.2, "cm"))) +
  annotate("text", x = 1.5, y = 80,
           label = "35 year gap", fontface = "bold") +
  labs(
    title = "2007: A 35-Year Gap in Life Expectancy",
    subtitle = "Context matters: oil wealth vs. decades of conflict",
    x = NULL,
    y = "Life Expectancy (years)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Show the narrative sequence
chart1_hook
chart2_journey
chart3_gap


# ----------------------------------------------------------------------------
# PART 6: BUILDING CONTEXT WITH REFERENCE
# ----------------------------------------------------------------------------

# Show Latvia in context of European average

europe_avg <- gapminder |>
  filter(continent == "Europe") |>
  group_by(year) |>
  summarize(europe_avg = mean(lifeExp))

latvia_in_context <- gapminder |>
  filter(country == "Latvia") |>
  left_join(europe_avg, by = "year") |>
  ggplot(aes(x = year)) +
  # European average as reference
  geom_line(aes(y = europe_avg), linetype = "dashed",
            color = "grey50", linewidth = 1) +
  # Latvia's actual line
  geom_line(aes(y = lifeExp), color = "#e41a1c", linewidth = 1.2) +
  geom_point(aes(y = lifeExp), color = "#e41a1c", size = 2) +
  # Labels
  annotate("text", x = 2007, y = 79,
           label = "European\naverage", hjust = 1, size = 3, color = "grey50") +
  annotate("text", x = 2007, y = 72,
           label = "Latvia", hjust = 1, size = 3, color = "#e41a1c",
           fontface = "bold") +
  labs(
    title = "Latvia Below European Average",
    subtitle = "Dashed line = European average; Red = Latvia",
    x = NULL,
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

latvia_in_context


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Create a Three-Act Story
# Choose a continent or country and create three visualizations:
# - Act 1: Setup (establish context)
# - Act 2: Confrontation (show the interesting finding)
# - Act 3: Resolution (deliver insight)
# Your code here:


# Exercise 2: The Comparison Story
# Compare two or more countries with different outcomes
# Make it clear why their paths diverged
# Your code here:


# Exercise 3: The Journey Story
# Pick a country and show its "journey" over time
# Add annotations for key historical moments
# Your code here:


# Exercise 4: The Zoom Pattern
# Create a three-chart sequence that zooms from:
# - World → Continent → Country
# Make each level reveal something new
# Your code here:


# Exercise 5: Full Narrative
# Plan and create a complete data story with:
# - A hook (grabbing attention)
# - Context (background needed)
# - Tension (the interesting question)
# - Insight (the key finding)
# Use at least 3 linked visualizations
# Your code here:


# ============================================================================
# END OF SCRIPT
# ============================================================================

# ============================================================================
# Module 02: Choosing the Right Visualization
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# ----------------------------------------------------------------------------
# PART 1: COMPARISON CHARTS
# ----------------------------------------------------------------------------

# Vertical bar chart: Average life expectancy by continent
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = continent, y = avg_lifeExp)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Average Life Expectancy by Continent (2007)",
    x = "Continent",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# Horizontal bar chart: Top 10 countries by life expectancy
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Top 10 Countries by Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = NULL
  ) +
  theme_minimal()

# Dot plot (Cleveland dot plot) - often cleaner than bars
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 4, color = "steelblue") +
  labs(
    title = "Top 10 Countries by Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = NULL
  ) +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 2: DISTRIBUTION CHARTS
# ----------------------------------------------------------------------------

# Histogram
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = "Number of Countries"
  ) +
  theme_minimal()

# Density plot
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_density(fill = "steelblue", alpha = 0.7) +
  labs(
    title = "Distribution of Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = "Density"
  ) +
  theme_minimal()

# Overlapping density plots for comparison
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Life Expectancy Distribution by Continent (2007)",
    x = "Life Expectancy (years)",
    fill = "Continent"
  ) +
  theme_minimal()

# Boxplot
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7) +
  labs(
    title = "Life Expectancy by Continent (2007)",
    x = "Continent",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# Violin plot with boxplot overlay
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_violin(fill = "steelblue", alpha = 0.5) +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(
    title = "Life Expectancy Distribution by Continent (2007)",
    x = "Continent",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 3: RELATIONSHIP CHARTS
# ----------------------------------------------------------------------------

# Basic scatter plot
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  labs(
    title = "GDP vs Life Expectancy (2007)",
    x = "GDP per Capita",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# Scatter plot with log scale (better for GDP)
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "GDP vs Life Expectancy (2007)",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# With trend line
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "loess", se = TRUE, color = "red") +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "GDP vs Life Expectancy with Trend (2007)",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# Colored by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "GDP vs Life Expectancy by Continent (2007)",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)",
    color = "Continent"
  ) +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 4: TIME SERIES CHARTS
# ----------------------------------------------------------------------------

# Single line: World average
gapminder |>
  group_by(year) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = year, y = avg_lifeExp)) +
  geom_line(linewidth = 1.2, color = "steelblue") +
  geom_point(size = 2, color = "steelblue") +
  labs(
    title = "Global Average Life Expectancy Over Time",
    x = "Year",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# Multiple lines: By continent
gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(
    title = "Life Expectancy by Continent Over Time",
    x = "Year",
    y = "Life Expectancy (years)",
    color = "Continent"
  ) +
  theme_minimal()

# Single country over time
gapminder |>
  filter(country == "Latvia") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line(linewidth = 1, color = "steelblue") +
  geom_point(size = 2, color = "steelblue") +
  labs(
    title = "Life Expectancy in Latvia Over Time",
    x = "Year",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()


# ----------------------------------------------------------------------------
# PART 5: FACETED CHARTS
# ----------------------------------------------------------------------------

# facet_wrap: Distribution by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(bins = 15, fill = "steelblue", color = "white") +
  facet_wrap(~continent, scales = "free_y") +
  labs(
    title = "Life Expectancy Distribution by Continent (2007)",
    x = "Life Expectancy (years)",
    y = "Count"
  ) +
  theme_minimal()

# facet_wrap: Country trends by continent
gapminder |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.4, color = "steelblue") +
  facet_wrap(~continent) +
  labs(
    title = "Life Expectancy Trends by Continent",
    subtitle = "Each line represents a country",
    x = "Year",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal()

# facet_grid: Continent by year
gapminder |>
  filter(year %in% c(1952, 1982, 2007)) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7, color = "steelblue") +
  scale_x_log10() +
  facet_grid(continent ~ year) +
  labs(
    title = "GDP vs Life Expectancy: Continent by Year",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)"
  ) +
  theme_bw()


# ----------------------------------------------------------------------------
# PART 6: CHART TYPE COMPARISON
# ----------------------------------------------------------------------------

# The same data, different chart types

# Data: Life expectancy by continent in 2007
continent_summary <- gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(
    avg = mean(lifeExp),
    min = min(lifeExp),
    max = max(lifeExp)
  )

# Version 1: Bar chart (most common)
continent_summary |>
  ggplot(aes(x = continent, y = avg)) +
  geom_col(fill = "steelblue") +
  labs(title = "Bar Chart") +
  theme_minimal()

# Version 2: Dot plot (cleaner, preferred by many)
continent_summary |>
  ggplot(aes(x = avg, y = continent)) +
  geom_point(size = 4, color = "steelblue") +
  labs(title = "Dot Plot") +
  theme_minimal()

# Version 3: Lollipop chart (combination)
continent_summary |>
  ggplot(aes(x = avg, y = continent)) +
  geom_segment(aes(x = 0, xend = avg, yend = continent), color = "grey50") +
  geom_point(size = 4, color = "steelblue") +
  labs(title = "Lollipop Chart") +
  theme_minimal()


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Create a horizontal bar chart showing the 10 countries
# with the LOWEST life expectancy in 2007
# Your code here:


# Exercise 2: Create a violin plot with embedded boxplot comparing
# GDP per capita across continents (use log scale on y-axis!)
# Hint: scale_y_log10()
# Your code here:


# Exercise 3: Create a scatter plot showing population vs GDP per capita (2007)
# - Color by continent
# - Use log scale on both axes
# - Add appropriate labels
# Your code here:


# Exercise 4: Create a faceted line chart showing life expectancy over time
# for Baltic countries: Estonia, Latvia, Lithuania
# Hint: filter(country %in% c("Estonia", "Latvia", "Lithuania"))
# Your code here:


# Exercise 5: For the gapminder 2007 data, create THREE different visualizations
# showing the same information (life expectancy by continent):
# a) Boxplot
# b) Violin plot
# c) Bar chart with error bars (geom_errorbar)
# Which do you think communicates most effectively?
# Your code here:


# ============================================================================
# END OF SCRIPT
# ============================================================================

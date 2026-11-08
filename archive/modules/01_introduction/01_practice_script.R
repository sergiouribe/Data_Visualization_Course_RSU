# ============================================================================
# Module 01: Introduction to Data Visualization and Storytelling
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# ----------------------------------------------------------------------------
# PART 1: Exploring the Gapminder Dataset
# ----------------------------------------------------------------------------

# View the data
gapminder

# Structure of the data
glimpse(gapminder)

# Summary statistics
summary(gapminder)

# What years are included?
gapminder |>
  distinct(year)

# What continents?
gapminder |>
  distinct(continent)

# How many countries per continent?
gapminder |>
  filter(year == 2007) |>
  count(continent)


# ----------------------------------------------------------------------------
# PART 2: Your First Scatter Plot
# ----------------------------------------------------------------------------

# Basic scatter plot: GDP vs Life Expectancy
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()


# ----------------------------------------------------------------------------
# PART 3: Adding Visual Elements
# ----------------------------------------------------------------------------

# Add color by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point()

# Add size by population
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point()

# Add transparency (alpha) to see overlapping points
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7)


# ----------------------------------------------------------------------------
# PART 4: Different Geoms (Geometries)
# ----------------------------------------------------------------------------

# Line chart: Life expectancy over time for Latvia
gapminder |>
  filter(country == "Latvia") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line()

# Add points to the line
gapminder |>
  filter(country == "Latvia") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line() +
  geom_point()

# Bar chart: Count of countries by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent)) +
  geom_bar()

# Histogram: Distribution of life expectancy
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(bins = 20)

# Boxplot: Life expectancy by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()


# ----------------------------------------------------------------------------
# PART 5: Inside aes() vs Outside aes()
# ----------------------------------------------------------------------------

# INSIDE aes(): Map variable to aesthetic (color varies by data)
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point()

# OUTSIDE aes(): Fixed value (all points same color)
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", size = 3)


# ----------------------------------------------------------------------------
# PART 6: Adding Labels and Titles
# ----------------------------------------------------------------------------

gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  labs(
    title = "Wealth and Health of Nations",
    subtitle = "Data from 2007 | Each point is a country",
    x = "GDP per Capita (USD)",
    y = "Life Expectancy (years)",
    color = "Continent",
    size = "Population",
    caption = "Source: Gapminder"
  )


# ----------------------------------------------------------------------------
# PART 7: Using Themes
# ----------------------------------------------------------------------------

# Create a base plot
base_plot <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  labs(title = "GDP vs Life Expectancy")

# Default theme
base_plot

# Minimal theme
base_plot + theme_minimal()

# Black and white theme
base_plot + theme_bw()

# Classic theme
base_plot + theme_classic()


# ----------------------------------------------------------------------------
# PART 8: Log Scales (for skewed data like GDP)
# ----------------------------------------------------------------------------

# Without log scale - hard to see patterns
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# With log scale - much clearer!
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()


# ----------------------------------------------------------------------------
# PART 9: Putting It All Together
# ----------------------------------------------------------------------------

# A polished visualization
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  scale_size_continuous(labels = scales::comma, guide = "none") +
  labs(
    title = "The Wealth-Health Connection",
    subtitle = "Richer countries tend to have higher life expectancy (2007)",
    x = "GDP per Capita (USD, log scale)",
    y = "Life Expectancy (years)",
    color = "Continent",
    caption = "Source: Gapminder | Point size = population"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Create a scatter plot showing population vs GDP per capita for 2007
# Hint: filter(year == 2007), aes(x = pop, y = gdpPercap)
# Your code here:


# Exercise 2: Create a line chart showing how GDP per capita changed over time
# for your home country (or pick a country like "Germany" or "Brazil")
# Your code here:


# Exercise 3: Create a histogram of population for 2007
# What do you notice about the distribution?
# Your code here:


# Exercise 4: Create a boxplot comparing life expectancy across continents for 1952 vs 2007
# Hint: filter(year %in% c(1952, 2007)) and consider facet_wrap(~year)
# Your code here:


# Exercise 5: Create a complete, polished visualization
# Choose your variables, add appropriate labels, pick a theme
# Make it something you would show in a presentation!
# Your code here:


# ============================================================================
# END OF SCRIPT
# ============================================================================

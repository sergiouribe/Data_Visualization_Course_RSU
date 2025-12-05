# ============================================================================
# Module 03: Fundamentals of Data Wrangling
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# ----------------------------------------------------------------------------
# PART 1: FILTERING ROWS
# ----------------------------------------------------------------------------

# Filter to year 2007
gapminder |>
  filter(year == 2007)

# Filter to European countries
gapminder |>
  filter(continent == "Europe")

# Multiple conditions with AND
gapminder |>
  filter(year == 2007, continent == "Europe")

# Multiple conditions with OR
gapminder |>
  filter(continent == "Europe" | continent == "Asia")

# Using %in% for multiple values
gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania"))

# Numeric comparisons
gapminder |>
  filter(year == 2007, lifeExp > 80)

# Combining conditions
gapminder |>
  filter(year == 2007, continent == "Africa", lifeExp < 50)


# ----------------------------------------------------------------------------
# PART 2: SELECTING COLUMNS
# ----------------------------------------------------------------------------

# Keep specific columns
gapminder |>
  select(country, year, lifeExp)

# Drop columns
gapminder |>
  select(-pop, -gdpPercap)

# Select a range
gapminder |>
  select(country:lifeExp)

# Helper functions
gapminder |>
  select(starts_with("co"))

gapminder |>
  select(ends_with("Exp"))

gapminder |>
  select(contains("p"))

# Rename while selecting
gapminder |>
  select(country, life_expectancy = lifeExp, year)


# ----------------------------------------------------------------------------
# PART 3: CREATING NEW VARIABLES WITH MUTATE
# ----------------------------------------------------------------------------

# Create new columns
gapminder |>
  mutate(
    gdp = gdpPercap * pop,
    pop_millions = pop / 1e6
  )

# Transform existing columns
gapminder |>
  mutate(
    gdpPercap_log = log10(gdpPercap),
    lifeExp_rounded = round(lifeExp, 0)
  )

# Conditional values with case_when
gapminder |>
  filter(year == 2007) |>
  mutate(
    life_category = case_when(
      lifeExp < 50 ~ "Low",
      lifeExp < 70 ~ "Medium",
      TRUE ~ "High"
    )
  ) |>
  select(country, lifeExp, life_category)

# Conditional values with if_else
gapminder |>
  mutate(
    is_europe = if_else(continent == "Europe", "Yes", "No")
  ) |>
  select(country, continent, is_europe)


# ----------------------------------------------------------------------------
# PART 4: SORTING WITH ARRANGE
# ----------------------------------------------------------------------------

# Sort ascending
gapminder |>
  filter(year == 2007) |>
  arrange(lifeExp) |>
  head(10)

# Sort descending
gapminder |>
  filter(year == 2007) |>
  arrange(desc(lifeExp)) |>
  head(10)

# Sort by multiple columns
gapminder |>
  filter(year == 2007) |>
  arrange(continent, desc(lifeExp))

# Get top n using slice_max
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 5)

# Get bottom n using slice_min
gapminder |>
  filter(year == 2007) |>
  slice_min(lifeExp, n = 5)


# ----------------------------------------------------------------------------
# PART 5: SUMMARIZING DATA
# ----------------------------------------------------------------------------

# Basic summaries
gapminder |>
  filter(year == 2007) |>
  summarize(
    mean_lifeExp = mean(lifeExp),
    median_lifeExp = median(lifeExp),
    min_lifeExp = min(lifeExp),
    max_lifeExp = max(lifeExp),
    sd_lifeExp = sd(lifeExp),
    n_countries = n()
  )


# ----------------------------------------------------------------------------
# PART 6: GROUPED OPERATIONS
# ----------------------------------------------------------------------------

# Summary by continent
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(
    mean_lifeExp = mean(lifeExp),
    n_countries = n()
  )

# Multiple grouping variables
gapminder |>
  group_by(continent, year) |>
  summarize(
    mean_lifeExp = mean(lifeExp),
    .groups = "drop"
  )

# Grouped mutate
gapminder |>
  group_by(continent, year) |>
  mutate(
    continent_avg = mean(lifeExp),
    diff_from_avg = lifeExp - continent_avg
  ) |>
  ungroup() |>
  select(country, continent, year, lifeExp, continent_avg, diff_from_avg)


# ----------------------------------------------------------------------------
# PART 7: COUNTING
# ----------------------------------------------------------------------------

# Count by group
gapminder |>
  filter(year == 2007) |>
  count(continent)

# Count with sorting
gapminder |>
  filter(year == 2007) |>
  count(continent, sort = TRUE)

# Count distinct values
gapminder |>
  summarize(
    n_countries = n_distinct(country),
    n_years = n_distinct(year)
  )


# ----------------------------------------------------------------------------
# PART 8: RESHAPING DATA
# ----------------------------------------------------------------------------

# Create a subset for demonstration
baltic <- gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania")) |>
  select(country, year, lifeExp)

baltic

# Pivot wider: long to wide
baltic_wide <- baltic |>
  pivot_wider(
    names_from = year,
    values_from = lifeExp
  )

baltic_wide

# Pivot longer: wide to long
baltic_wide |>
  pivot_longer(
    cols = -country,
    names_to = "year",
    values_to = "lifeExp"
  )


# ----------------------------------------------------------------------------
# PART 9: COMBINING OPERATIONS
# ----------------------------------------------------------------------------

# Complex data preparation example
gapminder |>
  # Filter to 2007
  filter(year == 2007) |>
  # Select and create variables
  mutate(
    gdp = gdpPercap * pop,
    pop_millions = pop / 1e6,
    income_level = case_when(
      gdpPercap < 5000 ~ "Low",
      gdpPercap < 15000 ~ "Middle",
      TRUE ~ "High"
    )
  ) |>
  # Group and summarize
  group_by(continent, income_level) |>
  summarize(
    n_countries = n(),
    avg_lifeExp = mean(lifeExp),
    .groups = "drop"
  ) |>
  # Sort for presentation
  arrange(continent, income_level)


# ----------------------------------------------------------------------------
# PART 10: DATA WRANGLING FOR VISUALIZATION
# ----------------------------------------------------------------------------

# Example 1: Top 10 bar chart
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

# Example 2: Trend lines with grouped summary
gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  geom_point() +
  labs(
    title = "Life Expectancy Trends by Continent",
    x = "Year",
    y = "Average Life Expectancy",
    color = "Continent"
  ) +
  theme_minimal()

# Example 3: Categories for comparison
gapminder |>
  filter(year == 2007) |>
  mutate(
    income_level = case_when(
      gdpPercap < 5000 ~ "Low",
      gdpPercap < 15000 ~ "Middle",
      TRUE ~ "High"
    ),
    income_level = factor(income_level, levels = c("Low", "Middle", "High"))
  ) |>
  ggplot(aes(x = income_level, y = lifeExp, fill = income_level)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Life Expectancy by Income Level (2007)",
    x = "Income Level",
    y = "Life Expectancy (years)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Filter gapminder to Baltic countries after 1990
# Expected: Latvia, Estonia, Lithuania from 1992 and 1997 and 2002 and 2007
# Your code here:


# Exercise 2: Create a dataset with country, year, and pop_category
# pop_category = "Large" if pop > 50 million, else "Small"
# Your code here:


# Exercise 3: Calculate mean, min, max GDP per capita by continent in 2007
# Your code here:


# Exercise 4: Full pipeline - create a bar chart of total GDP by continent
# Steps: filter 2007, create gdp column, group by continent, sum gdp, plot
# Your code here:


# Exercise 5: Create a table showing life expectancy for Baltic countries
# Rows = countries, Columns = years (using pivot_wider)
# Your code here:


# Bonus Exercise: Find which country in each continent had the largest
# increase in life expectancy between 1952 and 2007
# Hint: Use filter, pivot_wider, mutate to calculate change, group_by, slice_max
# Your code here:


# ============================================================================
# END OF SCRIPT
# ============================================================================

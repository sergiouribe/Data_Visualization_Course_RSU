# ============================================================================
# Module 04: Simplifying Visuals and Removing Clutter
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# ----------------------------------------------------------------------------
# PART 1: THE PROBLEM - BEFORE (CLUTTERED)
# ----------------------------------------------------------------------------

# A cluttered chart - many elements, hard to read
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = continent, y = avg_lifeExp, fill = continent)) +
  geom_col(color = "black", linewidth = 1) +
  geom_text(aes(label = round(avg_lifeExp, 2)), vjust = -0.5, size = 3) +
  labs(
    title = "Average Life Expectancy by Continent",
    subtitle = "Data from Gapminder Project, Year 2007",
    x = "Continent",
    y = "Average Life Expectancy (Years)",
    fill = "Continent",
    caption = "Source: Gapminder | Chart created in R"
  ) +
  theme_gray()


# ----------------------------------------------------------------------------
# PART 2: THE SOLUTION - AFTER (CLEAN)
# ----------------------------------------------------------------------------

# The same data, simplified
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = reorder(continent, avg_lifeExp), y = avg_lifeExp)) +
  geom_col(fill = "steelblue", width = 0.7) +
  geom_text(aes(label = round(avg_lifeExp, 1)), hjust = -0.2) +
  coord_flip() +
  labs(
    title = "Life Expectancy by Continent (2007)",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank()
  )


# ----------------------------------------------------------------------------
# PART 3: COMPARING THEMES
# ----------------------------------------------------------------------------

# Create a base plot
base_plot <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  scale_x_log10()

# Default theme
base_plot +
  labs(title = "Default theme - busy")

# theme_minimal - cleaner
base_plot +
  theme_minimal() +
  labs(title = "theme_minimal - cleaner")

# theme_classic - very clean
base_plot +
  theme_classic() +
  labs(title = "theme_classic - traditional")

# theme_bw - black and white
base_plot +
  theme_bw() +
  labs(title = "theme_bw - print-ready")


# ----------------------------------------------------------------------------
# PART 4: REMOVING GRID LINES
# ----------------------------------------------------------------------------

# Default - too many lines
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  theme_minimal() +
  labs(title = "With all grid lines")

# Remove minor grid lines
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  theme_minimal() +
  theme(panel.grid.minor = element_blank()) +
  labs(title = "Minor grid lines removed")

# Remove vertical grid lines
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank()
  ) +
  labs(title = "Only horizontal grid lines")


# ----------------------------------------------------------------------------
# PART 5: REMOVING REDUNDANT LEGENDS
# ----------------------------------------------------------------------------

# Redundant legend - color matches axis labels
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg = mean(lifeExp)) |>
  ggplot(aes(x = continent, y = avg, fill = continent)) +
  geom_col() +
  labs(title = "Redundant legend")

# Better - remove the legend
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg = mean(lifeExp)) |>
  ggplot(aes(x = continent, y = avg, fill = continent)) +
  geom_col() +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title = "Legend removed - cleaner")


# ----------------------------------------------------------------------------
# PART 6: STRATEGIC COLOR USE
# ----------------------------------------------------------------------------

# Too many colors - no focus
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp), fill = country)) +
  geom_col() +
  labs(title = "Too many colors - no focus") +
  theme_minimal() +
  theme(legend.position = "none")

# Single color - clean
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_col(fill = "steelblue") +
  labs(title = "Single color - clean", x = NULL, y = NULL) +
  theme_minimal() +
  theme(panel.grid.major.y = element_blank())

# Highlight with color
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
    title = "Africa has the lowest life expectancy",
    x = NULL, y = "Average Life Expectancy"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  )


# ----------------------------------------------------------------------------
# PART 7: CUSTOM CLEAN THEME
# ----------------------------------------------------------------------------

# Define a custom minimal theme
theme_clean <- function() {
  theme_minimal(base_size = 12) +
    theme(
      # Typography
      plot.title = element_text(face = "bold", size = 14, margin = margin(b = 10)),
      plot.subtitle = element_text(color = "grey40", margin = margin(b = 15)),

      # Grid lines
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey90", linewidth = 0.3),

      # Axis
      axis.title = element_text(color = "grey30"),
      axis.text = element_text(color = "grey30"),

      # Legend
      legend.position = "bottom",
      legend.title = element_text(size = 10),

      # Margins
      plot.margin = margin(15, 15, 15, 15)
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
    subtitle = "Countries with higher GDP tend to have higher life expectancy",
    x = "GDP per Capita (USD, log scale)",
    y = "Life Expectancy (years)",
    color = "Continent"
  ) +
  theme_clean()


# ----------------------------------------------------------------------------
# PART 8: COMPLETE BEFORE/AFTER EXAMPLE
# ----------------------------------------------------------------------------

# BEFORE: Cluttered scatter plot
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop, shape = continent)) +
  geom_point(alpha = 0.8) +
  scale_x_continuous(labels = scales::dollar) +
  labs(
    title = "The Relationship Between National Wealth and Health Outcomes",
    subtitle = "An Analysis of GDP per Capita versus Life Expectancy by Continent, 2007",
    x = "Gross Domestic Product per Capita (Current International Dollars)",
    y = "Life Expectancy at Birth (Total Years)",
    color = "Continental Region",
    size = "Total Population",
    shape = "Continental Region",
    caption = "Data Source: Gapminder Foundation | Visualization: ggplot2"
  ) +
  theme_gray() +
  theme(
    legend.position = "right",
    panel.border = element_rect(fill = NA, color = "black", linewidth = 2)
  )

# AFTER: Clean and focused
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  scale_color_brewer(palette = "Set2") +
  labs(
    title = "Wealth and Health",
    subtitle = "Richer countries tend to have longer life expectancy (2007)",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy",
    color = NULL
  ) +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    plot.title = element_text(face = "bold")
  )


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Simplify this cluttered boxplot
# Remove at least 4 unnecessary elements
# Original cluttered version:
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot(color = "black", linewidth = 1.5, outlier.size = 4) +
  labs(
    title = "Distribution of Life Expectancy by Continent",
    subtitle = "Data: Gapminder Project, Year 2007",
    x = "Continent of the World",
    y = "Life Expectancy (Measured in Complete Years)",
    fill = "Continent Name",
    caption = "Created with R and ggplot2 package"
  ) +
  theme_gray() +
  theme(legend.position = "right")

# Your simplified version:


# Exercise 2: Create a "highlight one" bar chart
# Show average GDP per capita by continent
# Highlight only the highest continent in a different color
# Your code:


# Exercise 3: Create a polished line chart
# Show life expectancy trends for Baltic countries
# Use theme_minimal() or create your own clean theme
# Remove unnecessary elements
# Your code:


# Exercise 4: Declutter this chart step by step
# Start with this cluttered version and improve it in 4 steps
# Show your progression from cluttered to clean

# Step 0 (original):
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_gdp = mean(gdpPercap)) |>
  ggplot(aes(x = continent, y = avg_gdp, fill = continent)) +
  geom_col(color = "black", linewidth = 1) +
  geom_text(aes(label = paste0("$", round(avg_gdp, 0))), vjust = -0.5) +
  scale_y_continuous(labels = scales::dollar) +
  labs(
    title = "Average GDP per Capita by Continent (2007)",
    subtitle = "Source: Gapminder",
    x = "Continent",
    y = "Average GDP per Capita (USD)",
    fill = "Continent"
  )

# Step 1: Switch to minimal theme
# Your code:

# Step 2: Remove legend
# Your code:

# Step 3: Flip coordinates, remove grid
# Your code:

# Step 4: Final polish
# Your code:


# ============================================================================
# END OF SCRIPT
# ============================================================================

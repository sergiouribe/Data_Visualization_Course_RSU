# ============================================================================
# Module 07: Reporting and Sharing Visual Stories
# Practice Script
# ============================================================================

# Load packages
library(tidyverse)
library(gapminder)

# You may need to install these:
# install.packages("patchwork")
# install.packages("here")
# install.packages("gtsummary")

# ----------------------------------------------------------------------------
# PART 1: SAVING PLOTS WITH ggsave()
# ----------------------------------------------------------------------------

# Create a sample plot
sample_plot <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "The Wealth-Health Connection",
    subtitle = "Each point represents a country in 2007",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)",
    color = "Continent",
    caption = "Source: Gapminder"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

sample_plot

# Save in different formats
# Note: Uncomment to actually save files

# PNG for presentations and web (raster)
# ggsave("sample_plot.png", sample_plot, width = 10, height = 6, dpi = 300)

# PDF for publications (vector)
# ggsave("sample_plot.pdf", sample_plot, width = 10, height = 6)

# SVG for web and editing (vector)
# ggsave("sample_plot.svg", sample_plot, width = 10, height = 6)

# Different sizes for different purposes

# Presentation slide (16:9 aspect ratio)
# ggsave("slide_plot.png", sample_plot, width = 16, height = 9, dpi = 150)

# Square for social media
# ggsave("social_plot.png", sample_plot, width = 6, height = 6, dpi = 150)

# Publication (common journal width)
# ggsave("pub_plot.pdf", sample_plot, width = 7, height = 4.5)


# ----------------------------------------------------------------------------
# PART 2: COMBINING PLOTS WITH patchwork
# ----------------------------------------------------------------------------

library(patchwork)

# Create individual plots
p1 <- gapminder |>
  filter(year == 2007) |>
  count(continent) |>
  ggplot(aes(x = reorder(continent, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Countries per Continent", x = NULL, y = "Count") +
  theme_minimal()

p2 <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(fill = "steelblue", bins = 25, color = "white") +
  labs(title = "Life Expectancy Distribution", x = "Life Expectancy", y = "Count") +
  theme_minimal()

p3 <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", alpha = 0.6) +
  scale_x_log10() +
  labs(title = "GDP vs Life Expectancy", x = "GDP per Capita", y = "Life Expectancy") +
  theme_minimal()

p4 <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7) +
  labs(title = "Life Expectancy by Continent", x = NULL, y = "Life Expectancy") +
  theme_minimal()

# Combine plots - different arrangements

# Side by side
p1 + p2

# Stacked vertically
p1 / p2

# 2x2 grid
(p1 | p2) / (p3 | p4)

# With annotations
(p1 | p2) / (p3 | p4) +
  plot_annotation(
    title = "Global Health Dashboard (2007)",
    subtitle = "Overview of health and economic indicators",
    caption = "Source: Gapminder",
    tag_levels = "A"  # Adds A, B, C, D labels
  )

# Custom layout
p1 + p2 + p3 + plot_layout(ncol = 1)

# Adjusting relative sizes
p1 + p3 + plot_layout(widths = c(1, 2))


# ----------------------------------------------------------------------------
# PART 3: CREATING SUMMARY TABLES
# ----------------------------------------------------------------------------

library(gtsummary)

# Basic summary table
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, gdpPercap, pop) |>
  tbl_summary()

# Summary by group
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, gdpPercap) |>
  tbl_summary(
    by = continent,
    statistic = list(
      all_continuous() ~ "{mean} ({sd})"
    ),
    label = list(
      lifeExp ~ "Life Expectancy (years)",
      gdpPercap ~ "GDP per Capita (USD)"
    ),
    digits = list(
      lifeExp ~ 1,
      gdpPercap ~ 0
    )
  )

# More customized table
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, gdpPercap) |>
  tbl_summary(
    by = continent,
    statistic = list(
      all_continuous() ~ "{mean} ({min} - {max})"
    ),
    label = list(
      lifeExp ~ "Life Expectancy",
      gdpPercap ~ "GDP per Capita"
    )
  ) |>
  add_overall() |>
  bold_labels() |>
  modify_header(label ~ "**Variable**")


# ----------------------------------------------------------------------------
# PART 4: USING THE here PACKAGE
# ----------------------------------------------------------------------------

library(here)

# See where your project root is
here()

# Build paths that work anywhere
# here("data", "raw", "mydata.csv")
# here("output", "figures", "plot1.png")

# Example usage:
# my_data <- read_csv(here("data", "gapminder.csv"))
# ggsave(here("output", "figures", "health_plot.png"), sample_plot)


# ----------------------------------------------------------------------------
# PART 5: CREATING A CUSTOM THEME FOR REPORTS
# ----------------------------------------------------------------------------

# Define a consistent theme for all report visualizations
theme_report <- function(base_size = 11) {
  theme_minimal(base_size = base_size) +
    theme(
      # Title styling
      plot.title = element_text(
        face = "bold",
        size = base_size + 3,
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        color = "grey40",
        margin = margin(b = 15)
      ),
      plot.caption = element_text(
        color = "grey60",
        size = base_size - 2,
        hjust = 0
      ),

      # Grid styling
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey90"),

      # Axis styling
      axis.title = element_text(color = "grey30"),
      axis.text = element_text(color = "grey40"),

      # Legend styling
      legend.position = "bottom",
      legend.title = element_text(face = "bold", size = base_size - 1),

      # Margins
      plot.margin = margin(15, 15, 15, 15)
    )
}

# Apply the theme
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Wealth and Health of Nations",
    subtitle = "Higher GDP is associated with longer life expectancy",
    x = "GDP per Capita",
    y = "Life Expectancy (years)",
    color = NULL,
    caption = "Source: Gapminder | Data from 2007"
  ) +
  theme_report()


# ----------------------------------------------------------------------------
# PART 6: COMPLETE DASHBOARD EXAMPLE
# ----------------------------------------------------------------------------

# Create a comprehensive dashboard layout

# Top row: Key metrics
metric1 <- gapminder |>
  filter(year == 2007) |>
  summarize(avg = mean(lifeExp)) |>
  ggplot(aes(x = 1, y = 1)) +
  annotate("text", x = 1, y = 1.1, label = "67.0", size = 15, fontface = "bold", color = "steelblue") +
  annotate("text", x = 1, y = 0.9, label = "Global Avg Life Expectancy", size = 4, color = "grey40") +
  xlim(0.5, 1.5) + ylim(0.7, 1.3) +
  theme_void()

metric2 <- gapminder |>
  filter(year == 2007) |>
  summarize(n = n_distinct(country)) |>
  ggplot(aes(x = 1, y = 1)) +
  annotate("text", x = 1, y = 1.1, label = "142", size = 15, fontface = "bold", color = "steelblue") +
  annotate("text", x = 1, y = 0.9, label = "Countries", size = 4, color = "grey40") +
  xlim(0.5, 1.5) + ylim(0.7, 1.3) +
  theme_void()

# Main visualizations
main_scatter <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = scales::comma) +
  scale_size_continuous(guide = "none") +
  labs(
    title = "GDP vs Life Expectancy",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy",
    color = NULL
  ) +
  theme_report() +
  theme(legend.position = "right")

trend_plot <- gapminder |>
  group_by(continent, year) |>
  summarize(avg = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg, color = continent)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Life Expectancy Trends",
    x = NULL,
    y = "Average Life Expectancy",
    color = NULL
  ) +
  theme_report() +
  theme(legend.position = "right")

# Combine into dashboard
(metric1 | metric2) / (main_scatter | trend_plot) +
  plot_layout(heights = c(1, 3)) +
  plot_annotation(
    title = "Global Health Overview",
    subtitle = "Key indicators from Gapminder data",
    theme = theme(
      plot.title = element_text(size = 18, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "grey40")
    )
  )


# ============================================================================
# EXERCISES
# ============================================================================

# Exercise 1: Save plots in multiple formats
# Create a visualization and save it as:
# - PNG at 300 dpi for printing
# - PNG at 150 dpi for web
# - PDF for publication
# Your code here:


# Exercise 2: Create a combined plot
# Use patchwork to create a layout with:
# - Two plots side by side on top
# - One wide plot on the bottom
# Add proper titles and annotations
# Your code here:


# Exercise 3: Create a summary table
# Use gtsummary to create a summary of gapminder 2007 data
# Show mean and standard deviation by continent
# Include proper labels
# Your code here:


# Exercise 4: Design a custom theme
# Create your own theme_custom() function
# Use it consistently across 3 different plots
# Your code here:


# Exercise 5: Build a mini-dashboard
# Create a dashboard with 4 related visualizations
# Use patchwork to arrange them
# Add an overall title and annotations
# Make it look professional!
# Your code here:


# ============================================================================
# END OF SCRIPT
# ============================================================================

# ============================================================================
# CAPSTONE PROJECT TEMPLATE
# Storytelling with Data Course
# ============================================================================
#
# Instructions:
# 1. Replace [Your Name] with your name
# 2. Choose your dataset and update the loading section
# 3. Fill in each section with your analysis
# 4. Add your visualizations and interpretations
# 5. Convert to R Markdown for final submission
#
# ============================================================================

# ============================================================================
# SETUP
# ============================================================================

# Load required packages
library(tidyverse)
library(gapminder)  # Or your chosen dataset
library(patchwork)
library(scales)

# Optional: Additional packages you might need
# library(gtsummary)
# library(ggrepel)
# library(naniar)
# library(here)

# Set your custom theme for consistent styling
theme_capstone <- function(base_size = 11) {
  theme_minimal(base_size = base_size) +
    theme(
      # Titles
      plot.title = element_text(
        face = "bold",
        size = rel(1.3),
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        color = "grey40",
        margin = margin(b = 15)
      ),
      plot.caption = element_text(
        color = "grey60",
        size = rel(0.8),
        hjust = 0
      ),

      # Panel
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey92"),

      # Legend
      legend.position = "bottom",
      legend.title = element_text(face = "bold", size = rel(0.9)),

      # Margins
      plot.margin = margin(15, 15, 10, 10)
    )
}

# Define your color palette
my_colors <- c(
  "Category1" = "#E64B35",
  "Category2" = "#4DBBD5",
  "Category3" = "#00A087",
  "Category4" = "#3C5488",
  "Category5" = "#F39B7F"
)


# ============================================================================
# DATA LOADING AND EXPLORATION
# ============================================================================

# Load your data
# -----------------
# Option A: Gapminder
data <- gapminder

# Option B: Your own data
# data <- read_csv("path/to/your/data.csv")

# Initial exploration
glimpse(data)
summary(data)

# Check for missing values
data |>
  summarize(across(everything(), ~sum(is.na(.))))

# Basic descriptive statistics
# [Add your code here]


# ============================================================================
# SECTION 1: INTRODUCTION / HOOK
# ============================================================================
#
# What surprising fact or compelling question will draw in your audience?
# Create a visualization that sets up your story
#

# Example: Your hook visualization
hook_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  labs(
    title = "[Your compelling title]",
    subtitle = "[Supporting context]",
    x = "...",
    y = "..."
  ) +
  theme_capstone()

hook_plot


# ============================================================================
# SECTION 2: CONTEXT AND BACKGROUND
# ============================================================================
#
# What background information does your audience need?
# Show the big picture before diving into specifics
#

# Example: Context visualization
context_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  labs(
    title = "[Background context]",
    subtitle = "[Supporting details]"
  ) +
  theme_capstone()

context_plot


# ============================================================================
# SECTION 3: MAIN FINDING 1
# ============================================================================
#
# Your first key finding
# Include:
# - The visualization
# - Clear interpretation
# - Why this matters
#

finding1_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  labs(
    title = "[Finding 1 Title]",
    subtitle = "[What this shows]",
    caption = "Source: ..."
  ) +
  theme_capstone()

finding1_plot

# Interpretation:
# [Write 2-3 sentences explaining what this visualization reveals]


# ============================================================================
# SECTION 4: MAIN FINDING 2
# ============================================================================
#
# Your second key finding
#

finding2_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  labs(
    title = "[Finding 2 Title]",
    subtitle = "[What this shows]"
  ) +
  theme_capstone()

finding2_plot

# Interpretation:
# [Write 2-3 sentences explaining what this visualization reveals]


# ============================================================================
# SECTION 5: MAIN FINDING 3
# ============================================================================
#
# Your third key finding
# Consider using a different chart type
#

finding3_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  labs(
    title = "[Finding 3 Title]",
    subtitle = "[What this shows]"
  ) +
  theme_capstone()

finding3_plot

# Interpretation:
# [Write 2-3 sentences explaining what this visualization reveals]


# ============================================================================
# SECTION 6: FACETED VISUALIZATION
# ============================================================================
#
# Required: At least one faceted visualization
#

faceted_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  facet_wrap(~...) +
  labs(
    title = "[Your faceted visualization title]",
    subtitle = "[What comparisons this enables]"
  ) +
  theme_capstone()

faceted_plot


# ============================================================================
# SECTION 7: DASHBOARD / COMBINED LAYOUT
# ============================================================================
#
# Required: At least one combined visualization using patchwork
#

# Create individual plots for the dashboard
dash_p1 <- data |>
  ggplot(aes(...)) +
  geom_...() +
  labs(title = "...") +
  theme_capstone()

dash_p2 <- data |>
  ggplot(aes(...)) +
  geom_...() +
  labs(title = "...") +
  theme_capstone()

dash_p3 <- data |>
  ggplot(aes(...)) +
  geom_...() +
  labs(title = "...") +
  theme_capstone()

dash_p4 <- data |>
  ggplot(aes(...)) +
  geom_...() +
  labs(title = "...") +
  theme_capstone()

# Combine into dashboard
dashboard <- (dash_p1 | dash_p2) / (dash_p3 | dash_p4) +
  plot_annotation(
    title = "[Your Dashboard Title]",
    subtitle = "[What this overview shows]",
    caption = "[Data source]"
  )

dashboard


# ============================================================================
# SECTION 8: ANNOTATED VISUALIZATION
# ============================================================================
#
# Required: At least one visualization with meaningful annotations
#

annotated_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  # Add annotations
  annotate("text", x = ..., y = ..., label = "...", ...) +
  annotate("segment", x = ..., xend = ..., y = ..., yend = ..., ...) +
  labs(
    title = "[Your annotated visualization]",
    subtitle = "[Key insight highlighted]"
  ) +
  theme_capstone()

annotated_plot


# ============================================================================
# SECTION 9: CONCLUSIONS
# ============================================================================
#
# Final visualization that summarizes your key message
#

conclusion_plot <- data |>
  # [Your data transformation]
  ggplot(aes(x = ..., y = ...)) +
  geom_...() +
  labs(
    title = "[Your concluding message]",
    subtitle = "[The key takeaway for your audience]",
    caption = "Data: ... | Analysis: [Your Name]"
  ) +
  theme_capstone()

conclusion_plot


# ============================================================================
# SAVE YOUR VISUALIZATIONS
# ============================================================================

# Create output directory if needed
# dir.create("output/figures", recursive = TRUE)

# Save key visualizations
# ggsave("output/figures/01_hook.png", hook_plot, width = 10, height = 6, dpi = 300)
# ggsave("output/figures/02_finding1.png", finding1_plot, width = 10, height = 6, dpi = 300)
# ggsave("output/figures/dashboard.png", dashboard, width = 14, height = 10, dpi = 300)


# ============================================================================
# CHECKLIST BEFORE SUBMISSION
# ============================================================================
#
# [ ] At least 5 different visualization types used
# [ ] At least 1 faceted visualization
# [ ] At least 1 combined/dashboard layout
# [ ] At least 2 visualizations with annotations
# [ ] All visualizations have clear titles and labels
# [ ] Consistent visual style throughout
# [ ] Code is clean and well-commented
# [ ] Story has clear narrative arc
# [ ] R Markdown report compiles without errors
#


# ============================================================================
# END OF TEMPLATE
# ============================================================================

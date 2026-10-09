# Module 04: Simplifying Visuals and Removing Clutter

## Learning Objectives

By the end of this module, you will be able to:
- Identify and remove visual clutter from charts
- Apply the data-ink ratio principle
- Use white space effectively
- Create clean, focused visualizations
- Apply minimal design principles in ggplot2

---

## Part 1: The Problem with Clutter

### What is Visual Clutter?

Visual clutter is anything in a chart that doesn't help communicate your message. It includes:
- Unnecessary grid lines
- Decorative elements
- Redundant labels
- Excessive colors
- 3D effects
- Chartjunk

### Why Clutter Hurts

- **Cognitive overload**: More elements = more mental processing
- **Distraction**: Attention goes to decoration, not data
- **Confusion**: Key message gets lost
- **Unprofessional appearance**: Busy charts look amateur

---

## Part 2: The Data-Ink Ratio

Edward Tufte introduced the concept of **data-ink ratio**:

> Data-ink ratio = Ink used for data / Total ink used in the chart

**Goal**: Maximize the share of ink devoted to actual data.

### Before and After Example

```r
library(tidyverse)
library(gapminder)

# BEFORE: Default with clutter
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = continent, y = avg_lifeExp, fill = continent)) +
  geom_col() +
  labs(title = "Average Life Expectancy by Continent")

# AFTER: Clean and focused
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = reorder(continent, avg_lifeExp), y = avg_lifeExp)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Average Life Expectancy by Continent (2007)",
    x = NULL,
    y = "Life Expectancy (years)"
  ) +
  theme_minimal() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank()
  )
```

---

## Part 3: Elements to Eliminate

### 1. Unnecessary Borders and Boxes

```r
# Remove plot borders
theme(
  panel.border = element_blank(),
  axis.line = element_line(color = "grey50")
)
```

### 2. Redundant Grid Lines

```r
# Remove minor grid lines and unnecessary majors
theme(
  panel.grid.minor = element_blank(),
  panel.grid.major.y = element_blank()  # For horizontal bar charts
)
```

### 3. Redundant Legends

If the information is clear from the chart, remove the legend:

```r
# Remove legend when color is redundant with labels
theme(legend.position = "none")

# Or use guides()
guides(fill = "none", color = "none")
```

### 4. Excessive Decimal Places

```r
# Round axis labels
scale_y_continuous(labels = scales::number_format(accuracy = 1))
```

### 5. Unnecessary Axis Labels

```r
# Remove axis title when obvious
labs(x = NULL)
```

---

## Part 4: Minimal Themes

### Built-in Minimal Themes

```r
# Comparison of themes
p <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7)

# Default (cluttered)
p + labs(title = "Default theme")

# theme_minimal (clean)
p + theme_minimal() + labs(title = "theme_minimal")

# theme_classic (very clean)
p + theme_classic() + labs(title = "theme_classic")

# theme_void (almost nothing)
p + theme_void() + labs(title = "theme_void")
```

### Custom Minimal Theme

```r
# Create a custom minimal theme
theme_clean <- function() {
  theme_minimal() +
    theme(
      # Remove minor grid lines
      panel.grid.minor = element_blank(),

      # Soften major grid lines
      panel.grid.major = element_line(color = "grey90"),

      # Clean axis lines
      axis.line = element_line(color = "grey50", linewidth = 0.3),

      # Improve text
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(color = "grey40"),

      # Position legend at bottom
      legend.position = "bottom"
    )
}

# Use it
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10() +
  labs(title = "GDP vs Life Expectancy") +
  theme_clean()
```

---

## Part 5: Strategic Use of White Space

White space (empty space) is a design element. It:
- Guides the eye
- Groups related elements
- Creates visual breathing room
- Makes charts look professional

### Adding White Space

```r
# Increase margins
theme(
  plot.margin = margin(t = 20, r = 20, b = 20, l = 20, unit = "pt")
)

# Add space between title and plot
theme(
  plot.title = element_text(margin = margin(b = 15))
)

# Expand axis limits for breathing room
scale_y_continuous(expand = expansion(mult = c(0, 0.1)))
```

---

## Part 6: Simplifying Color

### The Problem with Too Many Colors

More colors doesn't mean better. Colors should:
- Encode meaningful information
- Be distinguishable
- Be accessible (colorblind-friendly)

### Using Color Sparingly

```r
# BAD: Rainbow of colors
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, fill = continent)) +
  geom_bar()

# GOOD: Single color, highlight what matters
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg = mean(lifeExp)) |>
  mutate(highlight = continent == "Africa") |>
  ggplot(aes(x = reorder(continent, avg), y = avg, fill = highlight)) +
  geom_col() +
  scale_fill_manual(values = c("TRUE" = "#e41a1c", "FALSE" = "grey70")) +
  coord_flip() +
  labs(title = "Africa has the lowest life expectancy", x = NULL, y = NULL) +
  theme_minimal() +
  theme(legend.position = "none")
```

### Recommended Color Palettes

```r
# Viridis (colorblind-friendly)
scale_color_viridis_d()
scale_fill_viridis_d()

# ColorBrewer
scale_color_brewer(palette = "Set2")
scale_fill_brewer(palette = "Blues")
```

---

## Part 7: Before and After Gallery

### Example 1: Bar Chart

```r
# BEFORE
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(n = n()) |>
  ggplot(aes(x = continent, y = n, fill = continent)) +
  geom_col() +
  geom_text(aes(label = n), vjust = -0.5) +
  labs(
    title = "Number of Countries by Continent",
    subtitle = "Data from Gapminder, Year 2007",
    x = "Continent",
    y = "Number of Countries",
    fill = "Continent",
    caption = "Source: Gapminder"
  )

# AFTER
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(n = n()) |>
  ggplot(aes(x = reorder(continent, n), y = n)) +
  geom_col(fill = "steelblue", width = 0.7) +
  geom_text(aes(label = n), hjust = -0.3, size = 4) +
  coord_flip() +
  labs(
    title = "Number of Countries by Continent",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank()
  )
```

### Example 2: Scatter Plot

```r
# BEFORE
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  labs(
    title = "Relationship Between GDP per Capita and Life Expectancy",
    subtitle = "Each point represents a country in 2007",
    x = "GDP per Capita (current US$)",
    y = "Life Expectancy at Birth (years)",
    color = "Continent",
    size = "Population"
  )

# AFTER
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", alpha = 0.7, size = 2) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Wealth and Health Go Together",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy"
  ) +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank()
  )
```

---

## Part 8: Decluttering Checklist

Before finalizing any visualization, ask yourself:

- [ ] **Is every element necessary?** Remove what doesn't add meaning
- [ ] **Are grid lines needed?** Often they can be removed or lightened
- [ ] **Is the legend required?** Remove if information is elsewhere
- [ ] **Are axis labels clear?** Remove obvious ones, clarify unclear ones
- [ ] **Is color used strategically?** Use it for meaning, not decoration
- [ ] **Is there enough white space?** Add margins if feeling cramped
- [ ] **Is the message clear?** Someone should understand in 5 seconds

---

## Exercises

### Exercise 1: Identify the Clutter
Look at the following code and list 5 elements that could be removed or simplified:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot(color = "black", linewidth = 1) +
  labs(
    title = "Life Expectancy Distribution by Continent",
    subtitle = "Data Source: Gapminder Foundation, 2007",
    x = "Continent of the World",
    y = "Life Expectancy (measured in years)",
    fill = "Continent",
    caption = "Created with R and ggplot2"
  ) +
  theme_gray()
```

### Exercise 2: Simplify This Chart
Take the code from Exercise 1 and create a cleaner version.

### Exercise 3: One Color, Maximum Impact
Create a bar chart of average GDP per capita by continent where only the highest continent is colored (others in grey).

### Exercise 4: Before and After
Create two versions of the same visualization:
1. A "cluttered" version with many visual elements
2. A "clean" version following decluttering principles

---

## Key Takeaways

1. **Less is more** - Remove anything that doesn't serve the message
2. **Maximize data-ink ratio** - Most ink should represent data
3. **Use white space** - Empty space is a design element
4. **Color with purpose** - Use color to highlight, not decorate
5. **Choose minimal themes** - Start clean, add only what's necessary

---

## Next Module

[Module 05: Directing Audience Attention with Design →](../05_design_attention/)

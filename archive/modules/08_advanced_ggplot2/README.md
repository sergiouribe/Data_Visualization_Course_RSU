# Module 08: Advanced Customization in ggplot2

## Learning Objectives

By the end of this module, you will be able to:
- Customize every aspect of ggplot2 themes
- Create and apply custom color palettes
- Use advanced geoms and stats
- Handle complex annotations
- Create publication-quality visualizations

---

## Part 1: Deep Dive into Themes

### Theme Elements

Every visual aspect of a ggplot can be customized:

```r
library(tidyverse)
library(gapminder)

# Theme structure
theme(
  # Plot elements
  plot.title = element_text(...),
  plot.subtitle = element_text(...),
  plot.caption = element_text(...),
  plot.background = element_rect(...),
  plot.margin = margin(...),

  # Panel elements
  panel.background = element_rect(...),
  panel.grid.major = element_line(...),
  panel.grid.minor = element_line(...),
  panel.border = element_rect(...),

  # Axis elements
  axis.title = element_text(...),
  axis.text = element_text(...),
  axis.line = element_line(...),
  axis.ticks = element_line(...),

  # Legend elements
  legend.position = ...,
  legend.title = element_text(...),
  legend.text = element_text(...),
  legend.background = element_rect(...)
)
```

### Element Types

| Function | Used For | Key Arguments |
|----------|----------|---------------|
| `element_text()` | Text styling | size, color, face, family, angle, hjust, vjust |
| `element_line()` | Lines | color, linewidth, linetype |
| `element_rect()` | Rectangles | fill, color, linewidth |
| `element_blank()` | Remove element | - |
| `margin()` | Spacing | t, r, b, l (top, right, bottom, left) |

---

## Part 2: Building a Custom Theme

```r
# Create a comprehensive custom theme
theme_publication <- function(base_size = 12, base_family = "") {

  # Start with theme_minimal
  theme_minimal(base_size = base_size, base_family = base_family) %+replace%

    theme(
      # Plot title and subtitle
      plot.title = element_text(
        size = rel(1.3),
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
        color = "grey60",
        hjust = 1,
        margin = margin(t = 15)
      ),

      # Panel
      panel.grid.major = element_line(color = "grey92", linewidth = 0.3),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "white", color = NA),

      # Axes
      axis.title = element_text(size = rel(0.95), color = "grey30"),
      axis.title.x = element_text(margin = margin(t = 10)),
      axis.title.y = element_text(margin = margin(r = 10)),
      axis.text = element_text(size = rel(0.85), color = "grey40"),
      axis.line = element_line(color = "grey70", linewidth = 0.4),

      # Legend
      legend.position = "bottom",
      legend.title = element_text(size = rel(0.9), face = "bold"),
      legend.text = element_text(size = rel(0.85)),
      legend.key = element_rect(fill = NA),
      legend.background = element_rect(fill = NA),

      # Margins
      plot.margin = margin(20, 20, 20, 20)
    )
}

# Use the theme
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2) +
  scale_x_log10() +
  labs(
    title = "Wealth and Health of Nations",
    subtitle = "Each point represents a country in 2007",
    caption = "Source: Gapminder"
  ) +
  theme_publication()
```

---

## Part 3: Custom Color Palettes

### Creating Your Own Palette

```r
# Define custom colors
my_colors <- c(
  "Africa" = "#E64B35",
  "Americas" = "#4DBBD5",
  "Asia" = "#00A087",
  "Europe" = "#3C5488",
  "Oceania" = "#F39B7F"
)

# Use with scale_color_manual
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2) +
  scale_color_manual(values = my_colors) +
  scale_x_log10() +
  theme_minimal()
```

### Sequential and Diverging Palettes

```r
# Sequential (low to high)
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = lifeExp)) +
  geom_point(size = 3) +
  scale_color_gradient(low = "#fee8c8", high = "#e34a33") +
  scale_x_log10() +
  theme_minimal()

# Diverging (around a midpoint)
gapminder |>
  filter(year == 2007) |>
  mutate(diff_from_mean = lifeExp - mean(lifeExp)) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = diff_from_mean)) +
  geom_point(size = 3) +
  scale_color_gradient2(
    low = "#2166ac",
    mid = "white",
    high = "#b2182b",
    midpoint = 0
  ) +
  scale_x_log10() +
  theme_minimal()
```

### Using viridis (Colorblind-Friendly)

```r
# Continuous
scale_color_viridis_c(option = "plasma")

# Discrete
scale_color_viridis_d(option = "turbo")

# Options: viridis, magma, plasma, inferno, cividis, turbo
```

---

## Part 4: Advanced Geoms

### geom_segment and geom_curve

```r
# Dumbbell chart
gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania"),
         year %in% c(1952, 2007)) |>
  select(country, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  ggplot(aes(y = country)) +
  geom_segment(aes(x = `1952`, xend = `2007`, yend = country),
               linewidth = 1.5, color = "grey60") +
  geom_point(aes(x = `1952`), size = 4, color = "#e41a1c") +
  geom_point(aes(x = `2007`), size = 4, color = "#4daf4a") +
  labs(
    title = "Baltic States: Life Expectancy Gains",
    subtitle = "Red = 1952 | Green = 2007",
    x = "Life Expectancy", y = NULL
  ) +
  theme_minimal()
```

### geom_ribbon

```r
# Confidence bands
gapminder |>
  group_by(year) |>
  summarize(
    avg = mean(lifeExp),
    lower = avg - sd(lifeExp),
    upper = avg + sd(lifeExp)
  ) |>
  ggplot(aes(x = year)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), fill = "steelblue", alpha = 0.3) +
  geom_line(aes(y = avg), color = "steelblue", linewidth = 1) +
  labs(
    title = "Global Life Expectancy with Variation",
    subtitle = "Ribbon shows ± 1 standard deviation",
    x = NULL, y = "Life Expectancy"
  ) +
  theme_minimal()
```

### geom_tile (Heatmaps)

```r
# Create a heatmap
gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = continent, fill = avg_lifeExp)) +
  geom_tile(color = "white", linewidth = 0.5) +
  scale_fill_viridis_c(option = "plasma") +
  labs(
    title = "Life Expectancy Heatmap",
    x = NULL, y = NULL,
    fill = "Avg Life\nExpectancy"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
```

---

## Part 5: Advanced Annotations

### Multiple Annotations

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "grey70", alpha = 0.6) +

  # Highlight specific countries
  geom_point(
    data = gapminder |> filter(year == 2007, country == "Latvia"),
    color = "red", size = 4
  ) +

  # Add arrow and label
  annotate(
    "curve",
    x = 20000, xend = 11000,
    y = 68, yend = 71.5,
    curvature = 0.3,
    arrow = arrow(length = unit(0.2, "cm")),
    color = "red"
  ) +
  annotate(
    "text",
    x = 21000, y = 67,
    label = "Latvia",
    color = "red",
    fontface = "bold",
    hjust = 0
  ) +

  # Add explanatory text box
  annotate(
    "label",
    x = 500, y = 82,
    label = "Higher GDP generally\nassociated with longer life",
    hjust = 0,
    fill = "lightyellow",
    label.size = 0
  ) +

  scale_x_log10() +
  theme_minimal()
```

### Using ggrepel for Smart Labels

```r
library(ggrepel)

# Label selected points without overlap
gapminder |>
  filter(year == 2007) |>
  mutate(
    label = case_when(
      country %in% c("Japan", "United States", "Latvia",
                     "Sierra Leone", "Norway") ~ country,
      TRUE ~ ""
    )
  ) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, label = label)) +
  geom_point(color = "steelblue", alpha = 0.6) +
  geom_text_repel(
    fontface = "bold",
    color = "grey30",
    box.padding = 0.5,
    point.padding = 0.3,
    segment.color = "grey50",
    max.overlaps = 20
  ) +
  scale_x_log10() +
  theme_minimal()
```

---

## Part 6: Facet Customization

### Facet Styling

```r
gapminder |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.3, color = "steelblue") +
  facet_wrap(~continent, nrow = 2) +
  labs(title = "Life Expectancy Trends by Continent") +
  theme_minimal() +
  theme(
    strip.background = element_rect(fill = "steelblue", color = NA),
    strip.text = element_text(color = "white", face = "bold", size = 11),
    panel.spacing = unit(1, "lines")
  )
```

### Free Scales

```r
# Different scales for each facet
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap)) +
  geom_histogram(fill = "steelblue", bins = 20) +
  facet_wrap(~continent, scales = "free") +
  theme_minimal()
```

---

## Part 7: Coordinate Systems

### coord_flip()

```r
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_col(fill = "steelblue") +
  labs(title = "Top 10 Countries by Life Expectancy") +
  theme_minimal()
```

### coord_polar() (Pie/Radial Charts)

```r
# Pie chart (use sparingly!)
gapminder |>
  filter(year == 2007) |>
  count(continent) |>
  ggplot(aes(x = "", y = n, fill = continent)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Countries by Continent", fill = NULL) +
  theme_void()
```

### coord_fixed()

```r
# Equal aspect ratio (important for some comparisons)
gapminder |>
  filter(year %in% c(1952, 2007), continent == "Europe") |>
  select(country, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  ggplot(aes(x = `1952`, y = `2007`)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  coord_fixed() +
  labs(title = "1952 vs 2007 Life Expectancy") +
  theme_minimal()
```

---

## Part 8: Working with Scales

### Scale Transformations

```r
# Log scale
scale_x_log10()
scale_y_log10()

# Square root
scale_x_sqrt()

# Reverse
scale_x_reverse()

# Custom breaks and labels
scale_x_continuous(
  breaks = c(1000, 10000, 50000),
  labels = c("$1K", "$10K", "$50K")
)
```

### Axis Limits

```r
# Zoom (doesn't remove data)
coord_cartesian(xlim = c(0, 50000), ylim = c(40, 85))

# Cut (removes data outside limits - affects calculations)
scale_x_continuous(limits = c(0, 50000))
```

### Date Scales

```r
# For time series with dates
scale_x_date(
  date_breaks = "5 years",
  date_labels = "%Y"
)
```

---

## Part 9: Complete Publication Example

```r
# A publication-ready visualization
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +

  # Background layer: all points
  geom_point(
    color = "grey80",
    size = 2,
    alpha = 0.5
  ) +

  # Highlight layer: by continent
  geom_point(
    aes(color = continent, size = pop),
    alpha = 0.7
  ) +

  # Trend line
  geom_smooth(
    method = "loess",
    se = FALSE,
    color = "grey40",
    linewidth = 0.8,
    linetype = "dashed"
  ) +

  # Scales
  scale_x_log10(
    labels = scales::dollar_format(scale = 0.001, suffix = "K"),
    breaks = c(500, 2000, 10000, 50000)
  ) +
  scale_size_continuous(
    range = c(1, 12),
    guide = "none"
  ) +
  scale_color_manual(
    values = c(
      "Africa" = "#E64B35",
      "Americas" = "#4DBBD5",
      "Asia" = "#00A087",
      "Europe" = "#3C5488",
      "Oceania" = "#F39B7F"
    )
  ) +

  # Labels
  labs(
    title = "The Wealth-Health Relationship",
    subtitle = "Richer nations tend to have higher life expectancy, but the relationship isn't linear",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy at Birth (years)",
    color = NULL,
    caption = "Data: Gapminder | Point size represents population"
  ) +

  # Theme
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 16, margin = margin(b = 5)),
    plot.subtitle = element_text(color = "grey40", size = 11, margin = margin(b = 15)),
    plot.caption = element_text(color = "grey60", size = 9, hjust = 0, margin = margin(t = 15)),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "grey92"),
    legend.position = "bottom",
    legend.text = element_text(size = 10),
    axis.title = element_text(size = 11),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  guides(color = guide_legend(override.aes = list(size = 4)))
```

---

## Exercises

### Exercise 1: Custom Theme
Create your own complete custom theme function and apply it to three different chart types.

### Exercise 2: Custom Palette
Design a 5-color palette for the continents and use it consistently across multiple plots.

### Exercise 3: Advanced Annotations
Create a scatter plot with at least 3 different annotation types (text, arrows, shapes).

### Exercise 4: Heatmap
Create a heatmap showing life expectancy by continent and decade.

### Exercise 5: Publication Figure
Create a publication-ready figure that would be suitable for a journal article.

---

## Key Takeaways

1. **theme()** controls every visual aspect
2. **Custom palettes** ensure brand consistency
3. **Advanced geoms** enable sophisticated visualizations
4. **Annotations** guide viewer understanding
5. **Scales** control how data maps to visuals

---

## Next Module

[Module 09: Capstone Project →](../09_capstone/)

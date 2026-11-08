# Module 05: Directing Audience Attention with Design

## Learning Objectives

By the end of this module, you will be able to:
- Use preattentive attributes to highlight key information
- Guide viewer attention through strategic design
- Apply color, size, and position for emphasis
- Use annotations to direct focus
- Create hierarchy in your visualizations

---

## Part 1: Preattentive Attributes

### What Are Preattentive Attributes?

Preattentive attributes are visual properties that our brains process automatically, before conscious thought. They allow viewers to instantly identify "what's different."

### Key Preattentive Attributes

| Attribute | How to Use |
|-----------|------------|
| **Color hue** | Different colors for categories |
| **Color intensity** | Saturation to show emphasis |
| **Size** | Larger = more important |
| **Position** | Top/left often seen first |
| **Shape** | Different shapes for groups |
| **Orientation** | Angles for direction |

```r
library(tidyverse)
library(gapminder)

# Using color intensity to highlight
gapminder |>
  filter(year == 2007) |>
  mutate(highlight = country == "Latvia") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = highlight)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(values = c("FALSE" = "grey70", "TRUE" = "red")) +
  scale_x_log10() +
  labs(title = "Latvia's Position Among World Nations") +
  theme_minimal() +
  theme(legend.position = "none")
```

---

## Part 2: The Power of Color

### Color for Emphasis

Use color sparingly to draw attention to what matters most.

```r
# BAD: Color everywhere - nothing stands out
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp), fill = country)) +
  geom_col() +
  theme(legend.position = "none")

# GOOD: Strategic color - focus on one
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  mutate(is_japan = country == "Japan") |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp), fill = is_japan)) +
  geom_col() +
  scale_fill_manual(values = c("FALSE" = "grey70", "TRUE" = "#2171b5")) +
  labs(title = "Japan Leads the World in Life Expectancy") +
  theme_minimal() +
  theme(legend.position = "none")
```

### Color Palettes

Choose palettes that support your message:

```r
# Sequential: Low to high values
scale_fill_viridis_c()
scale_fill_gradient(low = "white", high = "steelblue")

# Diverging: Values above/below a midpoint
scale_fill_gradient2(low = "red", mid = "white", high = "blue", midpoint = 0)

# Qualitative: Distinct categories
scale_fill_brewer(palette = "Set2")
```

---

## Part 3: Size and Visual Weight

Larger elements draw more attention:

```r
# Using size to highlight
gapminder |>
  filter(year == 2007) |>
  mutate(highlight = continent == "Europe") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, size = highlight, color = highlight)) +
  geom_point(alpha = 0.7) +
  scale_size_manual(values = c("FALSE" = 2, "TRUE" = 5)) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "steelblue")) +
  scale_x_log10() +
  labs(title = "European Countries Highlighted") +
  theme_minimal() +
  theme(legend.position = "none")
```

---

## Part 4: Annotations

Annotations guide viewers to insights. Use `annotate()` and `geom_text()`:

### Adding Text Annotations

```r
gapminder |>
  filter(year == 2007, continent == "Europe") |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "grey60", size = 2) +
  geom_point(
    data = gapminder |> filter(year == 2007, country == "Latvia"),
    color = "red", size = 4
  ) +
  annotate(
    "text",
    x = 15000, y = 72,
    label = "Latvia",
    color = "red",
    fontface = "bold",
    hjust = 0
  ) +
  annotate(
    "segment",
    x = 14500, y = 72,
    xend = 10500, yend = 71.5,
    color = "red",
    arrow = arrow(length = unit(0.2, "cm"))
  ) +
  scale_x_log10() +
  labs(
    title = "Latvia's Position in Europe",
    x = "GDP per Capita",
    y = "Life Expectancy"
  ) +
  theme_minimal()
```

### Using ggrepel for Smart Labels

```r
library(ggrepel)

gapminder |>
  filter(year == 2007, continent == "Europe") |>
  mutate(label = ifelse(country %in% c("Latvia", "Norway", "Germany"), country, "")) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, label = label)) +
  geom_point(color = "steelblue", size = 2) +
  geom_text_repel(
    fontface = "bold",
    color = "grey30",
    box.padding = 0.5
  ) +
  scale_x_log10() +
  labs(title = "Selected European Countries") +
  theme_minimal()
```

---

## Part 5: Visual Hierarchy

### Creating Hierarchy with Layers

Build your chart in layers, from background to foreground:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  # Layer 1: Background context (all points, grey)
  geom_point(color = "grey80", size = 2, alpha = 0.5) +
  # Layer 2: Featured group (colored)
  geom_point(
    data = gapminder |> filter(year == 2007, continent == "Europe"),
    color = "steelblue", size = 3
  ) +
  # Layer 3: Key highlight (large, bold color)
  geom_point(
    data = gapminder |> filter(year == 2007, country == "Latvia"),
    color = "red", size = 5
  ) +
  scale_x_log10() +
  labs(
    title = "Latvia in European Context",
    subtitle = "Grey points show all countries; blue shows Europe"
  ) +
  theme_minimal()
```

### Typography Hierarchy

Use font weight and size to create text hierarchy:

```r
theme(
  plot.title = element_text(size = 16, face = "bold"),    # Primary
  plot.subtitle = element_text(size = 12, color = "grey40"), # Secondary
  axis.title = element_text(size = 10),                   # Tertiary
  axis.text = element_text(size = 9, color = "grey50")    # Quaternary
)
```

---

## Part 6: Position and Layout

### What Comes First

- Eye movement: Top-left to bottom-right (in Western cultures)
- Most important info should be top-left or at natural focal points
- Use `reorder()` to position bars meaningfully

```r
# Order bars by value (most important at top)
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg = mean(lifeExp)) |>
  ggplot(aes(x = avg, y = reorder(continent, avg))) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Life Expectancy by Continent",
    x = "Average Life Expectancy",
    y = NULL
  ) +
  theme_minimal()
```

### Using Facets for Focus

```r
# Highlight one panel
gapminder |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.3, color = "grey60") +
  geom_line(
    data = gapminder |> filter(country == "Latvia"),
    color = "red", linewidth = 1.5
  ) +
  facet_wrap(~continent) +
  labs(
    title = "Latvia's Life Expectancy Trend in Global Context",
    subtitle = "Red line shows Latvia; grey lines show other countries"
  ) +
  theme_minimal()
```

---

## Part 7: Direct Labeling

Instead of legends, label data directly:

```r
# Create summary data
continent_trends <- gapminder |>
  group_by(continent, year) |>
  summarize(avg = mean(lifeExp), .groups = "drop")

# Get end points for labels
end_labels <- continent_trends |>
  filter(year == max(year))

# Plot with direct labels
continent_trends |>
  ggplot(aes(x = year, y = avg, color = continent)) +
  geom_line(linewidth = 1) +
  geom_text(
    data = end_labels,
    aes(label = continent, x = year + 1),
    hjust = 0,
    fontface = "bold"
  ) +
  scale_x_continuous(expand = expansion(mult = c(0.05, 0.15))) +
  labs(
    title = "Life Expectancy Trends by Continent",
    x = NULL,
    y = "Average Life Expectancy"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
```

---

## Part 8: Putting It All Together

### A Complete Example

```r
# Highlight Latvia among European countries
europe_2007 <- gapminder |>
  filter(year == 2007, continent == "Europe") |>
  arrange(lifeExp) |>
  mutate(
    is_latvia = country == "Latvia",
    rank = row_number()
  )

europe_2007 |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  # Background bars
  geom_col(aes(fill = is_latvia), width = 0.7) +
  # Values on bars
  geom_text(
    aes(label = round(lifeExp, 1)),
    hjust = -0.2, size = 3
  ) +
  # Color scale
  scale_fill_manual(values = c("FALSE" = "grey70", "TRUE" = "#e41a1c")) +
  # Expand x for labels
  scale_x_continuous(expand = expansion(mult = c(0, 0.1))) +
  # Labels
  labs(
    title = "Where Does Latvia Rank in European Life Expectancy?",
    subtitle = "Life expectancy at birth, 2007",
    x = NULL,
    y = NULL
  ) +
  # Theme
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    plot.title = element_text(face = "bold")
  )
```

---

## Design Attention Checklist

- [ ] **What's the main message?** Identify before designing
- [ ] **What should stand out?** Use color/size/position to highlight
- [ ] **Is there a clear hierarchy?** Title > subtitle > data > labels
- [ ] **Are annotations needed?** Add context where it helps
- [ ] **Is the legend necessary?** Consider direct labeling
- [ ] **Does ordering make sense?** Sort by meaningful criteria

---

## Exercises

### Exercise 1: Highlight One Category
Create a bar chart of average GDP by continent where only Africa is highlighted in color (others in grey).

### Exercise 2: Annotate a Key Point
Create a scatter plot of GDP vs Life Expectancy and add an annotation pointing to a specific country with text explaining why it's notable.

### Exercise 3: Create Visual Hierarchy
Create a line chart with multiple countries where one country is emphasized through color, size, and direct labeling.

### Exercise 4: Before and After
Take any visualization from previous modules and apply attention-directing techniques to guide viewers to a specific insight.

---

## Key Takeaways

1. **Less color is more** - Use color to highlight, not decorate
2. **Guide the eye** - Use preattentive attributes strategically
3. **Create hierarchy** - Not everything is equally important
4. **Annotate insights** - Don't make viewers hunt for meaning
5. **Direct labels** beat legends when possible

---

## Next Module

[Module 06: Creating Visual Narratives →](../06_visual_narratives/)

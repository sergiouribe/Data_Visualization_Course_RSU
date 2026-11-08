# Module 06: Creating Visual Narratives

## Learning Objectives

By the end of this module, you will be able to:
- Structure data stories with beginning, middle, and end
- Create narrative flow through multiple visualizations
- Use context and comparison to strengthen your message
- Build compelling data presentations
- Connect emotional and analytical elements

---

## Part 1: What is Data Storytelling?

### Beyond Charts

A visualization shows data. A story **explains** data.

Data storytelling combines:
- **Data**: The evidence (what happened)
- **Visuals**: The illustrations (showing it clearly)
- **Narrative**: The explanation (why it matters)

### The Three-Act Structure

Like any good story, data stories have structure:

| Act | Purpose | Example |
|-----|---------|---------|
| **Setup** | Establish context, introduce the question | "Life expectancy has improved globally..." |
| **Confrontation** | Present the key findings, tension | "...but not equally everywhere" |
| **Resolution** | Deliver the insight, call to action | "Here's what we can learn from success stories" |

---

## Part 2: Starting with Context

### The "So What?" Test

Before every visualization, ask: "Why should the audience care?"

Provide context by:
- Showing historical trends
- Making comparisons
- Connecting to the audience's experience

```r
library(tidyverse)
library(gapminder)

# Without context - just numbers
gapminder |>
  filter(year == 2007, country == "Latvia") |>
  select(country, lifeExp, gdpPercap)

# With context - comparison
gapminder |>
  filter(year == 2007) |>
  mutate(
    is_latvia = country == "Latvia",
    region = ifelse(continent == "Europe", "Europe", "Other")
  ) |>
  group_by(region) |>
  summarize(
    avg_lifeExp = mean(lifeExp),
    latvia = mean(lifeExp[is_latvia], na.rm = TRUE)
  )
```

### Setting the Scene

```r
# Start with the big picture
gapminder |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.2, color = "grey60") +
  labs(
    title = "A World of Progress",
    subtitle = "Life expectancy has risen in nearly every country since 1952",
    x = NULL,
    y = "Life Expectancy"
  ) +
  theme_minimal()
```

---

## Part 3: Building Tension

### Reveal the Complexity

After setting context, introduce the nuance:

```r
# First: Overall positive trend
p1 <- gapminder |>
  group_by(year) |>
  summarize(avg = mean(lifeExp)) |>
  ggplot(aes(x = year, y = avg)) +
  geom_line(linewidth = 1.5, color = "steelblue") +
  labs(title = "Global average life expectancy is rising") +
  theme_minimal()

# Then: But not equally...
p2 <- gapminder |>
  group_by(continent, year) |>
  summarize(avg = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg, color = continent)) +
  geom_line(linewidth = 1) +
  labs(title = "...but the gap between continents remains") +
  theme_minimal()

# Show both
p1
p2
```

### Using Comparisons

Comparisons create drama and highlight findings:

```r
# Compare 1952 to 2007
gapminder |>
  filter(year %in% c(1952, 2007)) |>
  select(country, continent, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  mutate(change = `2007` - `1952`) |>
  group_by(continent) |>
  slice_max(change, n = 1) |>
  ggplot(aes(x = change, y = reorder(country, change), fill = continent)) +
  geom_col() +
  labs(
    title = "Biggest Improvers in Each Continent",
    subtitle = "Change in life expectancy from 1952 to 2007",
    x = "Years gained",
    y = NULL
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")
```

---

## Part 4: Delivering the Insight

### The "Aha!" Moment

The climax of your story is the key insight:

```r
# Build to the key insight
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop), alpha = 0.5, color = "grey60") +
  geom_smooth(method = "loess", se = FALSE, color = "steelblue") +
  # Highlight outliers
  geom_point(
    data = gapminder |> filter(year == 2007, country %in% c("United States", "Cuba")),
    aes(size = pop), color = "red"
  ) +
  geom_text(
    data = gapminder |> filter(year == 2007, country %in% c("United States", "Cuba")),
    aes(label = country),
    vjust = -1, size = 3
  ) +
  scale_x_log10(labels = scales::comma) +
  scale_size_continuous(guide = "none") +
  labs(
    title = "Money Isn't Everything",
    subtitle = "Cuba achieves similar life expectancy to the US with a fraction of GDP",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy"
  ) +
  theme_minimal()
```

---

## Part 5: Narrative Patterns

### Pattern 1: The Journey

Show change over time:

```r
# Latvia's journey
gapminder |>
  filter(country == "Latvia") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line(linewidth = 1, color = "steelblue") +
  geom_point(size = 2, color = "steelblue") +
  # Annotate key moments
  annotate("rect", xmin = 1987, xmax = 1997, ymin = -Inf, ymax = Inf,
           alpha = 0.2, fill = "red") +
  annotate("text", x = 1992, y = 65, label = "Post-Soviet\ntransition",
           size = 3, color = "red") +
  labs(
    title = "Latvia's Life Expectancy: A Story of Recovery",
    subtitle = "The dramatic dip and recovery following independence",
    x = NULL,
    y = "Life Expectancy"
  ) +
  theme_minimal()
```

### Pattern 2: The Comparison

Compare groups or scenarios:

```r
# Baltic states comparison
gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania")) |>
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(
    title = "Three Countries, Similar Paths",
    subtitle = "Baltic states share remarkably similar life expectancy trajectories",
    x = NULL,
    y = "Life Expectancy",
    color = NULL
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")
```

### Pattern 3: The Zoom

Start broad, zoom to specific:

```r
# Act 1: World view
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.3) +
  scale_x_log10() +
  labs(title = "Act 1: The World in 2007") +
  theme_minimal()

# Act 2: Europe focus
gapminder |>
  filter(year == 2007, continent == "Europe") |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue") +
  scale_x_log10() +
  labs(title = "Act 2: Zooming into Europe") +
  theme_minimal()

# Act 3: Latvia spotlight
gapminder |>
  filter(year == 2007, continent == "Europe") |>
  mutate(is_latvia = country == "Latvia") |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = is_latvia, size = is_latvia)) +
  geom_point() +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "red")) +
  scale_size_manual(values = c("FALSE" = 2, "TRUE" = 5)) +
  scale_x_log10() +
  labs(title = "Act 3: Latvia's Position") +
  theme_minimal() +
  theme(legend.position = "none")
```

---

## Part 6: Connecting Multiple Visualizations

### Creating a Sequence

A data story often needs multiple charts:

```r
# Chart 1: Hook - The surprising fact
hook <- gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(spread = max(lifeExp) - min(lifeExp)) |>
  ggplot(aes(x = reorder(continent, spread), y = spread, fill = continent == "Africa")) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = c("TRUE" = "#e41a1c", "FALSE" = "grey70")) +
  labs(
    title = "The Inequality Within Continents",
    subtitle = "Gap between highest and lowest life expectancy",
    x = NULL, y = "Years"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Chart 2: Context - Why Africa?
context <- gapminder |>
  filter(year == 2007, continent == "Africa") |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop), alpha = 0.7, color = "#e41a1c") +
  scale_x_log10() +
  labs(
    title = "Economic Inequality Drives Health Inequality",
    subtitle = "African countries in 2007",
    x = "GDP per Capita", y = "Life Expectancy"
  ) +
  theme_minimal()

# Chart 3: Hope - Progress over time
hope <- gapminder |>
  filter(continent == "Africa") |>
  group_by(year) |>
  summarize(
    avg = mean(lifeExp),
    top = max(lifeExp),
    bottom = min(lifeExp)
  ) |>
  ggplot(aes(x = year)) +
  geom_ribbon(aes(ymin = bottom, ymax = top), alpha = 0.3, fill = "#e41a1c") +
  geom_line(aes(y = avg), color = "#e41a1c", linewidth = 1) +
  labs(
    title = "But Progress is Happening",
    subtitle = "Average (line) and range (ribbon) of African life expectancy",
    x = NULL, y = "Life Expectancy"
  ) +
  theme_minimal()

# Show sequence
hook
context
hope
```

---

## Part 7: The Narrative Arc Worksheet

Before creating visualizations, plan your story:

```
1. HOOK: What will grab attention?
   _________________________________

2. CONTEXT: What background does the audience need?
   _________________________________

3. TENSION: What's the interesting conflict or question?
   _________________________________

4. INSIGHT: What's the key finding?
   _________________________________

5. RESOLUTION: What should the audience do or think?
   _________________________________
```

---

## Part 8: Complete Story Example

### "The Tale of Two Paths"

```r
# Setup: Two countries start similar
start_compare <- gapminder |>
  filter(country %in% c("Rwanda", "Sri Lanka"), year == 1952) |>
  select(country, year, lifeExp, gdpPercap) |>
  mutate(message = paste0(country, ": ", round(lifeExp, 0), " years"))

# Confrontation: Paths diverge
path_plot <- gapminder |>
  filter(country %in% c("Rwanda", "Sri Lanka")) |>
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  annotate("rect", xmin = 1990, xmax = 1997, ymin = 20, ymax = 50,
           alpha = 0.1, fill = "red") +
  annotate("text", x = 1994, y = 55, label = "Rwandan\nGenocide",
           size = 3, color = "grey40") +
  scale_color_manual(values = c("Rwanda" = "#e41a1c", "Sri Lanka" = "#2171b5")) +
  labs(
    title = "A Tale of Two Paths",
    subtitle = "Rwanda and Sri Lanka started with similar life expectancy in 1952",
    x = NULL,
    y = "Life Expectancy",
    color = NULL,
    caption = "The impact of conflict on human development"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold")
  )

path_plot

# Resolution: Rwanda's recovery
recovery <- gapminder |>
  filter(country == "Rwanda", year >= 1997) |>
  mutate(change = lifeExp - lag(lifeExp))

recovery_plot <- gapminder |>
  filter(country == "Rwanda") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line(linewidth = 1, color = "#e41a1c") +
  geom_point(
    data = gapminder |> filter(country == "Rwanda", year >= 2002),
    size = 3, color = "#e41a1c"
  ) +
  annotate("text", x = 2005, y = 50,
           label = "Recovery begins",
           color = "#e41a1c", fontface = "bold") +
  labs(
    title = "Rwanda's Remarkable Recovery",
    subtitle = "Life expectancy has climbed rapidly since 2000",
    x = NULL,
    y = "Life Expectancy"
  ) +
  theme_minimal()

recovery_plot
```

---

## Exercises

### Exercise 1: Three-Act Structure
Create a three-part visualization story about any country or continent:
1. Setup (context)
2. Confrontation (the finding)
3. Resolution (the insight)

### Exercise 2: The Comparison Story
Tell a story by comparing two or more countries with different outcomes. Highlight what's interesting about their differences.

### Exercise 3: The Journey Story
Pick a country and tell its "journey" through time using annotations to highlight key moments.

### Exercise 4: Plan Before Plot
Use the narrative arc worksheet to plan a story, then create the visualizations.

---

## Key Takeaways

1. **Story > Charts** - Visualizations serve the narrative
2. **Context first** - Help the audience understand why it matters
3. **Build tension** - Reveal complexity and questions
4. **Deliver insight** - Make the "aha" moment clear
5. **Plan the arc** - Structure before you code

---

## Next Module

[Module 07: Reporting and Sharing Visual Stories →](../07_reporting/)

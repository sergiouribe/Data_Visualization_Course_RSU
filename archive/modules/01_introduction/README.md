# Module 01: Introduction to Data Visualization and Storytelling

## Learning Objectives

By the end of this module, you will be able to:
- Explain why data visualization is important
- Understand the concept of storytelling with data
- Identify the components of a ggplot2 visualization
- Create basic plots using ggplot2

---

## Part 1: Why Visualize Data?

### The Power of Visualization

Humans are visual creatures. We process visual information much faster than text or numbers. A well-designed visualization can:

- **Reveal patterns** hidden in raw numbers
- **Communicate complex ideas** quickly and clearly
- **Engage your audience** and make data memorable
- **Support decision-making** with evidence

### Anscombe's Quartet: A Classic Example

Four datasets with nearly identical statistics (mean, variance, correlation) but completely different patterns:

```r
library(tidyverse)

# Anscombe's quartet is built into R
anscombe |>
  glimpse()
```

When you plot them, the differences become obvious - but the summary statistics hide these patterns!

### Data Storytelling

Data storytelling combines three elements:

1. **Data**: The facts and evidence
2. **Visualization**: The visual representation
3. **Narrative**: The story that explains the "so what?"

> "Numbers have an important story to tell. They rely on you to give them a voice." - Stephen Few

---

## Part 2: Introduction to ggplot2

### What is ggplot2?

**ggplot2** is R's most popular visualization package. The "gg" stands for "Grammar of Graphics" - a systematic way to describe and build visualizations.

### The Grammar of Graphics

Every ggplot2 visualization has these components:

| Component | Description | Example |
|-----------|-------------|---------|
| **Data** | The dataset you're visualizing | `gapminder` |
| **Aesthetics** | Mappings from data to visual properties | `x = gdpPercap, y = lifeExp` |
| **Geometries** | The visual elements (points, lines, bars) | `geom_point()` |
| **Facets** | Subplots by category | `facet_wrap(~continent)` |
| **Scales** | How data values map to visual values | `scale_x_log10()` |
| **Themes** | Overall appearance | `theme_minimal()` |

### Basic ggplot2 Syntax

```r
data |>
  ggplot(aes(x = variable1, y = variable2)) +
  geom_point()
```

Notice:
- We use `|>` to pipe data into ggplot
- We use `+` (not `|>`) to add layers to the plot
- `aes()` defines aesthetic mappings

---

## Part 3: Building Your First Plots

### The Essential Pattern

```r
# The basic structure
data |>
  ggplot(aes(x = ..., y = ...)) +
  geom_???()
```

### Common Geometries (geoms)

| Geom | Purpose | Variables |
|------|---------|-----------|
| `geom_point()` | Scatter plot | 2 continuous |
| `geom_line()` | Line chart | 2 continuous (ordered) |
| `geom_bar()` | Bar chart | 1 categorical |
| `geom_histogram()` | Histogram | 1 continuous |
| `geom_boxplot()` | Box plot | 1 continuous + 1 categorical |

### Example 1: Scatter Plot

```r
library(tidyverse)
library(gapminder)

# GDP vs Life Expectancy in 2007
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
```

### Example 2: Adding Color

```r
# Color points by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point()
```

### Example 3: Adding Size

```r
# Size points by population
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7)
```

### Example 4: Line Chart

```r
# Life expectancy over time for one country
gapminder |>
  filter(country == "Latvia") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line() +
  geom_point()
```

### Example 5: Bar Chart

```r
# Count of countries by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent)) +
  geom_bar()
```

### Example 6: Histogram

```r
# Distribution of life expectancy
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(bins = 20)
```

---

## Part 4: Aesthetic Mappings

### Inside aes() vs Outside aes()

**Inside `aes()`**: Map a variable to a visual property
```r
# Color varies by continent
ggplot(aes(x = gdpPercap, y = lifeExp, color = continent))
```

**Outside `aes()`**: Set a fixed visual property
```r
# All points are blue
geom_point(color = "blue", size = 3)
```

### Common Aesthetics

| Aesthetic | Description | Example |
|-----------|-------------|---------|
| `x`, `y` | Position | `aes(x = gdpPercap, y = lifeExp)` |
| `color` | Point/line color | `aes(color = continent)` |
| `fill` | Fill color (bars, areas) | `aes(fill = continent)` |
| `size` | Point size | `aes(size = pop)` |
| `shape` | Point shape | `aes(shape = continent)` |
| `alpha` | Transparency (0-1) | `aes(alpha = pop)` |

---

## Part 5: Adding Labels and Titles

Every good visualization needs clear labels:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  labs(
    title = "Wealth and Health of Nations (2007)",
    subtitle = "Each point represents a country",
    x = "GDP per Capita (USD)",
    y = "Life Expectancy (years)",
    color = "Continent",
    caption = "Source: Gapminder"
  )
```

---

## Part 6: Themes

Themes control the overall appearance of your plot:

```r
# Try different themes
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  theme_minimal()      # Clean, minimal theme

# Other built-in themes:
# theme_bw()          # Black and white
# theme_classic()     # Classic look
# theme_light()       # Light background
# theme_dark()        # Dark background
```

---

## Part 7: Exploratory Data Analysis (EDA)

### What is EDA?

Exploratory Data Analysis is the process of using visualizations and summaries to understand your data before formal analysis.

### EDA Workflow

1. **Look at the data**: `glimpse()`, `head()`, `summary()`
2. **Check for issues**: Missing values, outliers, errors
3. **Visualize distributions**: Histograms, boxplots
4. **Explore relationships**: Scatter plots, facets

### Example EDA with Gapminder

```r
# Step 1: Overview
gapminder |>
  glimpse()

# Step 2: Summary statistics
gapminder |>
  summary()

# Step 3: Distribution of life expectancy
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(bins = 25, fill = "steelblue", color = "white")

# Step 4: Life expectancy by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7)

# Step 5: Relationship between GDP and life expectancy
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()  # Log scale for GDP
```

---

## Exercises

### Exercise 1: Basic Scatter Plot
Create a scatter plot of population (`pop`) vs life expectancy (`lifeExp`) for the year 2007.

### Exercise 2: Add Color
Modify your plot to color points by continent.

### Exercise 3: Line Chart
Create a line chart showing how life expectancy changed over time for your home country (or any country of interest).

### Exercise 4: Histogram
Create a histogram of GDP per capita for 2007. What does the distribution look like?

### Exercise 5: Complete Visualization
Create a polished visualization with:
- Appropriate title and subtitle
- Clear axis labels
- A theme of your choice
- Caption with data source

---

## Key Takeaways

1. **Visualization reveals patterns** that numbers alone cannot show
2. **ggplot2 uses layers**: data + aesthetics + geometries
3. **Use `|>` for data**, use `+` for adding layers
4. **`aes()` maps variables**, outside `aes()` sets fixed values
5. **Always label your plots** clearly

---

## Next Module

[Module 02: Choosing the Right Visualization →](../02_choosing_visualizations/)

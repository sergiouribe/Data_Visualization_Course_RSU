# Module 02: Choosing the Right Visualization

## Learning Objectives

By the end of this module, you will be able to:
- Match visualization types to data types
- Choose appropriate charts based on your question
- Avoid common visualization mistakes
- Apply best practices for different chart types

---

## Part 1: What Are You Trying to Show?

Before creating a visualization, ask yourself: **What is my question?**

| Question Type | Goal | Recommended Charts |
|---------------|------|-------------------|
| **Comparison** | Compare values across categories | Bar chart, Dot plot |
| **Distribution** | Show how values are spread | Histogram, Density, Boxplot |
| **Relationship** | Show connection between variables | Scatter plot, Line chart |
| **Composition** | Show parts of a whole | Stacked bar, (Pie chart*) |
| **Change over time** | Show trends | Line chart, Area chart |

*Pie charts are rarely the best choice - we'll discuss why later.

---

## Part 2: Understanding Data Types

### Categorical vs Continuous

| Type | Description | Examples |
|------|-------------|----------|
| **Categorical** | Discrete groups/labels | Continent, Country, Gender |
| **Continuous** | Numeric, measurable | GDP, Life expectancy, Population |
| **Ordinal** | Categorical with order | Education level, Survey ratings |
| **Time** | Dates/timestamps | Year, Month, Date |

### Matching Charts to Data Types

| Data Combination | Best Charts |
|------------------|-------------|
| 1 Categorical | Bar chart |
| 1 Continuous | Histogram, Density plot |
| 2 Continuous | Scatter plot |
| 1 Categorical + 1 Continuous | Boxplot, Violin plot, Bar chart (with stat) |
| Continuous over Time | Line chart |

---

## Part 3: Comparison Charts

### Bar Charts

Best for comparing values across categories.

```r
library(tidyverse)
library(gapminder)

# Average life expectancy by continent in 2007
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = continent, y = avg_lifeExp)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Average Life Expectancy by Continent (2007)",
    x = "Continent",
    y = "Life Expectancy (years)"
  )
```

### Horizontal Bar Charts

Better when labels are long or you have many categories:

```r
# Top 10 countries by life expectancy
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Top 10 Countries by Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = NULL
  )
```

### Dot Plots (Cleveland Dot Plots)

An alternative to bar charts, often cleaner:

```r
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "steelblue") +
  labs(
    title = "Top 10 Countries by Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = NULL
  ) +
  theme_minimal()
```

---

## Part 4: Distribution Charts

### Histograms

Show how a continuous variable is distributed:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = "Count"
  )
```

**Tip**: Experiment with different `bins` values to find the right level of detail.

### Density Plots

A smooth version of histograms:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_density(fill = "steelblue", alpha = 0.5) +
  labs(
    title = "Distribution of Life Expectancy (2007)",
    x = "Life Expectancy (years)",
    y = "Density"
  )
```

### Comparing Distributions

```r
# Compare continents with overlapping density
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Life Expectancy Distribution by Continent (2007)",
    x = "Life Expectancy (years)",
    fill = "Continent"
  )
```

### Boxplots

Show distribution summary (median, quartiles, outliers):

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7) +
  labs(
    title = "Life Expectancy by Continent (2007)",
    x = "Continent",
    y = "Life Expectancy (years)"
  )
```

### Violin Plots

Show full distribution shape:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_violin(fill = "steelblue", alpha = 0.7) +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(
    title = "Life Expectancy by Continent (2007)",
    x = "Continent",
    y = "Life Expectancy (years)"
  )
```

---

## Part 5: Relationship Charts

### Scatter Plots

Show relationship between two continuous variables:

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  scale_x_log10() +
  labs(
    title = "GDP vs Life Expectancy (2007)",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)"
  )
```

### Adding Trend Lines

```r
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  scale_x_log10() +
  labs(
    title = "GDP vs Life Expectancy with Trend Line",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy (years)"
  )
```

---

## Part 6: Time Series Charts

### Line Charts

Best for showing trends over time:

```r
# Average world life expectancy over time
gapminder |>
  group_by(year) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  ggplot(aes(x = year, y = avg_lifeExp)) +
  geom_line(linewidth = 1, color = "steelblue") +
  geom_point(size = 2, color = "steelblue") +
  labs(
    title = "Global Average Life Expectancy Over Time",
    x = "Year",
    y = "Life Expectancy (years)"
  )
```

### Multiple Lines

```r
# Life expectancy by continent over time
gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Life Expectancy by Continent Over Time",
    x = "Year",
    y = "Life Expectancy (years)",
    color = "Continent"
  )
```

---

## Part 7: Using Facets

Facets create small multiples - the same chart repeated for different groups:

### facet_wrap

```r
gapminder |>
  ggplot(aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.3) +
  facet_wrap(~continent) +
  labs(
    title = "Life Expectancy Trends by Continent",
    subtitle = "Each line represents a country",
    x = "Year",
    y = "Life Expectancy"
  )
```

### facet_grid

For two variables:

```r
gapminder |>
  filter(year %in% c(1952, 1977, 2007)) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.7) +
  scale_x_log10() +
  facet_grid(continent ~ year) +
  labs(title = "GDP vs Life Expectancy by Continent and Year")
```

---

## Part 8: Charts to Avoid (or Use Carefully)

### Pie Charts: Why They're Problematic

- Humans are bad at judging angles and areas
- Hard to compare slices of similar size
- Impossible to compare across multiple pies

**When you might use a pie chart**: Only for simple part-to-whole with 2-3 very different proportions.

**Better alternative**: Bar chart

```r
# Instead of pie chart, use bar chart
gapminder |>
  filter(year == 2007) |>
  count(continent) |>
  ggplot(aes(x = reorder(continent, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Number of Countries by Continent", x = NULL, y = "Count")
```

### 3D Charts: Just Don't

3D effects:
- Distort perception of values
- Add no information
- Make comparison harder

### Dual Y-Axes: Very Misleading

- Can suggest false correlations
- Scale choice can manipulate perception
- Better to use facets or separate plots

---

## Part 9: Quick Reference Chart Chooser

```
What do you want to show?
│
├── COMPARISON across categories?
│   ├── Few categories → Bar chart
│   ├── Many categories → Horizontal bar chart or Dot plot
│   └── Ranking → Ordered bar chart
│
├── DISTRIBUTION of one variable?
│   ├── One group → Histogram or Density
│   └── Compare groups → Boxplot, Violin, or Faceted density
│
├── RELATIONSHIP between two variables?
│   ├── Both continuous → Scatter plot
│   └── Add trend → Scatter plot + geom_smooth()
│
├── CHANGE over time?
│   ├── One series → Line chart
│   └── Multiple series → Multiple lines or Faceted line charts
│
└── COMPOSITION (parts of whole)?
    ├── Static → Stacked bar chart
    └── Over time → Stacked area chart
```

---

## Exercises

### Exercise 1: Choosing Charts
For each scenario, identify the best chart type:
1. Compare GDP per capita across continents
2. Show how life expectancy is distributed globally
3. Show the relationship between population and GDP
4. Track Latvia's life expectancy from 1952 to 2007
5. Compare life expectancy distributions across continents

### Exercise 2: Create a Comparison Chart
Create a horizontal bar chart showing the 10 countries with the lowest life expectancy in 2007.

### Exercise 3: Create a Distribution Chart
Create a violin plot with embedded boxplot comparing GDP per capita across continents (use log scale!).

### Exercise 4: Create a Relationship Chart
Create a scatter plot of population vs GDP per capita (2007), colored by continent, with a log scale on both axes.

### Exercise 5: Create a Time Series
Create a faceted line chart showing life expectancy over time for Baltic countries (Estonia, Latvia, Lithuania).

---

## Key Takeaways

1. **Start with your question** - what are you trying to show?
2. **Match chart type to data type** - categories, continuous, time
3. **Keep it simple** - avoid 3D, excessive colors, dual axes
4. **Use facets** for comparing across groups
5. **Test your chart** - can a reader quickly understand the message?

---

## Next Module

[Module 03: Fundamentals of Data Wrangling →](../03_data_wrangling/)

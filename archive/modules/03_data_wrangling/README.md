# Module 03: Fundamentals of Data Wrangling

## Learning Objectives

By the end of this module, you will be able to:
- Filter rows and select columns from a dataset
- Create new variables and summarize data
- Handle missing values
- Reshape data between wide and long formats
- Prepare raw data for visualization

---

## Part 1: The dplyr Verbs

**dplyr** is the core tidyverse package for data manipulation. It provides a consistent set of "verbs" for common data operations:

| Verb | Purpose | Example |
|------|---------|---------|
| `filter()` | Keep rows that match conditions | Keep only year 2007 |
| `select()` | Keep or drop columns | Keep only country and lifeExp |
| `mutate()` | Create new columns | Calculate GDP (gdpPercap × pop) |
| `arrange()` | Sort rows | Sort by life expectancy |
| `summarize()` | Collapse to summary statistics | Calculate mean life expectancy |
| `group_by()` | Group data for operations | Group by continent |

All these verbs work the same way:
1. First argument is the data
2. Subsequent arguments describe what to do
3. Result is a new data frame

---

## Part 2: Filtering Rows

Use `filter()` to keep rows that meet specific conditions:

```r
library(tidyverse)
library(gapminder)

# Keep only 2007 data
gapminder |>
  filter(year == 2007)

# Keep European countries
gapminder |>
  filter(continent == "Europe")

# Multiple conditions with AND (,) or (&)
gapminder |>
  filter(year == 2007, continent == "Europe")

# Multiple conditions with OR (|)
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
```

### Comparison Operators

| Operator | Meaning |
|----------|---------|
| `==` | Equal to |
| `!=` | Not equal to |
| `>`, `<` | Greater than, Less than |
| `>=`, `<=` | Greater/Less than or equal to |
| `%in%` | Is in a set of values |

---

## Part 3: Selecting Columns

Use `select()` to choose which columns to keep:

```r
# Keep specific columns
gapminder |>
  select(country, year, lifeExp)

# Drop columns with minus
gapminder |>
  select(-pop, -gdpPercap)

# Select a range of columns
gapminder |>
  select(country:lifeExp)

# Use helper functions
gapminder |>
  select(starts_with("co"))     # country, continent

gapminder |>
  select(ends_with("Exp"))      # lifeExp

gapminder |>
  select(contains("p"))         # pop, lifeExp, gdpPercap

# Rename while selecting
gapminder |>
  select(country, life_expectancy = lifeExp)
```

---

## Part 4: Creating New Variables

Use `mutate()` to create new columns:

```r
# Create a single new column
gapminder |>
  mutate(gdp = gdpPercap * pop)

# Create multiple columns
gapminder |>
  mutate(
    gdp = gdpPercap * pop,
    pop_millions = pop / 1000000
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
  )

# Conditional values with if_else
gapminder |>
  mutate(
    is_europe = if_else(continent == "Europe", "Yes", "No")
  )
```

---

## Part 5: Sorting Data

Use `arrange()` to sort rows:

```r
# Sort by one column (ascending)
gapminder |>
  filter(year == 2007) |>
  arrange(lifeExp)

# Sort descending
gapminder |>
  filter(year == 2007) |>
  arrange(desc(lifeExp))

# Sort by multiple columns
gapminder |>
  filter(year == 2007) |>
  arrange(continent, desc(lifeExp))

# Get top/bottom n rows
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 5)   # Top 5

gapminder |>
  filter(year == 2007) |>
  slice_min(lifeExp, n = 5)   # Bottom 5
```

---

## Part 6: Summarizing Data

Use `summarize()` (or `summarise()`) to calculate summary statistics:

```r
# Basic summaries
gapminder |>
  filter(year == 2007) |>
  summarize(
    mean_lifeExp = mean(lifeExp),
    median_lifeExp = median(lifeExp),
    min_lifeExp = min(lifeExp),
    max_lifeExp = max(lifeExp),
    n_countries = n()
  )
```

### Common Summary Functions

| Function | Purpose |
|----------|---------|
| `mean()` | Average |
| `median()` | Median |
| `min()`, `max()` | Minimum, Maximum |
| `sd()` | Standard deviation |
| `sum()` | Sum |
| `n()` | Count of rows |
| `n_distinct()` | Count of unique values |

---

## Part 7: Grouped Operations

Use `group_by()` to perform operations by group:

```r
# Summary by group
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
    .groups = "drop"  # Remove grouping after summarizing
  )

# Grouped mutate (add group-level calculations)
gapminder |>
  group_by(continent, year) |>
  mutate(
    continent_avg = mean(lifeExp),
    diff_from_avg = lifeExp - continent_avg
  )
```

---

## Part 8: Handling Missing Values

The `naniar` package helps visualize and handle missing data:

```r
library(naniar)

# Check for missing values
gapminder |>
  miss_var_summary()

# Visualize missing data patterns
# vis_miss(your_data)

# When summarizing, handle NA values
gapminder |>
  summarize(
    mean_lifeExp = mean(lifeExp, na.rm = TRUE)
  )

# Filter out missing values
gapminder |>
  filter(!is.na(lifeExp))

# Replace missing values
gapminder |>
  mutate(
    lifeExp = replace_na(lifeExp, 0)  # Replace NA with 0
  )
```

---

## Part 9: Reshaping Data

### Long vs Wide Format

**Wide format**: Each variable in a separate column
```
country  | 1952 | 1957 | 1962
---------|------|------|------
Latvia   | 66.0 | 67.5 | 68.0
Estonia  | 65.0 | 66.0 | 67.0
```

**Long format**: Variables in rows (tidy data)
```
country | year | lifeExp
--------|------|--------
Latvia  | 1952 | 66.0
Latvia  | 1957 | 67.5
Latvia  | 1962 | 68.0
Estonia | 1952 | 65.0
```

### pivot_longer: Wide to Long

```r
# Example: Make a wide dataset
wide_data <- gapminder |>
  filter(country %in% c("Latvia", "Estonia", "Lithuania")) |>
  select(country, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp)

wide_data

# Convert back to long format
wide_data |>
  pivot_longer(
    cols = -country,           # All columns except country
    names_to = "year",         # New column for old column names
    values_to = "lifeExp"      # New column for values
  )
```

### pivot_wider: Long to Wide

```r
# Create a summary by continent and year
gapminder |>
  group_by(continent, year) |>
  summarize(mean_lifeExp = mean(lifeExp), .groups = "drop") |>
  pivot_wider(
    names_from = year,
    values_from = mean_lifeExp
  )
```

---

## Part 10: Combining Multiple Operations

The power of the pipe is chaining operations together:

```r
# Complex data preparation for visualization
gapminder |>
  # Filter to recent data
  filter(year == 2007) |>
  # Select relevant columns
  select(country, continent, lifeExp, gdpPercap, pop) |>
  # Create new variables
  mutate(
    gdp = gdpPercap * pop,
    pop_millions = pop / 1e6,
    gdp_category = case_when(
      gdpPercap < 5000 ~ "Low income",
      gdpPercap < 15000 ~ "Middle income",
      TRUE ~ "High income"
    )
  ) |>
  # Group and summarize
  group_by(continent, gdp_category) |>
  summarize(
    n_countries = n(),
    avg_lifeExp = mean(lifeExp),
    .groups = "drop"
  ) |>
  # Sort for presentation
  arrange(continent, desc(n_countries))
```

---

## Part 11: Using gtsummary for Summary Tables

The `gtsummary` package creates publication-ready summary tables:

```r
library(gtsummary)

# Basic summary table
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, pop, gdpPercap) |>
  tbl_summary()

# Summary by group
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, pop, gdpPercap) |>
  tbl_summary(by = continent)

# Customized table
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, gdpPercap) |>
  tbl_summary(
    by = continent,
    statistic = list(
      all_continuous() ~ "{mean} ({sd})"
    ),
    label = list(
      lifeExp ~ "Life Expectancy",
      gdpPercap ~ "GDP per Capita"
    )
  )
```

---

## Part 12: Data Wrangling for Visualization

Prepare data specifically for plotting:

```r
# Example 1: Top 10 chart
gapminder |>
  filter(year == 2007) |>
  slice_max(lifeExp, n = 10) |>
  ggplot(aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_col(fill = "steelblue") +
  labs(title = "Top 10 Countries by Life Expectancy (2007)")

# Example 2: Trend lines with summary
gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp), .groups = "drop") |>
  ggplot(aes(x = year, y = avg_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  labs(title = "Life Expectancy Trends by Continent")

# Example 3: Before-after comparison
gapminder |>
  filter(year %in% c(1952, 2007)) |>
  select(country, continent, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  mutate(change = `2007` - `1952`) |>
  group_by(continent) |>
  slice_max(change, n = 3) |>
  ggplot(aes(x = change, y = reorder(country, change))) +
  geom_col(fill = "steelblue") +
  facet_wrap(~continent, scales = "free_y") +
  labs(title = "Countries with Largest Life Expectancy Gains")
```

---

## Exercises

### Exercise 1: Filtering
Filter gapminder to show only Baltic countries (Latvia, Estonia, Lithuania) in years after 1990.

### Exercise 2: Selecting and Mutating
Create a dataset with country, year, and a new column `pop_category` that is "Large" if population > 50 million, else "Small".

### Exercise 3: Grouped Summaries
Calculate the mean, min, and max GDP per capita for each continent in 2007.

### Exercise 4: Full Pipeline
Using gapminder:
1. Filter to 2007
2. Create a column for total GDP (gdpPercap × pop)
3. Group by continent
4. Calculate total GDP by continent
5. Create a bar chart of the results

### Exercise 5: Reshaping
Create a table showing life expectancy for Baltic countries across all years (countries as rows, years as columns).

---

## Key Takeaways

1. **filter()** selects rows, **select()** selects columns
2. **mutate()** creates new variables, **summarize()** reduces to summaries
3. **group_by()** enables operations by group
4. Use `case_when()` for complex conditional logic
5. **pivot_longer/wider** reshapes between formats
6. Always think about what format your visualization needs

---

## Next Module

[Module 04: Simplifying Visuals and Removing Clutter →](../04_simplifying_visuals/)

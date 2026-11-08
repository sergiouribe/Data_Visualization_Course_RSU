# Module 07: Reporting and Sharing Visual Stories

## Learning Objectives

By the end of this module, you will be able to:
- Save plots in appropriate formats and resolutions
- Create reproducible reports with R Markdown
- Combine multiple plots effectively
- Export publication-ready visualizations
- Share your work professionally

---

## Part 1: Saving Plots

### Using ggsave()

The `ggsave()` function is the primary way to export ggplot2 visualizations:

```r
library(tidyverse)
library(gapminder)

# Create a plot
my_plot <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 2) +
  scale_x_log10() +
  labs(title = "GDP vs Life Expectancy (2007)") +
  theme_minimal()

# Save to file
ggsave("my_plot.png", my_plot, width = 8, height = 6, dpi = 300)
```

### File Formats

| Format | Use Case | Pros | Cons |
|--------|----------|------|------|
| **PNG** | Web, presentations | Universal, good compression | Not scalable |
| **PDF** | Publications, print | Scalable vector | Large files |
| **SVG** | Web, editing | Scalable, editable | Browser support |
| **JPEG** | Photos | Small files | Lossy compression |

```r
# PNG for presentations
ggsave("plot.png", my_plot, width = 10, height = 6, dpi = 300)

# PDF for publications
ggsave("plot.pdf", my_plot, width = 10, height = 6)

# SVG for web
ggsave("plot.svg", my_plot, width = 10, height = 6)
```

### Resolution and Size

- **dpi** (dots per inch): 72 for screen, 300 for print
- **width/height**: In inches by default
- Aspect ratio: Common ratios are 16:9, 4:3, or golden ratio (1.618:1)

```r
# Presentation slide (16:9)
ggsave("slide.png", my_plot, width = 16, height = 9, units = "in", dpi = 150)

# Publication quality
ggsave("publication.pdf", my_plot, width = 7, height = 5, dpi = 300)

# Social media square
ggsave("social.png", my_plot, width = 6, height = 6, dpi = 150)
```

---

## Part 2: Introduction to R Markdown

### What is R Markdown?

R Markdown combines text, code, and output in one document. It's perfect for:
- Reproducible reports
- Documentation
- Presentations
- Interactive documents

### Basic Structure

Create a new R Markdown file: File → New File → R Markdown

```markdown
---
title: "My Report"
author: "Your Name"
date: "`r Sys.Date()`"
output: html_document
---

# Introduction

This is my analysis of the Gapminder data.

```{r setup, include=FALSE}
library(tidyverse)
library(gapminder)
```

## The Data

```{r}
glimpse(gapminder)
```

## Visualization

```{r fig.width=8, fig.height=5}
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()
```

## Conclusions

Key findings from this analysis...
```

### Output Formats

```yaml
---
output: html_document    # Interactive HTML
output: pdf_document     # PDF (requires LaTeX)
output: word_document    # Microsoft Word
output: powerpoint_presentation  # PowerPoint
---
```

---

## Part 3: Code Chunk Options

### Common Chunk Options

```{r, eval=TRUE, echo=TRUE, message=FALSE, warning=FALSE, fig.width=8, fig.height=6}
```

| Option | Purpose | Values |
|--------|---------|--------|
| `eval` | Run the code? | TRUE/FALSE |
| `echo` | Show the code? | TRUE/FALSE |
| `message` | Show messages? | TRUE/FALSE |
| `warning` | Show warnings? | TRUE/FALSE |
| `fig.width` | Figure width | Number (inches) |
| `fig.height` | Figure height | Number (inches) |
| `fig.cap` | Figure caption | Text |

### Example Chunks

```markdown
Hide code, show output:
```{r echo=FALSE}
my_plot
```

Show code, hide output:
```{r eval=FALSE}
# This code won't run
complicated_function()
```

Publication-ready figure:
```{r fig.width=10, fig.height=6, fig.cap="Life expectancy vs GDP"}
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()
```
```

---

## Part 4: Combining Multiple Plots

### Using patchwork

The `patchwork` package makes combining plots easy:

```r
# install.packages("patchwork")
library(patchwork)

# Create individual plots
p1 <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = continent)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Countries by Continent") +
  theme_minimal()

p2 <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = lifeExp)) +
  geom_histogram(fill = "steelblue", bins = 20) +
  labs(title = "Life Expectancy Distribution") +
  theme_minimal()

p3 <- gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", alpha = 0.7) +
  scale_x_log10() +
  labs(title = "GDP vs Life Expectancy") +
  theme_minimal()

# Combine plots
p1 + p2                    # Side by side
p1 / p2                    # Stacked vertically
(p1 | p2) / p3            # Complex layout
p1 + p2 + p3 + plot_layout(ncol = 2)  # Grid layout
```

### Adding Titles and Annotations

```r
(p1 | p2) / p3 +
  plot_annotation(
    title = "Global Health Overview (2007)",
    subtitle = "Data from Gapminder",
    caption = "Source: gapminder.org",
    tag_levels = "A"  # Adds A, B, C labels
  )
```

---

## Part 5: Creating Summary Tables

### Using gtsummary

```r
library(gtsummary)

# Create a summary table
gapminder |>
  filter(year == 2007) |>
  select(continent, lifeExp, pop, gdpPercap) |>
  tbl_summary(
    by = continent,
    statistic = list(
      all_continuous() ~ "{mean} ({sd})"
    ),
    label = list(
      lifeExp ~ "Life Expectancy",
      pop ~ "Population",
      gdpPercap ~ "GDP per Capita"
    )
  ) |>
  add_overall() |>
  bold_labels()
```

### Using knitr::kable

```r
library(knitr)

# Simple table
gapminder |>
  filter(year == 2007) |>
  group_by(continent) |>
  summarize(
    Countries = n(),
    `Avg Life Exp` = round(mean(lifeExp), 1),
    `Avg GDP` = scales::dollar(mean(gdpPercap))
  ) |>
  kable(caption = "Summary by Continent (2007)")
```

---

## Part 6: Using the here Package

### The Problem with File Paths

```r
# BAD: Absolute paths break on other computers
read_csv("/Users/john/Documents/project/data/mydata.csv")

# BAD: setwd() causes issues
setwd("/Users/john/Documents/project")
```

### The Solution: here()

```r
library(here)

# GOOD: Works from any location in the project
read_csv(here("data", "mydata.csv"))

# Save plots
ggsave(here("output", "figures", "my_plot.png"), my_plot)
```

### Project Structure

```
my_project/
├── my_project.Rproj
├── data/
│   └── raw_data.csv
├── scripts/
│   └── analysis.R
├── output/
│   ├── figures/
│   └── tables/
└── reports/
    └── final_report.Rmd
```

---

## Part 7: Report Structure Best Practices

### A Good Report Structure

```markdown
---
title: "Analysis of Global Health Trends"
author: "Your Name"
date: "`r Sys.Date()`"
output:
  html_document:
    toc: true
    toc_float: true
    theme: flatly
---

# Executive Summary

Brief overview of key findings...

# Introduction

Context and questions we're answering...

# Data and Methods

## Data Source

Description of the dataset...

## Analysis Approach

Methods used...

# Results

## Finding 1: Life expectancy has improved globally

```{r echo=FALSE}
# Visualization code
```

Interpretation of the finding...

## Finding 2: But gaps remain between continents

```{r echo=FALSE}
# Another visualization
```

Interpretation...

# Discussion

What do these findings mean?

# Conclusions

Key takeaways and recommendations...

# Appendix

Additional tables and figures...
```

---

## Part 8: Sharing Your Work

### Export Options

| Format | Best For |
|--------|----------|
| HTML | Interactive viewing, web sharing |
| PDF | Formal reports, printing |
| Word | Collaborative editing |
| PowerPoint | Presentations |

### HTML Features

```yaml
---
output:
  html_document:
    toc: true           # Table of contents
    toc_float: true     # Floating TOC
    code_folding: hide  # Collapsible code
    theme: flatly       # Visual theme
---
```

### PDF Tips

```yaml
---
output:
  pdf_document:
    toc: true
    fig_caption: true
    keep_tex: false
---
```

---

## Part 9: Professional Polish

### Consistent Styling

Create a custom theme function:

```r
theme_report <- function() {
  theme_minimal(base_size = 11) +
    theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(color = "grey40"),
      plot.caption = element_text(color = "grey60", size = 9),
      panel.grid.minor = element_blank(),
      legend.position = "bottom"
    )
}

# Use throughout your report
p1 + theme_report()
p2 + theme_report()
```

### Figure Captions

```markdown
```{r fig.cap="Figure 1: Life expectancy has increased across all continents since 1952."}
gapminder |>
  group_by(continent, year) |>
  summarize(avg = mean(lifeExp)) |>
  ggplot(aes(x = year, y = avg, color = continent)) +
  geom_line() +
  theme_report()
```
```

---

## Exercises

### Exercise 1: Save a Plot
Create a visualization and save it in three formats: PNG (for web), PDF (for print), and SVG (for editing).

### Exercise 2: R Markdown Report
Create a simple R Markdown report with:
- A title and author
- An introduction
- One visualization with interpretation
- A conclusion

### Exercise 3: Combined Plots
Use patchwork to create a dashboard-style layout with 4 related plots.

### Exercise 4: Professional Report
Create a complete report analyzing one aspect of the gapminder data, including:
- Summary table
- Multiple visualizations
- Clear narrative
- Proper figure captions

---

## Key Takeaways

1. **Use ggsave()** for consistent, high-quality exports
2. **R Markdown** combines code, output, and narrative
3. **patchwork** simplifies multi-plot layouts
4. **here** makes paths reproducible
5. **Consistency** in styling creates professional results

---

## Next Module

[Module 08: Advanced Customization in ggplot2 →](../08_advanced_ggplot2/)

# Storytelling with Data: A Data Visualization Course

[Site course RSU](https://estudijas.rsu.lv/course/view.php?id=72998)


Welcome to the **Storytelling with Data** course at RSU. In this course, you'll learn how to transform raw data into compelling visual stories using R, tidyverse, and ggplot2.

## Course Overview

This hands-on course will teach you:
- How to explore and understand data through visualization
- Principles of effective data communication
- Technical skills in R and ggplot2
- How to create publication-ready graphics

## Prerequisites

- **No prior R experience required** - we start from the basics
- Bring your own laptop with R, RStudio, and Tidyverse pre-installed
- Curiosity and willingness to learn!

## Lecturer
[Dr Sergio Uribe (DDS, MSc, PhD)](https://science.rsu.lv/en/persons/sergio-e-uribe/)
 - Associate Professor, Deparment of Conservative Dentistry and Oral Health, Riga Stradins University
 - Visiting Professor, LMU Klinikum, Deparment of Conservative Dentistry, Periodontology and Digital Dentistry, LMU, Munich

## Course Modules

| Module | Topic |
|--------|-------|
| 00 | [Course Setup: Installing R, RStudio, and Packages](modules/00_setup/) |
| 01 | [Introduction to Data Visualization and Storytelling](modules/01_introduction/) |
| 02 | [Choosing the Right Visualization](modules/02_choosing_visualizations/) |
| 03 | [Fundamentals of Data Wrangling](modules/03_data_wrangling/) |
| 04 | [Simplifying Visuals and Removing Clutter](modules/04_simplifying_visuals/) |
| 05 | [Directing Audience Attention with Design](modules/05_design_attention/) |
| 06 | [Creating Visual Narratives](modules/06_visual_narratives/) |
| 07 | [Reporting and Sharing Visual Stories](modules/07_reporting/) |
| 08 | [Advanced Customization in ggplot2](modules/08_advanced_ggplot2/) |
| 09 | [Capstone Project: Telling a Data Story](modules/09_capstone/) |

## Datasets

Throughout this course, we'll work with several real-world datasets:

- **Gapminder** - Global development indicators (life expectancy, GDP, population)
- **Baby Names Latvia** - Naming trends over time
- **OKCupid** - Online dating profile data for exploratory analysis

## Tools & Packages

We use R with the following key packages:

```r
# Core packages
library(tidyverse)    # Data manipulation and visualization (includes ggplot2)

# Additional packages
library(gapminder)    # Gapminder dataset
library(gtsummary)    # Summary tables
library(here)         # Project-relative file paths
library(naniar)       # Missing data visualization
```

## Code Style

Throughout this course, we use the **native R pipe** (`|>`) for readable, chainable code:

```r
# Our coding style
data |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
```

## Getting Help

- Ask questions during class
- Use the course materials and exercises
- R documentation: `?function_name`
- [RStudio Cheatsheets](https://posit.co/resources/cheatsheets/)

## License

This course material is provided for educational purposes.

---

*Happy visualizing!*

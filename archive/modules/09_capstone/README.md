# Module 09: Capstone Project - Telling a Data Story

## Overview

The capstone project is your opportunity to apply everything you've learned in this course. You will create a complete data story using visualization, demonstrating your skills in:

- Data wrangling and exploration
- Choosing appropriate visualizations
- Applying design principles
- Creating clear visual narratives
- Producing professional-quality output

---

## Project Requirements

### 1. Choose Your Dataset

Select ONE of the following datasets:

#### Option A: Gapminder
Explore global development trends. Questions to consider:
- How has life expectancy changed over time?
- What's the relationship between wealth and health?
- Which countries have made the most progress?

#### Option B: Baby Names (Latvia)
Analyze naming trends in Latvia. Questions to consider:
- What are the most popular names over time?
- Are there gender patterns in naming?
- How have name trends changed?

#### Option C: OKCupid Profiles
Explore patterns in online dating profiles. Questions to consider:
- How do profiles differ by demographics?
- What patterns exist in self-description?
- Are there interesting correlations between variables?

#### Option D: Your Own Dataset
You may use your own dataset with instructor approval. The dataset should:
- Have at least 500 observations
- Include both categorical and numerical variables
- Be appropriate for visual storytelling

---

### 2. Deliverables

Your project must include:

#### A. Executive Summary (1 page)
- Key findings in 3-5 bullet points
- 1-2 main visualizations
- Clear takeaway message

#### B. Full Report (5-8 pages)
Using R Markdown, create a report containing:

1. **Introduction** (0.5 page)
   - What question are you exploring?
   - Why is it interesting or important?

2. **Data Description** (0.5-1 page)
   - Source of the data
   - Key variables used
   - Any data cleaning or preparation

3. **Exploratory Analysis** (1-2 pages)
   - Initial visualizations
   - What patterns did you discover?
   - What surprised you?

4. **Main Findings** (2-3 pages)
   - 3-5 polished visualizations
   - Clear narrative connecting them
   - Interpretation of each finding

5. **Conclusions** (0.5 page)
   - Summary of key insights
   - Limitations of the analysis
   - Questions for future exploration

#### C. Code
- Well-organized R script or R Markdown file
- Clear comments explaining your approach
- Reproducible (someone else could run it)

---

### 3. Visualization Requirements

Your project must include at least:

- **5 different visualization types** (e.g., scatter plot, bar chart, line chart, boxplot, heatmap)
- **1 faceted visualization** (small multiples)
- **1 combined/dashboard layout** (using patchwork or similar)
- **At least 2 visualizations with annotations**

All visualizations must:
- Have clear, informative titles
- Include appropriate axis labels
- Use a consistent visual style
- Follow the design principles from this course

---

### 4. Grading Rubric

| Criterion | Points | Description |
|-----------|--------|-------------|
| **Data Understanding** | 15 | Demonstrates clear understanding of the data |
| **Visualization Choice** | 20 | Appropriate chart types for the data and questions |
| **Design Quality** | 20 | Clean, uncluttered, professional appearance |
| **Narrative** | 20 | Clear story arc; findings are well-explained |
| **Technical Execution** | 15 | Code is clean, organized, reproducible |
| **Creativity** | 10 | Original insights or innovative approaches |
| **Total** | 100 | |

---

## Timeline

| Phase | Activities | Duration |
|-------|------------|----------|
| **Planning** | Choose dataset, formulate questions | Day 1-2 |
| **Exploration** | Load data, create initial visualizations | Day 3-5 |
| **Analysis** | Develop main findings, iterate on visualizations | Day 6-10 |
| **Polish** | Refine design, write narrative | Day 11-13 |
| **Finalize** | Complete report, review code | Day 14 |

---

## Getting Started

### Step 1: Load Your Data

```r
# Load required packages
library(tidyverse)
library(gapminder)  # Or read your own data

# For your own data:
# my_data <- read_csv("path/to/data.csv")

# Initial exploration
glimpse(gapminder)
summary(gapminder)
```

### Step 2: Formulate Questions

Write down 3-5 specific questions you want to answer:

1. _________________________________
2. _________________________________
3. _________________________________

### Step 3: Explore the Data

```r
# Start with simple visualizations
gapminder |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line(aes(group = country), alpha = 0.2) +
  theme_minimal()
```

### Step 4: Develop Your Story

As you explore, look for:
- Surprising patterns
- Clear trends
- Interesting comparisons
- Questions that lead to more questions

### Step 5: Polish and Refine

Apply all the design principles:
- Remove clutter
- Direct attention
- Create visual hierarchy
- Use color strategically

---

## Example Project Structure

```
capstone_project/
├── capstone_project.Rproj
├── data/
│   └── raw_data.csv
├── scripts/
│   ├── 01_data_cleaning.R
│   └── 02_analysis.R
├── output/
│   └── figures/
├── report/
│   ├── capstone_report.Rmd
│   └── capstone_report.html
└── README.md
```

---

## Tips for Success

### Do:
- Start early and iterate
- Keep your narrative simple and focused
- Get feedback from peers
- Let the data guide your story
- Use consistent styling throughout

### Don't:
- Try to show everything at once
- Use 3D charts or pie charts
- Forget to label your axes
- Over-complicate your visualizations
- Leave out your interpretations

---

## Example Mini-Story

Here's a brief example of how findings can build into a story:

```r
# Hook: A surprising fact
"Did you know that some countries have actually seen life expectancy DECREASE?"

# Context: Setting the scene
"Globally, life expectancy has increased dramatically since 1952..."
[Show global trend line]

# Tension: But not everywhere
"However, certain regions have faced setbacks..."
[Show faceted comparison by continent]

# Insight: The specific finding
"The HIV/AIDS epidemic devastated life expectancy in Sub-Saharan Africa..."
[Show specific affected countries highlighted]

# Resolution: What we learn
"This shows how health crises can reverse decades of progress..."
[Show recovery in recent years]
```

---

## Presentation

On the final day, you will present your project:

- **Duration**: 5-7 minutes per person
- **Format**: Share your screen showing key visualizations
- **Content**: Walk through your data story, highlighting key findings
- **Q&A**: 2-3 minutes for questions

Presentation tips:
- Don't read from your slides
- Let visualizations tell the story
- Practice your timing
- Be prepared to explain your design choices

---

## Resources

### Documentation
- [ggplot2 documentation](https://ggplot2.tidyverse.org/)
- [R for Data Science](https://r4ds.had.co.nz/)
- [Data Visualization: A Practical Introduction](https://socviz.co/)

### Inspiration
- [Information is Beautiful](https://informationisbeautiful.net/)
- [FlowingData](https://flowingdata.com/)
- [Storytelling with Data](https://www.storytellingwithdata.com/)

### Getting Help
- Course materials from all modules
- Office hours
- Peer collaboration (discuss ideas, not code)

---

## Submission

Submit the following by [DATE]:

1. **R Markdown file** (.Rmd) with all code
2. **Compiled report** (.html or .pdf)
3. **Executive summary** (separate 1-page document)

Name your files: `lastname_firstname_capstone.Rmd`

---

Good luck! Remember: the best data stories are simple, focused, and reveal something meaningful about the world.

---

## Appendix: Starter Code Templates

### Template 1: Gapminder Analysis

```r
# Capstone Project: Gapminder Analysis
# Author: [Your Name]
# Date: [Date]

# Setup
library(tidyverse)
library(gapminder)
library(patchwork)

# Custom theme
theme_capstone <- function() {
  theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(color = "grey40"),
      panel.grid.minor = element_blank()
    )
}

# Data exploration
gapminder |> glimpse()

# Your analysis begins here...
```

### Template 2: Report Structure

```markdown
---
title: "Capstone Project: [Your Title]"
author: "[Your Name]"
date: "`r Sys.Date()`"
output:
  html_document:
    toc: true
    toc_float: true
    theme: flatly
---

# Introduction

[Your introduction here]

# Data Description

[Describe your data]

# Exploratory Analysis

[Initial findings]

# Main Findings

## Finding 1: [Title]

[Your visualization and interpretation]

## Finding 2: [Title]

[Your visualization and interpretation]

# Conclusions

[Your conclusions]
```

---

*Congratulations on completing the Storytelling with Data course! Now go tell compelling data stories!*

# Module 00: Course Setup

## Learning Objectives

By the end of this module, you will be able to:
- Install R and RStudio on your computer
- Understand what packages are and why we use them
- Install and load packages
- Write your first R code

---

## Part 1: Installing R and RStudio

### What is R?

**R** is a programming language designed for data analysis and visualization. Think of it as the engine of a car - it does all the work.

### What is RStudio?

**RStudio** is an application that makes working with R easier and more pleasant. Think of it as the dashboard and steering wheel - it helps you control the engine.

### Installation Steps

#### Step 1: Install R

1. Go to [https://cran.r-project.org/](https://cran.r-project.org/)
2. Click on your operating system:
   - **Windows**: Click "Download R for Windows" → "base" → "Download R x.x.x for Windows"
   - **Mac**: Click "Download R for macOS" → Choose the appropriate version for your Mac
   - **Linux**: Follow the instructions for your distribution
3. Run the installer and accept all default settings

#### Step 2: Install RStudio

1. Go to [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
2. Scroll down and download the free RStudio Desktop version for your operating system
3. Run the installer and accept all default settings

#### Step 3: Verify Installation

1. Open RStudio (not R!)
2. You should see a window divided into several panels
3. In the **Console** panel (usually bottom-left), type:
   ```r
   1 + 1
   ```
4. Press Enter. If you see `[1] 2`, congratulations - R is working!

---

## Part 2: Understanding the RStudio Interface

When you open RStudio, you'll see four main panels:

```
┌─────────────────────┬─────────────────────┐
│                     │                     │
│   Source Editor     │   Environment       │
│   (Write scripts)   │   (Your data)       │
│                     │                     │
├─────────────────────┼─────────────────────┤
│                     │                     │
│   Console           │   Files/Plots/Help  │
│   (Run commands)    │   (Output & files)  │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

- **Source Editor**: Where you write and save your code
- **Console**: Where code runs and results appear
- **Environment**: Shows your data and variables
- **Files/Plots/Help**: Shows files, visualizations, and help documentation

---

## Part 3: Understanding Packages

### What are Packages?

Packages are collections of functions that extend what R can do. Think of R as a smartphone and packages as apps - the phone works on its own, but apps make it much more useful.

### Why Do We Need Packages?

- **Base R** is powerful but limited for modern data science
- **Packages** provide specialized tools (like ggplot2 for visualization)
- They save you from writing complex code from scratch

### Key Packages for This Course

| Package | Purpose |
|---------|---------|
| `tidyverse` | Collection of packages for data science (includes ggplot2, dplyr, tidyr) |
| `gapminder` | Dataset about global development |
| `gtsummary` | Create beautiful summary tables |
| `here` | Manage file paths in projects |
| `naniar` | Visualize and handle missing data |

---

## Part 4: Installing Packages

### Method 1: Using Code (Recommended)

In the Console, type:

```r
# Install a single package
install.packages("tidyverse")

# Install multiple packages at once
install.packages(c("gapminder", "gtsummary", "here", "naniar"))
```

**Important**: You only need to install a package **once** on your computer (like installing an app).

### Method 2: Using RStudio Menu

1. Go to **Tools** → **Install Packages...**
2. Type the package name
3. Click **Install**

---

## Part 5: Loading Packages

Installing a package downloads it to your computer. **Loading** a package makes it available to use in your current session.

```r
# Load packages at the start of every script
library(tidyverse)
library(gapminder)
```

**Important**: You must load packages **every time** you start a new R session (like opening an app).

### The Difference: Install vs Load

| Action | Frequency | Function |
|--------|-----------|----------|
| Install | Once per computer | `install.packages("name")` |
| Load | Every R session | `library(name)` |

---

## Part 6: Your First R Script

Let's create your first R script!

1. **Create a new script**: File → New File → R Script (or Ctrl+Shift+N)

2. **Type this code**:

```r
# My First R Script
# Course: Storytelling with Data

# Load packages
library(tidyverse)
library(gapminder)

# Look at the gapminder data
gapminder

# Create a simple plot
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
```

3. **Save your script**: File → Save (or Ctrl+S)

4. **Run the code**: Select all code and press Ctrl+Enter (or Cmd+Enter on Mac)

---

## Part 7: The Pipe Operator

### What is the Pipe?

The pipe (`|>`) is a way to chain commands together. It takes the output of one function and passes it as input to the next.

### Reading Pipe Code

Read `|>` as **"and then"**:

```r
gapminder |>              # Take gapminder data, AND THEN
  filter(year == 2007) |>  # keep only year 2007, AND THEN
  select(country, lifeExp) # select these columns
```

### Why Use the Pipe?

**Without pipe** (nested, hard to read):
```r
select(filter(gapminder, year == 2007), country, lifeExp)
```

**With pipe** (clear, readable):
```r
gapminder |>
  filter(year == 2007) |>
  select(country, lifeExp)
```

---

## Exercises

### Exercise 1: Install and Load
1. Install the `palmerpenguins` package
2. Load it with `library(palmerpenguins)`
3. Type `penguins` to see the data

### Exercise 2: Your First Pipe
```r
# Complete this code to filter penguins from "Adelie" species
penguins |>
  filter(species == "______")
```

### Exercise 3: Explore a Dataset
```r
# Use these functions to explore gapminder
gapminder |> head()        # First 6 rows
gapminder |> tail()        # Last 6 rows
gapminder |> glimpse()     # Overview of structure
gapminder |> summary()     # Statistical summary
```

---

## Troubleshooting

### "Package not found" error
- Check spelling (R is case-sensitive)
- Make sure you installed the package first

### "Could not find function" error
- Did you load the package with `library()`?

### Installation fails
- Check your internet connection
- Try: `install.packages("name", dependencies = TRUE)`

---

## Checklist Before Class

- [ ] R is installed
- [ ] RStudio is installed
- [ ] tidyverse package is installed
- [ ] gapminder package is installed
- [ ] You can run `library(tidyverse)` without errors
- [ ] You created and saved an R script

---

## Next Module

[Module 01: Introduction to Data Visualization and Storytelling →](../01_introduction/)

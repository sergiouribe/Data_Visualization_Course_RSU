# ============================================================================
# Module 00: Course Setup - Practice Script
# Storytelling with Data Course
# ============================================================================

# ----------------------------------------------------------------------------
# PART 1: Installing Packages (Run only once!)
# ----------------------------------------------------------------------------

# Uncomment the lines below and run them to install packages
# You only need to do this ONCE on your computer

# install.packages("tidyverse")
# install.packages("gapminder")
# install.packages("gtsummary")
# install.packages("here")
# install.packages("naniar")

# Or install all at once:
# install.packages(c("tidyverse", "gapminder", "gtsummary", "here", "naniar"))


# ----------------------------------------------------------------------------
# PART 2: Loading Packages (Run every session)
# ----------------------------------------------------------------------------

# Load the packages we'll use
library(tidyverse)
library(gapminder)

# You should see some messages - that's normal!
# If you see errors, the package might not be installed


# ----------------------------------------------------------------------------
# PART 3: Exploring the Gapminder Dataset
# ----------------------------------------------------------------------------

# Just type the name to see the data
gapminder

# How many rows and columns?
dim(gapminder)

# See the structure of the data
glimpse(gapminder)

# Get a statistical summary
summary(gapminder)

# See the first few rows
head(gapminder)

# See the last few rows
tail(gapminder)


# ----------------------------------------------------------------------------
# PART 4: Introduction to the Pipe |>
# ----------------------------------------------------------------------------

# The pipe |> passes data from left to right
# Read it as "and then"

# Example 1: View the first 10 rows
gapminder |>
  head(10)

# Example 2: Filter to only European countries
gapminder |>
  filter(continent == "Europe")

# Example 3: Filter to year 2007 and select specific columns
gapminder |>
  filter(year == 2007) |>
  select(country, lifeExp, gdpPercap)

# Example 4: Chain multiple operations
gapminder |>
  filter(year == 2007) |>
  filter(continent == "Europe") |>
  arrange(desc(lifeExp)) |>
  head(5)


# ----------------------------------------------------------------------------
# PART 5: Your First Visualization
# ----------------------------------------------------------------------------

# A simple scatter plot
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Add color by continent
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point()

# Make points bigger based on population
gapminder |>
  filter(year == 2007) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7)


# ----------------------------------------------------------------------------
# EXERCISES: Try these yourself!
# ----------------------------------------------------------------------------

# Exercise 1: Filter gapminder to show only data from Asia
# gapminder |>
#   filter(continent == "______")


# Exercise 2: Find the 5 countries with the highest GDP per capita in 2007
# gapminder |>
#   filter(year == ____) |>
#   arrange(desc(______)) |>
#   head(5)


# Exercise 3: Create a plot showing life expectancy over time for Latvia
# gapminder |>
#   filter(country == "______") |>
#   ggplot(aes(x = ____, y = ____)) +
#   geom_line()


# ----------------------------------------------------------------------------
# COMMON ERRORS AND SOLUTIONS
# ----------------------------------------------------------------------------

# Error: "could not find function"
# Solution: Make sure you loaded the package with library()

# Error: "object not found"
# Solution: Check spelling - R is case-sensitive!

# Error: "unexpected symbol"
# Solution: Check for missing commas, quotes, or parentheses


# ============================================================================
# END OF SCRIPT
# ============================================================================

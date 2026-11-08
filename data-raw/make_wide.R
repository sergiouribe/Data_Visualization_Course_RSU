# data-raw/make_wide.R
# Creates three wide Gapminder tables (one row per country, one column per year).
# Students reshape and join them in classes 5 and 9.
# Run once from the project root: source(here::here("data-raw", "make_wide.R"))

pacman::p_load(tidyverse, gapminder, here)

# Life expectancy (keeps continent)
gapminder |>
  select(country, continent, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp) |>
  write_csv(here("data", "life_expectancy_wide.csv"))

# Income per person (GDP per capita)
gapminder |>
  select(country, year, gdpPercap) |>
  pivot_wider(names_from = year, values_from = gdpPercap) |>
  write_csv(here("data", "income_wide.csv"))

# Population
gapminder |>
  select(country, year, pop) |>
  pivot_wider(names_from = year, values_from = pop) |>
  write_csv(here("data", "population_wide.csv"))

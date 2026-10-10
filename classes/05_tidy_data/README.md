# Class 05. Tidy data

**When:** Sat 17 Oct 2026, 12:30-14:00 (in person, 90 min)  
**Data:** Gapminder wide (life expectancy)

**Goal:** Students reshape a wide table and draw a line plot.

## Plan

| Minutes | Activity |
|---|---|
| 0-15 | Three rules of tidy data. Show why the wide table cannot be plotted. |
| 15-45 | `pivot_longer()` step by step: `cols`, `names_to`, `values_to`. |
| 45-65 | Line plot of five countries. Time variable on the x axis. |
| 65-80 | `case_when()`: turn life expectancy into three groups and count them with `geom_bar()`. |
| 80-90 | Students pick five other countries and describe the largest change. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- Broman and Woo, [Data organization in spreadsheets](https://peerj.com/preprints/3183v1/).
- [R4DS 2e](https://r4ds.hadley.nz/), chapter 5, Data tidying.

## Deliverable

Reshaped table, a line plot of five countries, and a bar chart of life-expectancy groups.

## Files

- [05_tidy_data.qmd](05_tidy_data.qmd)
- [05_exercise_add_continent.qmd](05_exercise_add_continent.qmd): extra exercise. Add the continent to each country with `countrycode` (uses `data/gapminder_life_expectancy_wide.csv`).

## Notes

`data/life_expectancy_wide.csv` comes from `data-raw/make_wide.R`.

# Class 08. Pivoting

**When:** Fri 23 Oct 2026, 19:45-21:15 (in person, 90 min)  
**Data:** Gapminder wide (194 countries), penguins

**Goal:** Students reshape a table in both directions.

## Plan

| Minutes | Activity |
|---|---|
| 0-15 | Tidy data recap with the wide life expectancy table. |
| 15-40 | `pivot_longer()` on Estonia, Latvia and Lithuania: `cols`, `names_to`, `values_to`. |
| 40-60 | Line plot of the long table. |
| 60-80 | `pivot_wider()` of the species by sex means from class 7. |
| 80-90 | When to use each shape. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 5, Data tidying.

## Deliverable

The line plot and one wide summary table.

## Files

- [08_pivoting.qmd](08_pivoting.qmd): student version with blanks.
- [08_pivoting_solutions.qmd](08_pivoting_solutions.qmd): teacher version.
- [08_homework_add_continent.qmd](08_homework_add_continent.qmd): homework. Add the continent to each country with `countrycode` (uses `data/gapminder_life_expectancy_wide.csv`).

## Notes

The earlier exercise in [class 5](../05_tidy_data) used the same table. Class 8 repeats it with `here()` and adds `pivot_wider()`.

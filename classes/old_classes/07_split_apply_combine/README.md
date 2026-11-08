# Class 07. Joins, pivots and the Rosling chart

**When:** Fri 23 Oct 2026, 18:00-19:30 (in person, 90 min)  
**Data:** `band_members` and `nycflights13` (joins), Gapminder from class 6

**Goal:** Students join tables, pivot a summary table, draw the Gapminder graphs and animate the Rosling chart.

## Plan

| Minutes | Activity |
|---|---|
| 0-30 | Joins with `band_members`: `left_join()`, `inner_join()`, `full_join()`, `semi_join()`, `anti_join()`. Keys with different names (`join_by()`). Flights and airlines, airports. Row count check. |
| 30-40 | Split, apply, combine plus a join: gap between each country and its continent mean. |
| 40-60 | `pivot_wider()` and `pivot_longer()` on a summary table. `names_transform = as.integer`. |
| 60-75 | Graphs: one line per country, `facet_wrap()`, the Rosling chart in four steps. |
| 75-90 | `gganimate`: `transition_time()`, `transition_reveal()`. Students animate Europe. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 19, Joins.

## Deliverable

The animated chart of Europe (section 9) and one sentence about what you see.

## Files

- [slides_07_joins_pivots_animation.qmd](slides_07_joins_pivots_animation.qmd): teacher slides (revealjs).
- [07_split_apply_combine.qmd](07_split_apply_combine.qmd): student version with blanks.
- [07_split_apply_combine_solutions.qmd](07_split_apply_combine_solutions.qmd): teacher version.

## Notes

Students need `data/gapminder_regions.csv` from class 6. If someone missed class 6, give them the three code chunks of section 1 to 2 of the class 6 worksheet. Install `gganimate` and `gifski` before the class: the animation chunk takes about 30 seconds. Classes 8, 9 and 10 cover pivots, joins and the Rosling chart in more depth.

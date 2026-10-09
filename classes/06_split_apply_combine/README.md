# Class 06. Split, apply, combine

**When:** Sat 17 Oct 2026, 14:15-15:45 (in person, 90 min)  
**Data:** Gapminder long, NHANES

**Goal:** Students summarize by group and plot the summary table.

## Plan

| Minutes | Activity |
|---|---|
| 0-15 | Split, apply, combine as three words. `count()` as the shortest case. |
| 15-45 | `group_by()` + `summarize()`. Weighted mean of life expectancy by continent and year. |
| 45-60 | Pipe the summary table into `geom_line()` and `geom_col()`. |
| 60-70 | `arrange()` and `desc()` to rank a summary table. |
| 70-90 | NHANES mean by group. Students do the exercise. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 3, Data transformation (section on groups).

## Deliverable

Life expectancy by continent over time, and an NHANES mean by group.

## Files

- [06_split_apply_combine.qmd](06_split_apply_combine.qmd)

## Notes

Weighted versus unweighted means: show both once and ask which is honest for a continent.

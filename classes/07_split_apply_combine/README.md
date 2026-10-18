# Class 07. Split, apply, combine

**When:** Fri 23 Oct 2026, 18:00-19:30 (in person, 90 min)  
**Data:** Penguins, Latvian Labour Force Survey

**Goal:** Students summarize by group and draw a sorted bar chart of the summary.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Review the homework on dplyr verbs (penguins). |
| 10-25 | The idea: split, apply, combine. Mean body mass per species. |
| 25-45 | Several summaries (`mean()`, `median()`, `n()`), two groups (species and sex), `na.rm = TRUE`. |
| 45-60 | `count()` and `arrange(desc())`. |
| 60-80 | Sorted bar chart of group means with `geom_col()` and `fct_reorder()`. |
| 80-90 | Closing question: employed people by sex in the Latvian survey. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 3, Data transformation (section on groups).

## Deliverable

One grouped table and one bar chart.

## Files

- [07_split_apply_combine.qmd](07_split_apply_combine.qmd): student version with blanks.
- [07_split_apply_combine_solutions.qmd](07_split_apply_combine_solutions.qmd): teacher version.

## Notes

Class 6 used Gapminder and NHANES for the same idea. Today uses penguins, so students practise it on a table they know. The Labour Force Survey question works best with the full file in `data/lfs_2025_example.csv`; the 7-row sample only shows the code.

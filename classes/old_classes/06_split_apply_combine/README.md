# Class 06. Split, apply, combine

**When:** Sat 17 Oct 2026, 14:15-15:45 (in person, 90 min)  
**Data:** Gapminder (CSV from Google Drive), `countrycode`

**Goal:** Students add continent and subregion to Gapminder, summarize by group and plot the summary table.

## Plan

| Minutes | Activity |
|---|---|
| 0-15 | Download the CSV. `clean_names()` and `rename()`. |
| 15-30 | `countrycode()`: continent, subregion, check for unmatched names. Save `gapminder_regions.csv`. |
| 30-45 | Split, apply, combine as three words. `count()`, `summarize()` alone, then with `group_by()`. |
| 45-60 | `n()`, `weighted.mean()`, two groups and `.groups = "drop"`, `arrange()`. |
| 60-75 | Pipe the summary table into `geom_line()` and `geom_col()`. `fct_reorder()`. |
| 75-90 | Students do the exercises (median income, subregions of Europe). |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 3, Data transformation (section on groups).

## Deliverable

Life expectancy by continent over time, and one more plot by continent or subregion.

## Files

- [slides_06_split_apply_combine.qmd](slides_06_split_apply_combine.qmd): teacher slides (revealjs).
- [06_split_apply_combine.qmd](06_split_apply_combine.qmd): student version with blanks.
- [06_split_apply_combine_solutions.qmd](06_split_apply_combine_solutions.qmd): teacher version.

## Notes

The CSV link is in the slides and in the worksheet. Students run the download once; every later chunk reads `data/gapminder.csv`. Weighted versus unweighted means: show both once and ask which is honest for a continent. The NHANES exercise of the earlier version is no longer part of this class.

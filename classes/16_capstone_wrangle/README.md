# Class 16. Capstone M2: Wrangle

**When:** Sat 7 Nov 2026, 16:00-17:30 (in person, 90 min)  
**Data:** Own data

**Goal:** Students produce an analysis-ready table from a script.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Check-in: each student states the question in one sentence. |
| 10-70 | Write the pipeline: `filter()`, `mutate()`, `pivot_longer()`, joins, `group_by()` + `summarize()`. |
| 70-90 | Teacher walks around. Students show the head of the clean table to one peer. |

## Deliverable

Clean table from a script.

## Files

- [capstone_template.qmd](../../capstone/capstone_template.qmd)

## Notes

Homework: first draft of the graph by 19 Nov.

**Moodle checkpoint, Fri 13 Nov 2026, 23:59.** Submit a script of about five lines that loads your cleaned data and runs `glimpse()` and `nrow()` without errors. The teacher fixes import problems before class 17.

```r
pacman::p_load(tidyverse, here)
here("data", "my_data.csv") |>
  read_csv(show_col_types = FALSE) |>
  glimpse() |>
  nrow()
```

`glimpse()` returns its input, so `nrow()` receives the table and prints the row count.

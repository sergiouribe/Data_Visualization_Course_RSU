# Data quality checklist

Run these five checks on every table before you plot it. Write one line per check in your script as a comment.

| # | Check | How in R |
|---|---|---|
| 1 | **Types.** Numbers are numbers, categories are text or factors, dates are dates. | `glimpse()` |
| 2 | **Missing values.** How many, in which columns, and why? Do not replace `NA` with 0. | `summarize(across(everything(), \(x) sum(is.na(x))))` |
| 3 | **Units and ranges.** The minimum and maximum make sense. All rows use the same unit. | `summary()`, histogram, scatter plot |
| 4 | **Duplicates.** No row appears twice by mistake. | `count(key, sort = TRUE)`, `duplicated()` |
| 5 | **Row counts.** The number of rows before and after each filter or join matches what you expect. | `nrow()`, `n_distinct()` |

## Decision for each problem found

| Finding | Options |
|---|---|
| Impossible value (typo, wrong unit) | Fix from the source, or set to `NA` and report it |
| Extreme but possible value | Keep it. Explain it in the notes |
| Missing values | Report how many. Drop or impute only with a reason |
| Duplicated rows | Find why (bad join, repeated record), then fix the cause |

Use the checklist in class 3 (penguins), class 9 (after the joins), class 15 (own data), class 16 (clean table), and the Moodle checkpoint.

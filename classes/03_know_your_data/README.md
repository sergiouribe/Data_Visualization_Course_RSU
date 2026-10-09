# Class 03. Know your data: type decides the chart

**When:** Sat 17 Oct 2026, 09:00-10:30 (in person, 90 min)  
**Data:** Penguins

**Goal:** Students pick a chart from the type of each variable.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Why data knowledge comes first. `glimpse()`, `is.na()`, number, category, date. |
| 10-30 | One number: histogram. Two numbers: scatter. |
| 30-45 | Outliers in the histogram and the scatter plot: data error or real value? |
| 45-55 | One category: bar of counts. Number by category: box plot. Time: line. |
| 55-65 | Add variables with color, shape, size and facet. Explain why 3D adds nothing. |
| 65-75 | Data quality checklist: five checks on `penguins`. |
| 75-90 | Students fill the chart-by-type map with five graphs. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 10, Exploratory data analysis.
- [Points of view: Bar charts and box plots](https://www.nature.com/articles/nmeth.2807), Nature Methods 11, 117.
- Knaflic, *Storytelling with Data*, chapter 2, Choosing an effective visual.

## Deliverable

Chart-by-type map filled with five graphs, and one sentence per outlier (error or real value).

## Files

- [03_know_your_data.qmd](03_know_your_data.qmd)

## Notes

`geom_bar()` counts rows. `geom_col()` draws values already in the table. Show both.

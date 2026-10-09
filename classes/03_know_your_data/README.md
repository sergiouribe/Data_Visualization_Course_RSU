# Class 03. Know your data: type decides the chart

**When:** Sat 17 Oct 2026, 09:00-10:30 (in person, 90 min)  
**Data:** Penguins

**Goal:** Students recognize common chart mistakes and pick a chart from the type of each variable.

## Plan

| Minutes | Activity |
|---|---|
| 0-20 | **Recap.** Bad graphs from class 1 rebuilt with penguins (baseline, wrong graph, y axis). The five principles on one slide. Today's focus: **Show**. |
| 20-30 | Know the data: `glimpse()`, `is.na()`, number, category, date. |
| 30-50 | One number: histogram. Two numbers: scatter. Outliers: data error or real value? |
| 50-60 | One category: bar of counts. Number by category: box plot. Time: line. |
| 60-70 | Add variables with color, shape, size and facet. Explain why 3D adds nothing. |
| 70-75 | Data quality checklist: five checks on `penguins`. |
| 75-90 | Apply **Show** with `labs()` to your graphs. Fill the chart-by-type map with five graphs. |

Cut, Focus and Tell are taught in classes 7 and 8.

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

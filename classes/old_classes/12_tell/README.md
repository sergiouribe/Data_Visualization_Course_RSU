# Class 12. Principle: Tell

**When:** Sat 24 Oct 2026, 14:15-15:45 (in person, 90 min)  
**Data:** `data/rosling_tidy.csv`, the Rosling chart of classes 10 and 11

**Goal:** Students write the message of the chart, state it in the title, point to it with an annotation and export the chart.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Topic title versus active title. |
| 10-20 | **One-sentence message (pair exercise):** write it with numbers. The partner reads the chart and states the message. Check the numbers against the data. |
| 20-45 | `labs()`: title, subtitle, axes, source. Break a long title with `\n`. |
| 45-65 | `annotate()` and `geom_vline()`: text and reference lines. |
| 65-80 | **Your theme in 3 lines:** `theme_minimal(base_size = 14) + theme(plot.title = element_text(face = "bold"), legend.position = "bottom")`. Export with `ggsave(dpi = 300)`. |
| 80-90 | Gallery walk: each student reads one title aloud. Optional last step: animate with `transition_time(year)` (needs `gganimate` and `gifski`). |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 11, Communication.
- [Points of view: Labels and callouts](https://www.nature.com/articles/nmeth.2405), Nature Methods 10, 275.
- [Design of data figures](https://www.nature.com/articles/nmeth0910-665), Nature Methods 7, 665.
- [BBC Visual and Data Journalism cookbook for R graphics](https://bbc.github.io/rcookbook/).

## Deliverable

The exported PNG (300 dpi) with an active title, an annotation and the three-line theme.

## Files

- [12_tell.qmd](12_tell.qmd): student version with blanks.
- [12_tell_solutions.qmd](12_tell_solutions.qmd): teacher version.

## Notes

Check every number in the title against the data before class. In 2007, the 54 countries above $10,000 per person have a mean life expectancy of 76 years. The 88 others have 61 years.

This class replaces the earlier classes 8 (Tell) and 12 (Rosling polish). The animation is optional; the teacher demo is in [class 14](../14_animation_and_questions).

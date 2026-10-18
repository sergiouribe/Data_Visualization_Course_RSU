# Class 10. Rosling chart, 2007

**When:** Sat 24 Oct 2026, 10:45-12:15 (in person, 90 min)  
**Data:** `data/rosling_tidy.csv` (Gapminder, 142 countries)

**Goal:** Students build the static Rosling chart for 2007, with dollar labels and a viridis palette.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Show the Rosling video clip with the 2007 frame. Four variables in the chart. |
| 10-30 | `scale_x_log10()`: why a log axis. |
| 30-45 | `scale_size_area()`: why area, not radius. |
| 45-55 | Color by continent. Axis number format with `scales::label_dollar()`. |
| 55-75 | **Viridis exercise (about 15 min):** default colors, `scale_color_viridis_d()` for categories, `scale_color_viridis_c()` for numbers. Question: which version can you read in a black and white printout? |
| 75-90 | Students compare their chart with the clip. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [Points of view: Plotting symbols](https://www.nature.com/articles/nmeth.2490), Nature Methods 10, 451.
- [R4DS 2e](https://r4ds.hadley.nz/), chapter 9, Layers (scales).

## Deliverable

Static Rosling chart for 2007 with dollar labels and a viridis palette.

## Files

- [10_rosling_assembly.qmd](10_rosling_assembly.qmd): student version with blanks.
- [10_rosling_assembly_solutions.qmd](10_rosling_assembly_solutions.qmd): teacher version.

## Notes

Video: https://www.youtube.com/watch?v=hVimVzgtD6w

Viridis is the default palette of the course. Class 11 shows when to use gray plus one color instead.

Put the dollar labels inside the existing `scale_x_log10()`. A second `scale_x_log10()` replaces the first one.

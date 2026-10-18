# Class 11. Principles: Cut, Focus and themes

**When:** Sat 24 Oct 2026, 12:30-14:00 (in person, 90 min)  
**Data:** `data/rosling_tidy.csv`, the Rosling chart of class 10

**Goal:** Students declutter the Rosling chart with a theme and highlight one group.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Non-data ink. The close-your-eyes test on the class 10 chart. |
| 10-45 | **Themes exercise (about 15 min):** the same chart with `theme_gray()`, `theme_minimal()`, `theme_classic()` and `theme_bw()`. Question: which theme removes the most marks that carry no data? Then `theme_minimal(base_size = 14) + theme(legend.position = "bottom", panel.grid.minor = element_blank())`. Pairs choose a theme for a slide and name the principle (Cut). |
| 45-70 | Focus: gray plus one color. Direct labels with `ggrepel`. Preattentive attributes. |
| 70-80 | **Viridis against gray plus one color (5 min):** viridis shows a variable with several groups or a numeric scale. Gray plus one color highlights one group. Students make both Rosling versions. |
| 80-90 | Students list what they cut and what they highlighted. |

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- Knaflic, *Storytelling with Data*, chapters 3 and 4 (clutter, focus attention).
- [Points of view: Elements of visual style](https://www.nature.com/articles/nmeth.2444), Nature Methods 10, 371.
- [Points of view: Axes, ticks and grids](https://www.nature.com/articles/nmeth.2337), Nature Methods 10, 183.

## Deliverable

Before and after of the Rosling chart, with a list of what was cut and what was highlighted.

## Files

- [11_cut_focus_themes.qmd](11_cut_focus_themes.qmd): student version with blanks.
- [11_cut_focus_themes_solutions.qmd](11_cut_focus_themes_solutions.qmd): teacher version.

## Notes

Sources: Knaflic chapters 3 and 4. This class replaces the earlier classes 7 (Cut and Focus) and 12 (Rosling polish).

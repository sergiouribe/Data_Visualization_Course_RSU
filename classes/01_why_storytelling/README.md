# Class 01. Why storytelling matters

**When:** Sat 10 Oct 2026, 13:45-15:15 (in person, 90 min)  
**Data:** Examples built from Gapminder and penguins

**Goal:** Students see why a graph needs a question, spot eight mistakes, and leave with a working RStudio project.

## Files

- [01_bad_graphs.qmd](01_bad_graphs.qmd): teacher file with eight graphs, the mistake in each, and the fix.
- [worksheet_bad_graphs.md](worksheet_bad_graphs.md): student worksheet (print one per student).
- [01_setup_check.qmd](01_setup_check.qmd): student file for the last 20 minutes.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Welcome. Each student says name, background, and one graph they saw this week. Course map: 20 classes, one final graph. |
| 10-20 | Five principles on one slide: **Ask, Show, Cut, Focus, Tell**. Say that every class adds one. Show the end goal: the Rosling chart (play 60 seconds of the video). |
| 20-50 | Part A, design mistakes (graphs 1 to 4 in `01_bad_graphs.qmd`). For each: show for 60 seconds, students write on the worksheet, 2 minutes of discussion, then reveal. |
| 50-55 | Break the rhythm: stand up, stretch, 5 minutes. |
| 55-70 | Part B, data errors behind the graph (graphs 5 to 8). Message: a clean-looking graph can hide a wrong table. Link forward: class 3 (missing values), class 6 (percentages), class 9 (joins). |
| 70-75 | Wrap the discussion: each student reads one row of the worksheet aloud. |
| 75-90 | Setup: RStudio Project, console, `pacman::p_load()`, `here()`, `01_setup_check.qmd`. |

## Notes

- **Time:** class starts 13:45 and ends 15:15. The next class starts at 15:30.
- **Students run no code until minute 75.** The first hour is looking and talking. This is intended: they learn to see before they learn to build.
- **Graph 4:** Latvia is not in Gapminder, so the highlight is empty. Use it as a live example of a silent error. Then change to `"Poland"`.
- **Graph 3:** change `+ 30` to `+ 10` live to show that the author controls the story.
- **Setup problems:** have these fixes ready. Most failures are a missing package (run `install.packages("pacman")`) or opening the `.R` file without the project (close RStudio, double-click the `.Rproj`).
- **Bring your own examples:** replace or add one real graph from a news site or a paper that the students may know. The eight examples here are built from open data so that you can show and fix them in the same file.

## Deliverable

1. The completed worksheet (eight rows).
2. A working RStudio Project: `here()` prints the course folder and the five checks in `01_setup_check.qmd` pass.

## Sources

Knaflic, *Storytelling with Data* (chapter 1, context). Healy, *Data Visualization* (chapter 1, why look at data). Wong, *The Wall Street Journal Guide to Information Graphics* (rules on bars and pies).

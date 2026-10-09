# Class 02. Setup, RStudio basics and the first graph

**When:** Sat 10 Oct 2026, 15:30-17:00 (in person, 90 min)  
**Data:** Penguins

**Goal:** Every student has a working RStudio project, knows the main shortcuts, and draws a first scatter plot with a one-line question.

## Files

- [rstudio_basics.md](rstudio_basics.md): one page on panes, shortcuts, errors, and what to do if the installation fails. Print or share it.
- [02_setup_check.qmd](02_setup_check.qmd): five checks that prove the setup works.
- [02_first_graph.qmd](02_first_graph.qmd): the first graph.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Open the project: clone or unzip the repo, double-click `data_visualization_course.Rproj`. Check the project name at the top right of RStudio. |
| 10-20 | RStudio tour: four panes, console versus file, what a chunk is. Use [rstudio_basics.md](rstudio_basics.md). |
| 20-35 | Shortcuts and `02_setup_check.qmd`: run the five chunks. Fix errors with the teacher. |
| 35-40 | Question for today: do penguins with longer flippers weigh more? Write it in a comment. |
| 40-55 | Teacher demo of `data + aes + geom` and the pipe `\|>`. |
| 55-80 | Students run `02_first_graph.qmd`, change variables, add color. |
| 80-90 | Save with `ggsave(here(...))`. Recap: three parts of every ggplot. |

## Notes for the teacher

- **Expect setup to take time.** Some students have never coded. The plan gives 35 minutes to setup before the first graph.
- **If setup takes more than 45 minutes,** skip the "Your turn" chunk in `02_first_graph.qmd`. Keep the first scatter, the color, and the save.
- **Students whose R does not work today** watch a neighbor, and you fix their installation after class. Posit Cloud is a fallback (see `rstudio_basics.md`).
- **Slow down on four things:** the project (`.Rproj`), `pacman::p_load()`, the pipe, and the `+` at the end of each ggplot line.
- **The Zoom help session on Fri 9 Oct** reduces the load. Ask who attended.

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 1, Data visualization.

## Deliverable

One graph, one sentence that answers the question, saved in the project folder. The setup check passes.

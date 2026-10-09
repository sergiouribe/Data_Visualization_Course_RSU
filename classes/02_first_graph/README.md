# Class 02. Setup, RStudio basics and the first graph

**When:** Sat 10 Oct 2026, 15:30-17:00 (in person, 90 min)  
**Data:** Penguins

**Goal:** Every student has a working RStudio project and the packages installed, knows the main shortcuts, draws a first graph with a one-line question, and exports a copy.

## Files

- [rstudio_basics.md](rstudio_basics.md): one page on projects, panes, shortcuts, autocomplete, errors, export, and what to do if the installation fails. Print or share it.
- [02_setup_check.qmd](02_setup_check.qmd): install commands and five checks that prove the setup works.
- [02_first_graph.qmd](02_first_graph.qmd): the first graph.

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | **Projects.** Clone or unzip the repo, double-click `data_visualization_course.Rproj`. The project name appears at the top right. Run `here()`. Set the two global options (no .RData restore, native pipe). |
| 10-20 | **Packages.** `install.packages("pacman")`, then the `p_load()` line in `02_setup_check.qmd`. Start it during the break if possible. Students with slow installs continue with the first four packages. |
| 20-35 | **Interface and shortcuts.** Four panes, console versus file, chunk versus text, Source versus Visual mode. Shortcuts, autocomplete (Tab, Ctrl+Space), Help (F1), reading an error. |
| 35-40 | **Write and run.** Comments with `#`. Run a line (Ctrl+Enter) and a chunk (Ctrl+Shift+Enter). Restart R. |
| 40-55 | **First graph.** Question in a comment. Teacher demo of `data + aes + geom` and the pipe `\|>`. |
| 55-75 | Students run `02_first_graph.qmd`, change variables, add color and labels. |
| 75-90 | **Export.** Save with `ggsave(here(...))`. Render to HTML, then print to PDF from the browser. |

## Notes for the teacher

- **Expect setup to take time.** Some students have never coded. Installing the packages takes several minutes, so start it during the break.
- **If setup takes more than 45 minutes,** skip the labels and the "Your turn" chunk. Keep the first scatter, the color, and the save.
- **Students whose R does not work today** watch a neighbor, and you fix their installation after class. Posit Cloud is a fallback (see `rstudio_basics.md`).
- **Slow down on four things:** the project (`.Rproj`), `pacman::p_load()`, the pipe, and the `+` at the end of each ggplot line.
- **PDF export:** the reliable route is to render to HTML and print to PDF from the browser. `format: pdf` needs LaTeX (TinyTeX) and often fails. `format: typst` needs Quarto 1.4 or newer. Test both on your laptop before class.
- **The Zoom help session on Fri 9 Oct** reduces the load. Ask who attended.

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- [R4DS 2e](https://r4ds.hadley.nz/), chapter 1, Data visualization.

## Deliverable

One graph, one sentence that answers the question, saved in the project folder, and an HTML or PDF copy of the document. The setup check passes.

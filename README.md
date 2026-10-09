# Data visualization and storytelling (SZF_184)

Rīgas Stradiņa universitāte, autumn 2026. 5 ECTS, 40 contact hours, 20 in-person classes of 90 minutes.
Lecturer: Sergio Uribe.

Students learn to turn a question into a clear graph in R. The course ends with each student recreating Hans Rosling's chart from [The best stats you've ever seen](https://www.youtube.com/watch?v=hVimVzgtD6w) and presenting a graph from their own data.

## Five principles

| Principle | Rule |
|---|---|
| Ask | Write the question and the one-sentence message before the code. |
| Show | Use tidy data, the right chart for the data type, and honest scales. |
| Cut | Remove every mark that does not carry data. |
| Focus | Use gray plus one color. |
| Tell | Write a title that states the finding. Add an annotation. |

## Data type decides the chart

| Variables | Chart |
|---|---|
| 1 number | histogram |
| 2 numbers | scatter plot |
| 1 category | bar of counts (`geom_bar()`; `geom_col()` for precomputed values) |
| number by category | box plot |
| time | line |
| more variables | color, shape, size, facet (no 3D) |

## Schedule

| # | Date | Topic | Data |
|---|---|---|---|
| 1 | Sat 10 Oct, 13:45 | [Why storytelling matters](classes/01_why_storytelling) | Examples |
| 2 | Sat 10 Oct, 15:30 | [Grammar of graphics](classes/02_first_graph) | Penguins |
| 3 | Sat 17 Oct, 09:00 | [Know your data](classes/03_know_your_data) | Penguins |
| 4 | Sat 17 Oct, 10:45 | [`filter()` and `select()`](classes/04_row_column_verbs) | NHANES |
| 5 | Sat 17 Oct, 12:30 | [Tidy data and `case_when()`](classes/05_tidy_data) | Gapminder wide |
| 6 | Sat 17 Oct, 14:15 | [Split, apply, combine, `arrange()`](classes/06_split_apply_combine) | Gapminder, NHANES |
| 7 | Fri 23 Oct, 18:00 | [Cut and Focus](classes/07_cut_and_focus) | Own graphs |
| 8 | Fri 23 Oct, 19:45 | [Tell](classes/08_tell) | Own graphs |
| 9 | Sat 24 Oct, 09:00 | [Joins](classes/09_joins) | Gapminder wide |
| 10 | Sat 24 Oct, 10:45 | [Rosling assembly](classes/10_rosling_assembly) | Gapminder |
| 11 | Sat 24 Oct, 12:30 | [Small multiples](classes/11_small_multiples) | Gapminder |
| 12 | Sat 24 Oct, 14:15 | [Rosling polish](classes/12_rosling_polish) | Gapminder |
| 13 | Thu 29 Oct, 18:00 | [Narrative arc](classes/13_narrative_arc) | Rosling chart |
| 14 | Thu 29 Oct, 19:45 | [Animation demo and capstone questions](classes/14_animation_and_questions) | Own ideas |
| 15 | Fri 30 Oct, 19:45 | [Capstone M1: Ask](classes/15_capstone_ask) | Own data |
| 16 | Sat 7 Nov, 16:00 | [Capstone M2: Wrangle](classes/16_capstone_wrangle) | Own data |
| 17 | Thu 19 Nov, 13:45 | [Capstone M3: Draft](classes/17_capstone_draft) | Own data |
| 18 | Thu 19 Nov, 15:30 | [Capstone M4: Refine](classes/18_capstone_refine) | Own data |
| 19 | Fri 20 Nov, 18:00 | [Presentations 1](classes/19_presentations_1) | Own data |
| 20 | Fri 20 Nov, 19:45 | [Presentations 2](classes/20_presentations_2) | Own data |

Capstone files: [template](capstone/capstone_template.qmd), [rubric](capstone/rubric.md), and [peer scoring sheet](capstone/peer_scoring_sheet.md).

**Moodle checkpoint:** Fri 13 Nov 2026, 23:59. Students submit a short script that loads the clean data and runs `glimpse()` and `nrow()` (see [class 16](classes/16_capstone_wrangle)).

## How to use this repository

1. Download the repository and open `data_visualization_course.Rproj` in RStudio. The project root makes `here()` work.
2. Open the `.qmd` file of the class.
3. Run each chunk with Ctrl+Shift+Enter (Cmd+Shift+Enter on Mac).

Packages load with `pacman::p_load()`. Core set: `tidyverse`, `here`, `janitor`, `gtsummary`. Class packages: `palmerpenguins`, `NHANES`, `gapminder`, `ggrepel`, `gganimate`, `gifski`.

## Data

- `palmerpenguins`, `NHANES`, `gapminder`: R packages.
- `data/life_expectancy_wide.csv`, `data/income_wide.csv`, `data/population_wide.csv`: Gapminder in wide format, made by `data-raw/make_wide.R`. Students reshape them in classes 5 and 9.
- `data/rosling_tidy.csv`: the joined result of class 9. Use it if a student falls behind.

Gapminder covers 142 countries from 1952 to 2007 in steps of 5 years. It does not include Latvia, Estonia, or Lithuania.

## Sources

* Wickham, H., Çetinkaya-Rundel, M., & Grolemund, G. *R for Data Science* (2nd ed.). O'Reilly Media.
* Healy, K. *Data Visualization: A Practical Introduction*. Princeton University Press.
* Knaflic, C. N. *Storytelling with Data: A Data Visualization Guide for Business Professionals*. Wiley.
* Wong, D. M. *The Wall Street Journal Guide to Information Graphics: The Dos and Don'ts of Presenting Data, Facts, and Figures*. W. W. Norton & Company.


## Archive

The earlier module-based version is in [`archive/modules`](archive/modules).

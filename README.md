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

## Data quality

Every table passes the [five-check data quality checklist](capstone/data_quality_checklist.md) before it is plotted: types, missing values, units and ranges, duplicates, row counts.

## Palettes

Viridis is the default palette of the course (`scale_color_viridis_d()` for categories, `scale_color_viridis_c()` for numbers). It stays readable with color blindness and in black and white. Gray plus one color highlights one group (class 11).

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
| 1 | Sat 10 Oct, 13:45 | [Why storytelling matters](classes/01_why_storytelling) (no coding) | Examples |
| 2 | Sat 10 Oct, 15:30 | [Setup, RStudio basics, first graph](classes/02_first_graph) | Penguins |
| 3 | Sat 17 Oct, 09:00 | [Recap and know your data](classes/03_know_your_data) | Penguins |
| 4 | Sat 17 Oct, 10:45 | [`filter()` and `select()`](classes/04_row_column_verbs) | NHANES |
| 5 | Sat 17 Oct, 12:30 | [Tidy data and `case_when()`](classes/05_tidy_data) | Gapminder wide |
| 6 | Sat 24 Oct, 09:00 | [dplyr recap: `select()` and `filter()`](classes/06_dplyr_recap) | Flights |
| 7 | Sat 24 Oct, 09:00 | [Pivoting: `pivot_longer()` and `pivot_wider()`](classes/07_pivot) | Gapminder wide, `table2` |
| 8 | Sat 24 Oct, 10:45 | [Joins: left, inner, full and anti](classes/08_joins) | `band_members`, `band_instruments` |
| 9 | Sat 24 Oct, 09:00 | [Joins](classes/old_classes/09_joins) | Gapminder wide |
| 10 | Sat 24 Oct, 10:45 | [Rosling chart, 2007 (log axis, size, color, viridis)](classes/old_classes/10_rosling_assembly) | Gapminder |
| 11 | Sat 24 Oct, 12:30 | [Cut, Focus and themes](classes/old_classes/11_cut_focus_themes) | Gapminder |
| 12 | Sat 24 Oct, 14:15 | [Tell: message, annotation, export](classes/old_classes/12_tell) | Gapminder |
| 13 | Thu 29 Oct, 18:00 | [Small multiples and narrative arc](classes/old_classes/13_narrative_arc) | Gapminder, Rosling's talk |
| 14 | Thu 29 Oct, 19:45 | [Quarto reports, animation demo, capstone questions](classes/old_classes/14_animation_and_questions) | Own ideas |
| 15 | Fri 30 Oct, 19:45 | [Capstone M1: Ask](classes/old_classes/15_capstone_ask) | Own data |
| 16 | Sat 7 Nov, 16:00 | [Capstone M2: Wrangle](classes/old_classes/16_capstone_wrangle) | Own data |
| 17 | Thu 19 Nov, 13:45 | [Capstone M3: Draft](classes/old_classes/17_capstone_draft) | Own data |
| 18 | Thu 19 Nov, 15:30 | [Capstone M4: Refine](classes/old_classes/18_capstone_refine) | Own data |
| 19 | Fri 20 Nov, 18:00 | [Presentations 1](classes/old_classes/19_presentations_1) | Own data |
| 20 | Fri 20 Nov, 19:45 | [Presentations 2](classes/old_classes/20_presentations_2) | Own data |

Classes 1 to 8 are built. Rows 9 to 20 follow the earlier plan and link to their drafts in [`classes/old_classes`](classes/old_classes). Each class folder is rebuilt before its class. Split, apply, combine is not yet rebuilt: its drafts are in `old_classes/06_split_apply_combine` and `old_classes/07_split_apply_combine`.

Capstone files: [template](capstone/capstone_template.qmd), [rubric](capstone/rubric.md), and [peer scoring sheet](capstone/peer_scoring_sheet.md).

**Moodle checkpoint:** Fri 13 Nov 2026, 23:59. Students submit a short script that loads the clean data and runs `glimpse()` and `nrow()` (see [class 16](classes/old_classes/16_capstone_wrangle)).

## Assessment

| Part | Share of grade | What counts |
|---|---|---|
| Capstone project (the exam) | 60% | One visualization project that joins analysis, visualization and storytelling, presented in 3 minutes. Scored with the [rubric](capstone/rubric.md). |
| Participation | 40% | The deliverable of each class (see the Deliverable section of each class), the individual readings, and the Moodle checkpoint on 13 Nov. |

Projects are individual. Each student works alone. Students may use any dataset for the capstone.

## Coverage of the official theme plan

| Official theme (course description) | Classes |
|---|---|
| Introduction to Data Visualization and Storytelling | 1, 12, 13 |
| Fundamentals of the Grammar of Graphics with ggplot2 | 2, 3 |
| Choosing the Right Visualization | 3, 10, 17 |
| Fundamentals of Data Wrangling: Providing Context to the Data | 4, 5, 6, 7, 8, 9 |
| Simplifying Visuals and Removing Clutter | 11 |
| Directing Audience Attention with Design | 10, 11, 12 |
| Creating Visual Narratives | 12, 13 |
| Reporting and Sharing Visual Stories | 14, 15, 18 |
| Advanced Customization in ggplot2 | 10, 11, 12, 13, 18 |
| Capstone Project: Telling a Data Story | 14 to 20 |

## How to use this repository

1. Download the repository and open `data_visualization_course.Rproj` in RStudio. The project root makes `here()` work.
2. Open the `.qmd` file of the class.
3. Run each chunk with Ctrl+Shift+Enter (Cmd+Shift+Enter on Mac).

Packages load with `pacman::p_load()`. Core set: `tidyverse`, `here`, `janitor`, `gtsummary`. Class packages: `palmerpenguins`, `countrycode`, `NHANES`, `gapminder`, `ggrepel`, `gganimate`, `gifski`.

## Data

- `palmerpenguins`, `NHANES`, `gapminder`: R packages. `band_members` and `band_instruments` (dplyr) and `table2` (tidyr) come with the tidyverse.
- `data/life_expectancy_wide.csv`, `data/income_wide.csv`, `data/population_wide.csv`: Gapminder in wide format, made by `data-raw/make_wide.R`. Students reshape and join them in later classes.
- `data/gapminder_life_expectancy_wide.csv`: life expectancy from the Gapminder Foundation (194 countries, one column per year, 1800 to 2100; years after 2023 are projections). Columns `geo` (ISO3 code) and `name`; no continent. Used in the pivot exercises of class 5 and in class 7. The continent homework is in `classes/old_classes/08_pivoting`.
- `data/lfs_2025_example.csv`, `data/lfs_codebook.md`: 7-row sample of the Latvian Labour Force Survey 2025 (Central Statistical Bureau of Latvia, [data.gov.lv](https://data.gov.lv/dati/lv/dataset/darbspeka-apsekojums)) and an English codebook of the variables used. Replace the sample with the full file under the same name. Used in the dplyr exercise of class 4.
- `data/flights.csv`: all 336,776 flights from New York in 2013 (`nycflights13::flights`, saved with `write_csv()`). Used in class 6. The file is large and the repository does not store it, so students download it separately.
- `data/rosling_tidy.csv`: the three Gapminder tables joined into one. Use it if a student falls behind.

Gapminder covers 142 countries from 1952 to 2007 in steps of 5 years. It does not include Latvia, Estonia, or Lithuania.

## Readings

Required reading in the course description: Knaflic, *Storytelling with Data*; Broman and Woo, [Data organization in spreadsheets](https://peerj.com/preprints/3183v1/); Ellis and Leek, [How to share data for collaboration](https://www.tandfonline.com/doi/full/10.1080/00031305.2017.1375987); Wickham et al., [R for Data Science (2e)](https://r4ds.hadley.nz/). Each class README lists its readings (individual work, about 30 minutes).

| Class | Reading |
|---|---|
| 1 | Knaflic ch. 1 |
| 2 | R4DS ch. 1 |
| 3 | R4DS ch. 10; Nature Methods, Bar charts and box plots; Knaflic ch. 2 |
| 4 | R4DS ch. 3 |
| 5 | Broman and Woo; R4DS ch. 5 |
| 6 | R4DS ch. 3 |
| 7 | R4DS ch. 5 |
| 8 | R4DS ch. 19 |
| 9 | R4DS ch. 19 |
| 10 | Nature Methods, Plotting symbols; R4DS ch. 9 |
| 11 | Knaflic ch. 3 and 4; Nature Methods, Elements of visual style, and Axes, ticks and grids |
| 12 | R4DS ch. 11; Nature Methods, Labels and callouts, and Design of data figures; BBC R cookbook |
| 13 | Knaflic ch. 7; Nature Methods, Storytelling, and Multidimensional data; R4DS ch. 9 |
| 14 | R4DS ch. 28 and 29 |
| 15 | Ellis and Leek; R4DS ch. 7 |
| 16 | R4DS ch. 18; data quality checklist |
| 17 | Knaflic ch. 2; Wilke, Directory of visualizations |
| 18 | Knaflic ch. 8 |

Other sources: [Wilke, Fundamentals of Data Visualization](https://clauswilke.com/dataviz/), [Healy, Data Visualization](https://socviz.co/), [BBC R cookbook](https://bbc.github.io/rcookbook/).

## Sources

* Wickham, H., Çetinkaya-Rundel, M., & Grolemund, G. *R for Data Science* (2nd ed.). O'Reilly Media.
* Healy, K. *Data Visualization: A Practical Introduction*. Princeton University Press.
* Knaflic, C. N. *Storytelling with Data: A Data Visualization Guide for Business Professionals*. Wiley.
* Wong, D. M. *The Wall Street Journal Guide to Information Graphics: The Dos and Don'ts of Presenting Data, Facts, and Figures*. W. W. Norton & Company.


## Archive

The earlier module-based version is in [`archive/modules`](archive/modules).

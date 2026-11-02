# Data visualization and storytelling (SZF_184)

Rīgas Stradiņa universitāte, autumn 2026. 5 ECTS, 40 contact hours, in-person classes of 90 minutes.
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

## The question decides the chart

| Question | Variables | Preferred chart |
|---|---|---|
| Distribution | 1 continuous | `geom_histogram()` |
| Count | 1 categorical | `geom_bar()` or `geom_col()` |
| Relationship | 2 continuous | `geom_point()` |
| Differences | 1 continuous against 1 categorical | `geom_boxplot()`, `geom_jitter()`, `geom_violin()` |
| Trend | 1 continuous or a count across time | `geom_line()` |

More variables: add color, shape, size or facets (no 3D).

## Schedule

### Classes 1 to 8

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

### Classes 9 and 10: from a question to a graph

Each class starts from a question. The question decides the graph.

| Folder | Question | Data | Files |
|---|---|---|---|
| [`09_split_apply_combine`](classes/09_split_apply_combine) | How do we calculate a number for each group? | Penguins | worksheet, solutions, slides |
| [`10_1_distribution`](classes/10_1_distribution) | How is the data distributed? Histogram | Penguins | worksheet, solutions, slides |
| [`10_2_counts`](classes/10_2_counts) | How many? Pie against bars, order, `geom_col()`, treemap, Likert data | Whickham, NHANES, Latvian companies, world exports, flights, Rosling | students, complete, slides |
| [`10_3_scatter`](classes/10_3_scatter) | Do two numbers go together? Rosling data, Simpson's paradox | Rosling, penguins, NHANES | students, complete, slides |
| [`10_4_differences`](classes/10_4_differences) | How do groups differ? Bars, box plot, violin, jitter | Rosling, penguins, NHANES | self-learning tutorial (the worksheet, solutions and slides in the folder follow the earlier order) |
| [`10_5_trends`](classes/10_5_trends) | How do things change over time? `geom_line()`, groups, `geom_path()` | Gapminder life expectancy 1800 to 2023, Rosling | self-learning tutorial |

The self-learning tutorials have a predict line, an empty chunk and a closed solution box for each step.

### Remaining sessions

| Date | Content |
|---|---|
| Sat 7 Nov, 16:00 to 17:30 | Finish `geom_line()`, animation with `gganimate`, instructions for the graded final project |
| Thu 19 Nov, 13:45 to 15:15 and 15:30 to 17:00 | Work on the final project |
| Fri 20 Nov, 18:00 to 19:30 and 19:45 to 21:15 | Presentations |

Self-study homework replaces the classes on focus and design: colour with viridis, axes, labels and the `scales` package. These tutorials are planned. Their sources are the drafts in [`classes/old_classes`](classes/old_classes) (`11_cut_focus_themes`, `12_tell`, `14_animation_and_questions`). The other drafts in that folder follow the earlier 20-class plan and are not part of the current schedule.

### Final project

- [`capstone/project_template`](capstone/project_template): one RStudio project with the original data, a prompt log, the Quarto file and a one-page story.
- [Rubric](capstone/rubric.md), [data quality checklist](capstone/data_quality_checklist.md), [peer scoring sheet](capstone/peer_scoring_sheet.md) and the older [template](capstone/capstone_template.qmd).
- **Due date:** the zipped project is due on Fri 20 Nov 2026, 23:59.
- **Moodle checkpoint:** Fri 13 Nov 2026, 23:59. Students submit a short script that loads the clean data and runs `glimpse()` and `nrow()`.

## Assessment

| Part | Share of grade | What counts |
|---|---|---|
| Final project (the exam) | 60% | One visualization project that joins analysis, visualization and storytelling, presented in the last sessions. Scored with the [rubric](capstone/rubric.md). |
| Participation | 40% | The deliverable of each class (see the Deliverable section of each class), the individual readings, and the Moodle checkpoint on 13 Nov. |

Projects are individual. Each student works alone. Students may use any dataset and any large language model for the final project. They include the full prompts in the prompt log.

## Coverage of the official theme plan

Class numbers in this table and in the readings table follow the earlier 20-class plan. They will map to the current folders as the classes are rebuilt.

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

Packages load with `pacman::p_load()`. Core set: `tidyverse`, `here`, `janitor`, `gtsummary`. Class packages: `palmerpenguins`, `mosaicData`, `NHANES`, `nycflights13`, `treemapify`, `ggrepel`, `gganimate`, `gifski`.

## Data

- `palmerpenguins`, `NHANES`, `gapminder`: R packages. `band_members` and `band_instruments` (dplyr) and `table2` (tidyr) come with the tidyverse.
- `data/life_expectancy_wide.csv`, `data/income_wide.csv`, `data/population_wide.csv`: Gapminder in wide format, made by `data-raw/make_wide.R`. Students reshape and join them in later classes.
- `data/gapminder_life_expectancy_wide.csv`: life expectancy from the Gapminder Foundation (194 countries, one column per year, 1800 to 2100; years after 2023 are projections). Columns `geo` (ISO3 code) and `name`; no continent. Used in the pivot exercises of class 5, in class 7 and in the trends tutorial (10_5), which joins the continents.
- `data/countries_continents_codes.csv`: 273 rows with ISO codes (`alpha-2`, `alpha-3`), `region` (the continent) and `sub-region`. Join it to the 194-country Gapminder file with `geo` (uppercased) and `alpha-3` to add continents. Some rows have empty codes, so check the join with `anti_join()`.
- `data/lfs_2025_example.csv`, `data/lfs_codebook.md`: 7-row sample of the Latvian Labour Force Survey 2025 (Central Statistical Bureau of Latvia, [data.gov.lv](https://data.gov.lv/dati/lv/dataset/darbspeka-apsekojums)) and an English codebook of the variables used. Replace the sample with the full file under the same name. Used in the dplyr exercise of class 4.
- `data/flights.csv`: all 336,776 flights from New York in 2013 (`nycflights13::flights`, saved with `write_csv()`). Used in class 6. The file is large and the repository does not store it, so students download it separately.
- `data/rosling_tidy.csv`: the three Gapminder tables joined into one (1,704 rows: `country`, `continent`, `year`, `life_exp`, `income`, `population`). Used in classes 10_3 to 10_5.
- `data/companies_lv_smaller_2020_2025.csv`: Latvian companies with a `type` (legal form) and a `place` column. Used in class 10_2.
- `data/world_exports_1998_2000.csv`: export value by country and product. Used in the treemap of class 10_2.

`rosling_tidy.csv` covers 142 countries from 1952 to 2007 in steps of 5 years. It does not include Latvia, Estonia or Lithuania. The long life expectancy file includes all three, from 1800.

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

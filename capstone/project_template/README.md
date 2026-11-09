# Final project

One folder, one RStudio project, one question answered with data and graphs.

## Open and run

1. Open `final_project.Rproj` in RStudio. The project file sets the folder as the root, so `here()` finds every path.
2. Open `final_project.qmd` and click **Render**. The file must render from a clean session.

## What is in this folder

| Item | Content |
|---|---|
| `data/raw/` | The original data file, exactly as downloaded. Never edit it. |
| `data/raw/SOURCE.md` | Where the data come from: source, link, date downloaded, licence. |
| `data/clean/` | Cleaned data saved by your code. |
| `final_project.qmd` | The full history: question, exploration, wrangling, every version of the graph with a log, the refinement and the final graph. |
| `prompt_log.md` | Every AI prompt you used, the answer you used, and what you changed. |
| `story.md` | One page: the question, the answer and the final graph. |
| `post.md` | Optional, +1 point: a social media post with the question, the data and the graph. |
| `figures/` | `graph_v1.png`, `graph_v2.png`, `final_graph.png` and `colour_blind_check.png`. |

## Hand in

Zip the whole folder, without the `.Rproj.user` folder, and name it `Surname_Name.zip`. Include the rendered `final_project.html`. Upload the zip by Fri 20 Nov, 23:59.

## Present

Present one graph in 3 minutes, live on Fri 20 Nov. If you cannot attend, send a video by Fri 20 Nov, 18:00. The video shows your screen and your face together.

## Checklist before you hand in

- [ ] The question names a group, a measure and a period, and the data can answer it.
- [ ] The dataset comes from outside the class, has at least 100 rows and 4 variables, and has no personal data.
- [ ] The original data sit in `data/raw/` and `SOURCE.md` has the link, the licence and the download date.
- [ ] The exploration checks the dimensions, the variable types and the missing values, with one sentence for each result.
- [ ] The wrangling has at least 2 tidyverse steps, each with a comment that says why, and the clean data are saved.
- [ ] The graph has at least 2 saved versions, one with a problem, and each version has a line in the log.
- [ ] The final graph has a title that states the finding, axis labels with units, one annotation, a theme and a palette.
- [ ] The palette is colour blind safe and `figures/colour_blind_check.png` shows the simulator result.
- [ ] `final_project.qmd` renders from a clean session (Session > Restart R, then Render).
- [ ] Each function in your code has a comment that says why you use it.
- [ ] `prompt_log.md` lists every prompt, and one entry describes an AI mistake you fixed.
- [ ] `story.md` fits on one page.
- [ ] You can explain every line of your code.

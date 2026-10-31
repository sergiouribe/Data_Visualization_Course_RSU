# Final project

One folder, one RStudio project, one question answered with data and graphs.

## Open and run

1. Open `final_project.Rproj` in RStudio. The project file sets the folder as the root, so `here()` finds every path.
2. Open `final_project.qmd` and click **Render**. The file must render from a clean session.

## What is in this folder

| Item | Content |
|---|---|
| `data/raw/` | The original data file, exactly as downloaded. Never edit it. |
| `data/raw/SOURCE.md` | Where the data come from: link, date downloaded, licence. |
| `data/clean/` | Optional. Cleaned data saved by your code. |
| `final_project.qmd` | The full analysis: question, exploration, wrangling, graphs, limits. |
| `prompt_log.md` | Every AI prompt you used, the answer you used, and what you changed. |
| `story.md` | One page: the question, the answer and the final graph. |
| `figures/` | The final graph saved as an image (done by the code). |

## Hand in

Zip the whole folder, without the `.Rproj.user` folder, and upload the zip. Include the rendered `final_project.html`.

## Checklist before you hand in

- [ ] The question names a group, a measure and a period, and the data can answer it.
- [ ] The original data sit in `data/raw/` and `SOURCE.md` has the link and the licence.
- [ ] `final_project.qmd` renders from a clean session (Session > Restart R, then Render).
- [ ] Each function in your code has a comment that says why you use it.
- [ ] At least 4 graphs, each matched to a question type from the course.
- [ ] One graph is refined: title that states the finding, labels, order, one highlight color.
- [ ] `prompt_log.md` lists every prompt, and one entry describes an AI mistake you fixed.
- [ ] `story.md` fits on one page.
- [ ] You can explain every line of your code in the 5-minute defence.

## The 5-minute defence

1. The teacher points to one chunk. You explain each line.
2. The teacher asks for one change, such as a new order or a facet. You have 2 minutes.
3. You answer: why this graph type for this question?

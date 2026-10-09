# RStudio basics for the first day

Mac users: replace **Ctrl** with **Cmd** and **Alt** with **Option**.

## 1. Projects: always work inside one

A **project** is a folder with a file ending in `.Rproj`. When you open the project, RStudio sets the working folder to that folder. Then `here()` finds your data and saves your files in the right place.

| Task | How |
|---|---|
| Open the course project | Double-click `data_visualization_course.Rproj`, or **File > Open Project** |
| Check that a project is open | The project name shows at the top right of RStudio. `Project: (None)` means no project is open |
| Switch or close a project | Click the project name at the top right, then choose **Close Project** or another project |
| Open a recent project | **File > Recent Projects** |
| Start a new project for your own work | **File > New Project > New Directory > New Project**. Name the folder and choose where it lives |
| Get the course repo | **File > New Project > Version Control > Git**, paste the repo URL. Or download the ZIP, unzip it, and open the `.Rproj` |
| Find where R is working | Run `here()` in the console |

Rules:
1. Open the project first, then open files.
2. Never double-click a `.qmd` file alone. R then works in the wrong folder and cannot find `data/`.
3. Use `here("data", "file.csv")` for paths. Never type `C:\Users\...`.
4. One project per course or study. Keep data, code and output in the same folder.

## 2. Settings to change once

**Tools > Global Options**

| Where | Setting |
|---|---|
| General | "Restore .RData into workspace at startup": **off**. "Save workspace to .RData on exit": **Never** |
| Code | "Use native pipe operator": **on**. Then Ctrl + Shift + M types `\|>` |

## 3. Install the packages

Run once, in the console:
```r
install.packages("pacman")
pacman::p_load(tidyverse, here, janitor, gtsummary, palmerpenguins,
               gapminder, NHANES, ggrepel, knitr, rmarkdown)
```
`p_load()` installs a package if it is missing and loads it. It takes several minutes the first time.

## 4. The four panes

| Pane | Where | What it does |
|---|---|---|
| Source | top left | Where you write: `.qmd` and `.R` files |
| Console | bottom left | Where R runs. You can type here, but code you want to keep goes in the Source pane |
| Environment | top right | Objects R holds in memory |
| Files, Plots, Help | bottom right | Project files, your graphs, help pages |

## 5. Five words

| Word | Meaning |
|---|---|
| Project | A folder with a `.Rproj` file. Always open the project first |
| Package | A set of tools you load with `pacman::p_load()` |
| Chunk | A block of code in a `.qmd` file, between ` ```{r} ` and ` ``` ` |
| Console | The place where R answers |
| Pipe `\|>` | "Then". Sends the result on the left into the function on the right |

## 6. Writing in a .qmd file

| Part | How to write it |
|---|---|
| Text | Type normally. `# Title`, `## Section`, `**bold**` |
| Code | Inside a chunk. Insert one with Ctrl + Alt + I |
| Comment | Start a line with `#` inside a chunk. R skips it. Write why, not what |

The top right of the editor has two modes: **Source** (you see the symbols) and **Visual** (like a word processor). Use Source in this course.

## 7. Shortcuts to learn today

| Action | Shortcut |
|---|---|
| Run the current line or selection | Ctrl + Enter |
| Run the whole chunk | Ctrl + Shift + Enter |
| Insert a new chunk | Ctrl + Alt + I |
| Type the pipe `\|>` | Ctrl + Shift + M |
| Save the file | Ctrl + S |
| Undo | Ctrl + Z |
| Clear the console | Ctrl + L |
| Restart R (when things look strange) | Ctrl + Shift + F10 |
| Render the report | Ctrl + Shift + K |

## 8. Autocomplete and help

| Tool | How |
|---|---|
| Autocomplete | Type the first letters of a function or column name. A list appears. Press **Tab** or **Enter** to accept |
| Force the list | Ctrl + Space |
| Argument hints | Place the cursor inside the brackets and press **Tab**. RStudio lists the arguments |
| Help page | Put the cursor on a function name and press **F1**, or run `?ggplot` |
| Quotes and brackets | RStudio closes them for you. Type over the closing one |

## 9. Reading an error

1. Do not panic. Errors are normal, and every programmer sees them all day.
2. Read the last line of the red text. It names the problem.
3. Check the usual causes:

| Message | Usual cause |
|---|---|
| `could not find function "ggplot"` | The package is not loaded. Run the `p_load` chunk |
| `object 'xyz' not found` | A typo, or the line that creates it did not run |
| `unexpected symbol` or `unexpected ')'` | A missing comma, a missing or extra bracket, or an open quote |
| `Can't add ... to a ggplot object` | A `+` is missing at the end of the previous line |
| `there is no package called ...` | Run `install.packages("pacman")`, then the `p_load` chunk again |

Rule: every line of a ggplot ends with `+`, except the last.

## 10. Export a copy of your code and output

| Route | Steps | Notes |
|---|---|---|
| HTML, then PDF (use this one) | Click **Render**. Open the HTML file in your browser, press Ctrl + P, choose **Save as PDF** | Works on every computer |
| PDF from Quarto | Change `format: html` to `format: pdf`, then Render | Needs LaTeX. Run `quarto install tinytex` in the Terminal tab first. It can fail |
| PDF with Typst | Change to `format: typst`, then Render | Needs Quarto 1.4 or newer. Check with `quarto --version` in the Terminal tab |

## 11. If the installation fails

1. Sit next to a neighbor and watch their screen today.
2. Ask the teacher before you leave. Fix it with a short call.
3. Fallback: a free [Posit Cloud](https://posit.cloud/) account runs RStudio in a browser. Check that your account works before the next class.

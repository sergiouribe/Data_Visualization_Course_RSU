# RStudio basics for the first day

Mac users: replace **Ctrl** with **Cmd** and **Alt** with **Option**.

## The four panes

| Pane | Where | What it does |
|---|---|---|
| Source | top left | Where you write: `.qmd` and `.R` files |
| Console | bottom left | Where R runs. You can type here, but code you want to keep goes in the Source pane |
| Environment | top right | Objects R holds in memory |
| Files, Plots, Help | bottom right | Project files, your graphs, help pages |

## Five words

| Word | Meaning |
|---|---|
| Project | A folder with a `.Rproj` file. Always open the project first |
| Package | A set of tools you load with `pacman::p_load()` |
| Chunk | A block of code in a `.qmd` file, between ` ```{r} ` and ` ``` ` |
| Console | The place where R answers |
| Pipe `\|>` | "Then". Sends the result on the left into the function on the right |

## Shortcuts to learn today

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

One setting to change once: **Tools > Global Options > Code > Use native pipe operator** (tick it). Then Ctrl + Shift + M types `|>`.

## Reading an error

1. Do not panic. Errors are normal, and every programmer sees them all day.
2. Read the last line of the red text. It names the problem.
3. Check the usual causes:

| Message | Usual cause |
|---|---|
| `could not find function "ggplot"` | The package is not loaded. Run the `p_load` chunk |
| `object 'xyz' not found` | A typo, or the line that creates it did not run |
| `unexpected symbol` or `unexpected ')'` | A missing comma, a missing or extra bracket, or an open quote |
| `Can't add ... to a ggplot object` | A `+` is missing at the end of the previous line |
| `there is no package called ...` | Run `install.packages("pacman")`, then run the chunk again |

Rule: every line of a ggplot ends with `+`, except the last.

## If the installation fails

1. Sit next to a neighbor and watch their screen today.
2. Ask the teacher before you leave. Fix it with a short call.
3. Fallback: a free [Posit Cloud](https://posit.cloud/) account runs RStudio in a browser. Check that your account works before the next class.

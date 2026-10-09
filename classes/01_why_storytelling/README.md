# Class 01. Why storytelling matters

**When:** Sat 10 Oct 2026, 13:45-15:15 (in person, 90 min)  
**Data:** Examples built from Gapminder and penguins

**Goal:** Students know what the course delivers, see eight mistakes, and learn the five principles. Class 1 has no coding. Class 2 starts with setup and the first graph.

## Files

- [01_bad_graphs.qmd](01_bad_graphs.qmd): teacher file with eight graphs, the mistake in each, and the fix.
- [worksheet_bad_graphs.md](worksheet_bad_graphs.md): student worksheet (print one per student).

## Plan

| Minutes | Activity |
|---|---|
| 0-10 | Who I am: slides, map, some of my visualizations. Each student says name, background, and one graph they saw this week. |
| 10-20 | The course on one slide: aim, what we do, what I expect, how you are evaluated, what you have at the end. |
| 20-25 | Tolstoy slide: all good charts look alike, every bad chart is bad in its own way. |
| 25-50 | Part A, design mistakes (graphs 1 to 4 in `01_bad_graphs.qmd`). For each: show for 60 seconds, students write on the worksheet, 2 minutes of discussion, then reveal. |
| 50-55 | Break for stretching. |
| 55-70 | Part B, data errors behind the graph (graphs 5 to 8). Message: a clean-looking graph can hide a wrong table. Link forward: class 3 (missing values), class 6 (percentages), class 9 (joins). |
| 70-80 | The five principles, one slide each: Ask, Show, Cut, Focus, Tell. Map each bad graph to a principle. |
| 80-90 | The end goal: play 60 seconds of Rosling's video. Hand out the worksheet to finish at home. Remind students of what to bring to class 2: laptop with R and RStudio. |

## Notes for the teacher

- **No coding today.** Students look, talk and write. The first lines of code come in class 2.
- **Class 2 starts 15 minutes after this class ends.** Use the break to help with installs.
- **Graph 4:** Latvia is not in Gapminder, so the highlight is empty. Use it as a live example of a silent error. Then change to `"Poland"`.
- **Graph 3:** change `+ 30` to `+ 10` live to show that the author controls the story.
- **Bring your own examples:** replace or add one real graph from a news site or a paper that the students may know. The eight examples here are built from open data so that you can show and fix them in the same file.

## Tell the students

We write reports in Quarto (`.qmd`). Quarto is the successor to R Markdown, uses the same chunks, and renders to HTML, PDF and Word. Class 14 teaches rendering.

## Reading

Individual work (about 30 minutes). Read it before the class if possible:

- Knaflic, *Storytelling with Data*, chapter 1, The importance of context.
- Optional: Healy, [*Data Visualization*](https://socviz.co/), chapter Look at data.

## Deliverable

The completed worksheet (eight rows), finished at home if needed.

## Sources

Knaflic, *Storytelling with Data* (chapter 1, context). Healy, *Data Visualization* (chapter 1, why look at data). Wong, *The Wall Street Journal Guide to Information Graphics* (rules on bars and pies).

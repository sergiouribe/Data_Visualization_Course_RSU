# ============================================================================
# Module 10: Latvian data - Household Budget Survey 2019
#
# STATUS: audit template only. The CSVs have NOT been inspected, so file
# layout, units and join keys are unknown. Do not write analysis code until
# the checks below pass on your copy of the data.
# ============================================================================

library(tidyverse)
library(here)

hh_inv <- here("data", "latvia", "PUF_MBA2019_hh_inv.csv") |>
  read_csv(show_col_types = FALSE)

hh_exp <- here("data", "latvia", "PUF_MBA2019_hh_exp.csv") |>
  read_csv(show_col_types = FALSE)

# 1. Structure of each file
hh_inv |> glimpse()
hh_exp |> glimpse()

# 2. Is household + person unique in the characteristics file?
#    (Column names are from the codebook; confirm them first.)
hh_inv |>
  count(ms_id_n, Pers_nr) |>
  filter(n > 1)

# 3. Are household-level variables constant within a household?
hh_inv |>
  group_by(ms_id_n) |>
  summarise(
    n_laupil = n_distinct(laupil),
    n_teritor = n_distinct(Teritor),
    .groups = "drop"
  ) |>
  filter(n_laupil > 1 | n_teritor > 1)

# 4. How many rows per household in each file?
hh_inv |> count(ms_id_n) |> count(n, name = "n_households")
hh_exp |> count(ms_id_n) |> count(n, name = "n_households")

# 5. Which key relationship joins the files? Decide from steps 2-4.
#    Only then write the join, for example:
# hh_one_row <- hh_inv |> distinct(ms_id_n, laupil, Teritor, kvpc.i, svars)
# hh_one_row |> left_join(hh_exp, by = "ms_id_n", relationship = "one-to-one")

# 6. Find where the health and dental codes (HE0622 etc.) appear: as column
#    names or as values? Check before using them.
# names(hh_exp) |> str_subset("HE06")

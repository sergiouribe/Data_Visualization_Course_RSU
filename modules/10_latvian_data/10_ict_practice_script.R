# ============================================================================
# Module 10: Latvian data - ICT survey (individuals), 2025
#
# STATUS: proposed code, NOT run in this repository. The data file is not
# stored here. Check every step on your own copy of the data.
# ============================================================================

library(tidyverse)
library(here)

# ----------------------------------------------------------------------------
# 1. Import
# ----------------------------------------------------------------------------

ict <- here("data", "latvia", "ikt_puf_2025.csv") |>
  read_csv(show_col_types = FALSE)

# ----------------------------------------------------------------------------
# 2. Audit before analysing
# ----------------------------------------------------------------------------

ict |> dim()

# Is IND_ID unique? (An earlier inspection found fewer distinct IDs than rows.)
ict |>
  summarise(
    n_rows = n(),
    n_distinct_id = n_distinct(IND_ID)
  )

# Do NOT drop repeated IDs. Describe results as "source records".

# Category counts
ict |> count(AGE)
ict |> count(B1)
ict |> count(B5, useNA = "ifany")

# Missing values per column, highest first
ict |>
  summarise(across(everything(), ~ sum(is.na(.x)))) |>
  pivot_longer(everything(), names_to = "variable", values_to = "n_missing") |>
  arrange(desc(n_missing)) |>
  print(n = 20)

# ----------------------------------------------------------------------------
# 3. Structural missingness: check the routing
# ----------------------------------------------------------------------------

# Are device columns populated only for recent internet users?
ict |>
  mutate(recent_user = B1 == 1) |>
  group_by(recent_user) |>
  summarise(across(matches("^B3_[1-5]$"), ~ sum(!is.na(.x))))

# Do not replace NA with 0 across the board.

# ----------------------------------------------------------------------------
# 4. Devices by age group
# ----------------------------------------------------------------------------

device_labels <- tibble(
  device_code = paste0("B3_", 1:5),
  device = c("Desktop", "Laptop", "Tablet", "Smartphone", "Other device")
)

devices_long <- ict |>
  mutate(
    record_id = row_number(), # identifies source rows only, not respondents
    age_group = factor(
      AGE,
      levels = 1:6,
      labels = c("16-24", "25-34", "35-44", "45-54", "55-64", "65-74"),
      ordered = TRUE
    )
  ) |>
  filter(B1 == 1) |>
  pivot_longer(
    cols = matches("^B3_[1-5]$"),
    names_to = "device_code",
    values_to = "selected"
  ) |>
  left_join(device_labels, by = "device_code")

device_summary <- devices_long |>
  filter(selected %in% c(0, 1)) |> # keep zeros and ones
  group_by(age_group, device) |>
  summarise(
    n_valid = n(),
    n_selected = sum(selected == 1),
    proportion = mean(selected),
    .groups = "drop"
  )

device_summary

# Faceted dot plot
device_summary |>
  ggplot(aes(x = proportion, y = age_group)) +
  geom_point(size = 3, color = "steelblue") +
  facet_wrap(~device) +
  scale_x_continuous(labels = scales::percent) +
  labs(
    title = "Device use by age group, recent internet users",
    subtitle = "Share of source records using each device (multiple answers allowed)",
    x = NULL, y = NULL,
    caption = "Source: CSP ICT survey 2025, unweighted"
  ) +
  theme_minimal()

# Heatmap
device_summary |>
  ggplot(aes(x = device, y = age_group, fill = proportion)) +
  geom_tile(color = "white") +
  geom_text(aes(label = scales::percent(proportion, accuracy = 1)), size = 3) +
  scale_fill_viridis_c(labels = scales::percent) +
  labs(
    title = "Device use by age group",
    x = NULL, y = NULL, fill = "Share",
    caption = "Source: CSP ICT survey 2025, unweighted"
  ) +
  theme_minimal() +
  theme(panel.grid = element_blank())

# ----------------------------------------------------------------------------
# 5. Internet activities (B4_1 to B4_12)
# ----------------------------------------------------------------------------

# Why this regex? starts_with("B4_") would also select B4_A_* and B4_B.
ict |>
  select(matches("^B4_[0-9]+$")) |>
  names()

# Your turn: repeat section 4 for these 12 columns. You need a lookup table
# of activity labels from the English part of the codebook (page 22 onwards).

# ----------------------------------------------------------------------------
# 6. Conditional denominators
# ----------------------------------------------------------------------------

# Health-information seeking among recent internet users
ict |>
  filter(B1 == 1, B4_6 %in% c(0, 1)) |>
  summarise(n = n(), share_health = mean(B4_6))

# Follow-up topics: denominator is people who sought health information
ict |>
  filter(B4_6 == 1) |>
  summarise(across(matches("^B4_A_[1-3]$"), ~ sum(.x == 1, na.rm = TRUE)))

# AI use (B5: 1 = yes, 2 = no). Missing values are excluded here; say so.
ict |>
  filter(B5 %in% c(1, 2)) |>
  summarise(n = n(), share_ai = mean(B5 == 1))

# ----------------------------------------------------------------------------
# 7. Weighted vs unweighted (descriptive only)
# ----------------------------------------------------------------------------

# Weighted figures are descriptive. They are not survey-design estimates and
# give no valid confidence intervals.
devices_long |>
  filter(selected %in% c(0, 1), !is.na(SVARS_PERS)) |>
  group_by(device) |>
  summarise(
    unweighted = mean(selected),
    weighted = weighted.mean(selected, w = SVARS_PERS),
    .groups = "drop"
  )

# ============================================================================
# EXERCISES
# ============================================================================

# 1. Write one sentence on what the IND_ID check means for how you can
#    describe the results.
# 2. Repeat sections 4 and 5 by urban/rural (PILS_LAUKI: 1 = urban, 2 = rural).
# 3. Show how many records have B6_1 filled, and explain the denominator.
# 4. Choose one finding. Build a chart that highlights it (Module 05), with the
#    denominator stated in the subtitle.

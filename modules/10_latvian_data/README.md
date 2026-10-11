# Module 10: Latvian Data Exercises

Practice exercises using official Latvian survey microdata. They fit after Module 03 (wrangling) and can be reused in Modules 04-08.

See `data/latvia/README.md` for download links and file names.

## How to read this module

Each statement is labelled:

- **Verified**: checked on the actual file in an earlier session.
- **From codebook**: taken from the variable dictionary, not checked on the data.
- **Proposed / untested**: a teaching idea or code that has not been run on the real data.

Students should learn the same habit: never assume identifiers, units, missing-value meanings or join keys without checking.

---

## Dataset 1: ICT survey, individuals, 2025

### Verified

- 5,237 rows, 164 columns; `REFYEAR` is 2025 in all rows.
- `IND_ID` has only 3,303 distinct values, although the codebook calls it a unique respondent ID. This is **unresolved**. Do not assume repeated IDs are duplicates and do not remove them. Describe results as summaries of *source records*, not unique individuals.
- `B1 == 1` (internet used in the last three months): 4,913 records. Device columns (`B3_1`-`B3_5`) are populated for those records.
- `B5` (AI content-creation use): 1,563 yes, 3,350 no, 324 missing. `B6_1` is populated for the 1,563 AI users.
- `B4_6` (health-information seeking): 2,364 ones and 2,873 zeros. It is zero for people without recent internet use, whereas the follow-ups `B4_A_*` are missing for those not seeking health information.
- Documentation discrepancies: `A1` uses code 9 for don't know/refusal in the Latvian dictionary and 3 in the English one (the CSV has 9); `D2` wording and reference period differ between languages; the household-children age threshold differs between languages.

### From codebook

| Variable | Meaning |
|----------|---------|
| `AGE` | 1-6 = 16-24, 25-34, 35-44, 45-54, 55-64, 65-74 |
| `SEX` | 1 = male, 2 = female |
| `PILS_LAUKI` | 1 = urban, 2 = rural |
| `KVARTILE` | household income quartile |
| `B3_1`-`B3_5` | desktop, laptop, tablet, smartphone, other device |
| `B4_1`-`B4_12` | internet activities (multiple response) |
| `SVARS_PERS`, `SVARS_MS` | person and household weights |

Multiple-response questions are separate indicator columns, often 0/1. Single yes/no questions commonly use 1/2.

### Concepts this dataset teaches

1. **Structural missingness.** Missing values come from questionnaire routing. Do not replace all `NA` with 0.
2. **Conditional denominators.** The share using a device is computed among recent internet users, not all records.
3. **Multiple-response percentages** need not sum to 100%.
4. **Selecting columns with regex.** `matches("^B4_[0-9]+$")` selects the 12 activities. `starts_with("B4_")` would also pick up the follow-ups `B4_A_*` and `B4_B`.
5. **Weighted vs unweighted summaries.** `weighted.mean()` gives a weighted descriptive figure only. It is not a survey-design analysis and gives no valid confidence intervals. Population claims need the survey methodology to be resolved first.

### Exercises

All are **proposed / untested**. See `10_ict_practice_script.R`.

1. **Audit.** Rows, distinct `IND_ID`, counts per category, missing values per column.
2. **Devices by age.** Filter to `B1 == 1`, pivot `B3_1`-`B3_5` to long format, join device labels, compute the proportion per age group and device.
3. **Visualise it two ways.** Faceted dot plot and age-by-device heatmap. Which makes the age pattern easier to see?
4. **Internet activities.** Repeat for the 12 `B4_*` columns.
5. **Conditional denominators.** Health-information seeking (`B4_6`) and its follow-ups; AI use (`B5`) and its purposes (`B6_*`).
6. **Weighted vs unweighted.** Compare both and discuss what can and cannot be concluded.
7. **Storytelling (Modules 05-06).** Pick one finding, highlight it, annotate it, and state the denominator in the subtitle.

---

## Dataset 2: Household Budget Survey, 2019

### Status

Only the variable-description document has been read. **The CSVs have not been inspected**, so row structure, units, reference periods and join keys are unverified. Exercises below are placeholders until the files are checked.

### From codebook

- `PUF_MBA2019_hh_inv.csv`: household and household-member characteristics.
- `PUF_MBA2019_hh_exp.csv`: consumption expenditure by ECOICOP/HBS category.
- Candidate keys: `ms_id_n` (household), `Pers_nr` (person in household).
- `laupil`: 1 = urban, 2 = rural. `Teritor`: six regions. `kvpc.i`: income quintile. `svars`: household weight.
- `xD1_1`-`xD1_20`: dwelling amenities, 1 = yes, 2 = no.
- Health-related expenditure codes: HE0611, HE0612, HE0613, HE0621, HE0622 (dental services), HE0623, HE0630, HE1253. These are classification codes, not confirmed column names.

### Check before any analysis

Students should answer each of these from the data:

1. Is `ms_id_n` + `Pers_nr` unique in the characteristics file?
2. Are household-level variables constant within each household?
3. How are expenditure categories stored (columns or rows)? What are the units and reference period?
4. How do cash expenditure (A) and in-kind expenditure (B) appear?
5. Does `ms_id_n` join the two files one-to-one, one-to-many or many-to-many? Check with `count()` before joining.

### Proposed exercises (after the checks)

- Amenities by urban/rural and by income quintile (wide to long, lookup join).
- Household vs per-capita expenditure.
- Recorded dental expenditure by income quintile. Recorded spending is not dental need, access, visits or total treatment cost.

---

## Limits when comparing the two surveys

- Different years: 2025 vs 2019.
- Different regions: five statistical regions vs six (including Pieriga).
- Different income groups: quartiles vs quintiles.
- They are separate samples. Matching demographic categories does not link respondents.

Do not merge them.

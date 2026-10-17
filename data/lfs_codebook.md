# Latvian Labour Force Survey 2025: codebook for the variables used in class

Source: Central Statistical Bureau of Latvia (CSP), Labour Force Survey public use file, [data.gov.lv](https://data.gov.lv/dati/lv/dataset/darbspeka-apsekojums). Variable descriptions are translated from the official codebook `dsp_puf_apraksts_2025_lv_en.pdf` (pages 1 to 8). Use the official file for all other variables.

`data/lfs_2025_example.csv` has 7 rows. Replace it with the full file before class and keep the same column names.

Blank cell = not applicable (skip logic). Code `9` or `99` = no answer.

| Column | Meaning | Codes | Applies to |
|---|---|---|---|
| `NR` | Person ID | number | all |
| `Gads` | Year | 2025 | all |
| `Ceturksnis` | Quarter | 1 to 4 | all |
| `Vecums` | Age group | 1 = 0-14, 2 = 15-24, 3 = 25-34, 4 = 35-44, 5 = 45-54, 6 = 55-64, 7 = 65-74, 8 = 75 and older | all |
| `B11` | Sex | 1 = male, 2 = female | all |
| `Jreg5` | Region of residence | 1 = Riga, 2 = Vidzeme, 3 = Kurzeme, 4 = Zemgale, 5 = Latgale | all |
| `Pil_lauk` | Urban or rural | 1 = city, 2 = rural | all |
| `MS_1` | Household size | 1 to 5 (5 = five or more) | all |
| `MS_2` | Children aged 0 to 17 in household | 1 = none, 2 = one, 3 = two or more | all |
| `Svars_Cet` | Quarterly weight | number | all |
| `Svars_G` | Annual weight | number | all |
| `L124` | Highest education | 1 = higher, 2 = vocational or general secondary vocational, 3 = general secondary, 4 = basic or lower, 9 = no answer | age 15 to 74 |
| `EKA` | Economic activity | 1 = employed, 2 = unemployed, 3 = economically inactive | age 15 to 74 |
| `D49` | Employment status, main job | 1 = employee, 2 = self-employed | `EKA = 1` |
| `D47` | Sector of main job | 1 = agriculture, forestry, fishing; 2 = industry and energy; 3 = construction; 4 = trade, accommodation, food service; 5 = transport, information, communication; 6 = finance, professional, administrative; 7 = public administration, defence; 8 = education; 9 = health and social care; 10 = other; 99 = no answer | `EKA = 1` |
| `D48` | Occupation, main job | 1 = managers, 2 = professionals, 3 = technicians and associate professionals, 4 = clerks, 5 = service and sales, 6 = skilled agricultural workers, 7 = craft workers, 8 = machine operators, 9 = elementary occupations, 99 = no answer | `EKA = 1` |
| `Stundas` | Hours worked last week, main job | 1 = 0, 2 = 1 to 39, 3 = 40, 4 = 41 or more, 9 = no answer | `EKA = 1` |
| `D55` | Full or part time | 1 = full time, 2 = part time, 9 = no answer | `EKA = 1` |
| `D56` | Reason for part time | 1 = study or training, 2 = own illness or disability, 3 = could not find full-time work, 4 = did not want full-time work, 5 = part time set by the employer, 6 = other reason, 9 = no answer | `D55 = 2` |
| `J114_1` to `J114_14` (no `_6`) | Method used to look for a job, one Yes/No column per method (13 columns). 1 = friends and relatives, 2 = read job ads, 3 = contacted employers, 4 = State Employment Agency, 5 = placed or answered ads, 7 = interview or test, 8 = private agency, 9 = looked for land or premises to start a business, 10 = looked for permits or finance to start a business, 11 = waiting for application result, 12 = waiting for employer reply, 13 = waiting for Employment Agency reply, 14 = other method | 1 = yes, 2 = no | `EKA = 2` and looked for work in the last 4 weeks |

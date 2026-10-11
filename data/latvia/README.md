# Latvian datasets

Raw files are not stored in this repository. Download them and place them in this folder (`data/latvia/`). Scripts load them with `here::here("data", "latvia", ...)`.

## Sources

| Dataset | Where to get it |
|---------|-----------------|
| ICT survey, individuals (teaching microdata, 2025) | https://data.gov.lv/dati/lv/dataset/apsekojuma-informacijas-un-komunikacijas-tehnologiju-ikt-personas-iindividualie-dati-macibam |
| Household Budget Survey (2019) | https://data.gov.lv/dati/lv/dataset/majsaimniecibu-budzets |
| Official statistics database (CSP) | https://data.stat.gov.lv/pxweb/en/ |
| National open-data portal | https://data.gov.lv/eng |
| Health statistics (SPKC) | https://statistika.spkc.gov.lv/pxweb/en/Health/ |
| CSP research and teaching datasets | https://stat.gov.lv/en/research |
| Geospatial open data (LGIA) | https://www.lgia.gov.lv/en/atvertie-dati |

## Expected file names

- `ikt_puf_2025.csv` and the variable dictionary `ikt-personas-puf-2025-apraksts-lveng.pdf` (English section starts on page 22)
- `PUF_MBA2019_hh_inv.csv`, `PUF_MBA2019_hh_exp.csv` and `mba_puf_variable-description_2019_en.docx`

## Verification status

| Item | Status |
|------|--------|
| ICT CSV structure (5,237 rows, 164 columns, REFYEAR = 2025) | Inspected in an earlier session |
| Household Budget CSVs | **Not yet inspected.** Only the variable description has been read |

# London Housing Market Analysis (2016 to 2026) in Excel

Analysis of residential property sales in London using HM Land Registry Price Paid Data.
Built in Excel only: Power Query for ETL, Data Model (Power Pivot) with DAX measures, modern formulas (XLOOKUP, LET, LAMBDA, dynamic arrays), what-if analysis and an interactive dashboard.

> Status: **in progress** (Day 1 of 10). See the [progress log](#progress-log) below.

---

## Business context

I set this project up as if I were a commercial analyst at a mid-size London estate agency (fictional).
The agency plans to open new branches in 2027 and wants to know which boroughs to focus on.

The Head of Strategy asked me to answer:

1. How did London prices and sales volumes change from 2016 to 2026, and how did big events (Brexit vote, stamp duty holiday, 2022 mortgage rate jump) show up in the data?
2. Which boroughs grew the most and which fell behind?
3. Are flats and houses moving in different directions?
4. How big is the new-build premium, and where is it highest?
5. Is there seasonality in sales volume that should affect staffing and marketing?
6. How affordable is each borough for a buyer on a typical local salary?

Full framing, KPIs and scope: [docs/01_business_framing.md](docs/01_business_framing.md)

## Data

| | |
|---|---|
| Source | [HM Land Registry Price Paid Data](https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads) (yearly files) |
| Coverage | Residential sales in England and Wales, filtered to Greater London |
| Period | Jan 2016 to Jul 2026 (see decision D-03 for why not Sep 2026) |
| Granularity | One row per sale |
| Extra data (Day 7) | ONS earnings by borough, for affordability |

Column definitions: [docs/data_dictionary.md](docs/data_dictionary.md)
How to download the raw files: [data/README.md](data/README.md)

Raw files are **not** stored in this repo (over 1 GB in total).

## Tools

- Excel 2024 (desktop, Windows)
- Power Query (M)
- Data Model / Power Pivot (DAX)
- Excel formulas: XLOOKUP, LET, LAMBDA, FILTER, SORTBY, UNIQUE
- What-if analysis: Data Tables, Scenario Manager, PMT

## Repository structure

```
london-housing-excel-analysis/
├── README.md
├── data/
│   └── README.md            how to get the raw data (raw files are git-ignored)
├── docs/
│   ├── 01_business_framing.md
│   ├── data_dictionary.md
│   └── decision_log.md      every cleaning / modelling decision and why
├── powerquery/              M code for every query, as plain text
├── dax/                     DAX measures, as plain text
├── excel/                   the workbook
└── images/                  screenshots used in this README
```

M code and DAX are saved as text files because GitHub can't preview `.xlsx`. This way the logic can be reviewed without opening Excel.

## Progress log

| Day | Stage | Status |
|---|---|---|
| 1 | Business framing, data dictionary, repo setup | done |
| 2 | Power Query: load and combine yearly files, filter London | |
| 3 | Power Query: cleaning, data quality log | |
| 4 | Dimension tables and data model (star schema) | |
| 5 | DAX measures | |
| 6 | Formula-based analysis (dynamic arrays, LAMBDA) | |
| 7 | Affordability analysis and mortgage what-if | |
| 8 | Pivot analysis and charts | |
| 9 | Dashboard | |
| 10 | Insights, recommendations, final write-up | |

## Key findings

To be added after the analysis (Day 10).

---

## Licence and attribution

Contains HM Land Registry data © Crown copyright and database right 2026. This data is licensed under the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).

This project only publishes aggregated results. No address-level records are shared.

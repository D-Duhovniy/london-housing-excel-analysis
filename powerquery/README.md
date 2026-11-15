# Power Query

Every query in the workbook is saved here as a `.m` file, so the logic can be reviewed on GitHub without opening Excel.
The files are copies: the source of truth is the workbook. When a query changes in Excel, the `.m` file is updated in the same commit.

## Query flow

```
Settings (named cells)
  p_RawFolder   p_StartDate   p_EndDate   p_MinPrice
       │             │            │            │
       ▼             └────────────┼────────────┘
  stg_sales ◄── fx_LoadPricePaidFile          │
       │                                      │
       ▼                                      │
  int_sales_flagged ◄─────────────────────────┘
       │            (one dq_reason per row)
       ├──────────────────┐
       ▼                  ▼
  fact_sales         chk_monthly ──► Checks sheet
  (included rows)    (counts by month and dq_reason)
```

## Queries

| Query | Type | What it does | Load to |
|---|---|---|---|
| `p_RawFolder` | Parameter | Raw data folder path | Connection only |
| `p_StartDate`, `p_EndDate` | Parameter | Analysis period | Connection only |
| `p_MinPrice` | Parameter | Minimum plausible market price | Connection only |
| `fx_LoadPricePaidFile` | Function | Reads one CSV, names the columns, keeps London rows and the needed columns | Connection only |
| `stg_sales` | Staging | Combines all yearly files, sets data types | Connection only |
| `int_sales_flagged` | Intermediate | Adds `dq_reason` to every row: why it is excluded, or "Included" | Connection only |
| `fact_sales` | Fact | Included rows only, postcode district, unused columns removed | Connection only (Data Model from Day 4) |
| `chk_monthly` | Check | Row counts by month, category, record status and dq reason | Table on `Checks` sheet |

## Flag first, filter after

Cleaning rules are not applied as separate filters one after another.
Instead, `int_sales_flagged` gives every row one reason, and `fact_sales` keeps only "Included".

This way the number of rows removed by each rule is visible in `chk_monthly`, and the data quality log is built from it without reading the files again.

## Naming

| Prefix | Meaning |
|---|---|
| `p_` | Parameter |
| `fx_` | Custom function |
| `stg_` | Staging: data loaded and typed, no business rules yet |
| `int_` | Intermediate: business rules applied as flags |
| `fact_`, `dim_` | Final tables for the Data Model (from Day 3/4) |
| `chk_` | Data checks |

## Why a custom function instead of the "Combine Files" button

The built-in **Combine Files** creates four helper queries (Sample File, Parameter, Transform Sample File, Transform File) with generic names.
It works, but it is hard to read and easy to break.
One named function with comments does the same job and shows exactly what happens to each file.

## Performance notes

- London filter is applied **inside the function**, before files are combined. Around 88% of rows are dropped before anything else happens.
- Address columns are removed in the same step for the same reason.
- Full refresh reads about 1.7 GB of CSV files and takes several minutes. This is expected.

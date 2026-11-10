# Power Query

Every query in the workbook is saved here as a `.m` file, so the logic can be reviewed on GitHub without opening Excel.
The files are copies: the source of truth is the workbook. When a query changes in Excel, the `.m` file is updated in the same commit.

## Query flow

```
Settings!p_RawFolder (named cell)
        │
        ▼
  p_RawFolder ──────┐
                    ▼
            stg_sales ◄──── fx_LoadPricePaidFile (called once per file)
                    │
                    ▼
            chk_monthly ──► Checks sheet
```

## Queries

| Query | Type | What it does | Load to |
|---|---|---|---|
| `p_RawFolder` | Parameter | Reads the raw data folder path from the Settings sheet | Connection only |
| `fx_LoadPricePaidFile` | Function | Reads one CSV, names the columns, keeps London rows and the needed columns | Connection only |
| `stg_sales` | Staging | Combines all yearly files, sets data types | Connection only (Data Model from Day 4) |
| `chk_monthly` | Check | Sales count by month, category and record status | Table on `Checks` sheet |

## Naming

| Prefix | Meaning |
|---|---|
| `p_` | Parameter |
| `fx_` | Custom function |
| `stg_` | Staging: data loaded and typed, no business rules yet |
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
